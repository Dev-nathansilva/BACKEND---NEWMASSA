const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const getAllFornecedores = async (req, res) => {
  const {
    page = 1,
    limit = 10,
    search = "",
    status,
    dataInicial,
    dataFinal,
  } = req.query;

  const skip = (Number(page) - 1) * Number(limit);
  const take = Number(limit);
  const searchTerm = search.toLowerCase();

  const statusList = status
    ? Array.isArray(status)
      ? status.map((s) => s === "true")
      : status
          .split(",")
          .map((s) => s.trim())
          .filter((s) => s === "true" || s === "false")
          .map((s) => s === "true")
    : [];

  const dataFiltro = [];

  if (dataInicial) {
    dataFiltro.push({
      dataCadastro: { gte: new Date(dataInicial) },
    });
  }

  if (dataFinal) {
    // Considera o fim do dia
    const dataFinalCompleta = new Date(dataFinal);
    dataFinalCompleta.setHours(23, 59, 59, 999);

    dataFiltro.push({
      dataCadastro: { lte: dataFinalCompleta },
    });
  }

  const where = {
    AND: [
      {
        OR: [
          { nome: { contains: searchTerm } },
          { email: { contains: searchTerm } },
          { documento: { contains: searchTerm } },
          { telefone: { contains: searchTerm } },
          { inscricaoEstadual: { contains: searchTerm } },

          { endereco: { contains: searchTerm } },
          { cidade: { contains: searchTerm } },
          { bairro: { contains: searchTerm } },
          { complemento: { contains: searchTerm } },
          { cep: { contains: searchTerm } },

          { nomeTitular: { contains: searchTerm } },
          { chavePix: { contains: searchTerm } },
          { referenciaBancaria: { contains: searchTerm } },
        ],
      },
      ...(statusList.length === 1
        ? [{ status: { equals: statusList[0] } }]
        : []),
      ...dataFiltro,
    ],
  };

  try {
    const [fornecedores, total] = await Promise.all([
      prisma.fornecedor.findMany({
        where,
        skip,
        take,
        orderBy: { id: "desc" },
      }),
      prisma.fornecedor.count({ where }),
    ]);

    const totalPages = Math.ceil(total / limit);
    const currentPage = totalPages > 0 ? Math.min(Number(page), totalPages) : 0;

    res.json({
      data: fornecedores,
      total,
      page: currentPage,
      totalPages,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Erro ao buscar fornecedores." });
  }
};

const createFornecedor = async (req, res) => {
  const data = req.body;

  try {
    const result = await prisma.fornecedor.createMany({ data });
    res.status(201).json({
      message: "Fornecedores criados com sucesso!",
      count: result.count,
    });
  } catch (error) {
    console.error(error);
    res.status(400).json({ error: "Erro ao criar fornecedores." });
  }
};

const updateFornecedor = async (req, res) => {
  const { id } = req.params;
  const data = req.body;

  try {
    const fornecedor = await prisma.fornecedor.update({
      where: { id: Number(id) },
      data,
    });
    res.json({ message: "Fornecedor atualizado com sucesso.", fornecedor });
  } catch (error) {
    res.status(400).json({ error: "Erro ao atualizar fornecedor." });
  }
};

const deleteFornecedor = async (req, res) => {
  const { id: idsParam } = req.params;
  const ids = idsParam.split(",").map(Number);

  try {
    if (ids.length > 1) {
      await prisma.fornecedor.deleteMany({
        where: {
          id: { in: ids },
        },
      });
    } else {
      await prisma.fornecedor.delete({
        where: { id: ids[0] },
      });
    }

    res.status(204).send();
  } catch (error) {
    console.error(error);
    res.status(400).json({ error: "Erro ao deletar fornecedor(es)." });
  }
};

module.exports = {
  getAllFornecedores,
  createFornecedor,
  updateFornecedor,
  deleteFornecedor,
};
