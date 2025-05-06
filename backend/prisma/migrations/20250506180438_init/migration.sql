-- CreateTable
CREATE TABLE `User` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `nivel` VARCHAR(191) NOT NULL DEFAULT 'Padrão',
    `fotoPerfil` VARCHAR(191) NULL,
    `telefone` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `passwordResetToken` VARCHAR(191) NULL,
    `passwordResetExpires` DATETIME(3) NULL,

    UNIQUE INDEX `User_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Cliente` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(191) NOT NULL,
    `tipo` VARCHAR(191) NOT NULL,
    `documento` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `telefone` VARCHAR(191) NOT NULL,
    `inscricaoEstadual` VARCHAR(191) NULL,
    `status` BOOLEAN NOT NULL DEFAULT true,
    `endereco` VARCHAR(191) NULL DEFAULT 'Não informado',
    `complemento` VARCHAR(191) NULL,
    `cidade` VARCHAR(191) NULL DEFAULT 'Não informado',
    `bairro` VARCHAR(191) NULL DEFAULT 'Não informado',
    `cep` VARCHAR(191) NULL DEFAULT '00000-000',
    `credito` DOUBLE NULL DEFAULT 0.0,
    `observacoes` VARCHAR(191) NULL,
    `dataCadastro` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Fornecedor` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(191) NOT NULL,
    `documento` VARCHAR(191) NOT NULL,
    `cidade` VARCHAR(191) NOT NULL,
    `status` BOOLEAN NOT NULL DEFAULT true,
    `email` VARCHAR(191) NOT NULL,
    `telefone` VARCHAR(191) NOT NULL,
    `inscricaoEstadual` VARCHAR(191) NULL,
    `endereco` VARCHAR(191) NULL,
    `complemento` VARCHAR(191) NULL,
    `bairro` VARCHAR(191) NULL,
    `cep` VARCHAR(191) NULL,
    `referenciaBancaria` VARCHAR(191) NULL,
    `chavePix` VARCHAR(191) NULL,
    `nomeTitular` VARCHAR(191) NULL,
    `limiteCredito` DOUBLE NULL,
    `condicoesPagamento` VARCHAR(191) NULL,
    `observacoes` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Vendedor` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `telefone` VARCHAR(191) NOT NULL,
    `comissao` DOUBLE NOT NULL,
    `status` BOOLEAN NOT NULL DEFAULT true,
    `observacoes` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Funcionario` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `telefone` VARCHAR(191) NOT NULL,
    `observacoes` VARCHAR(191) NULL,
    `cargo` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Produto` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `codigoSKU` VARCHAR(191) NULL,
    `descricao` VARCHAR(191) NOT NULL,
    `unidade` VARCHAR(191) NOT NULL,
    `estoque` INTEGER NOT NULL,
    `dataValidade` DATETIME(3) NULL,
    `formato` VARCHAR(191) NOT NULL,
    `precoCusto` DOUBLE NOT NULL,
    `margemLucro` DOUBLE NOT NULL,
    `precoVenda` DOUBLE NOT NULL,
    `codigoBarrasGTIN` VARCHAR(191) NOT NULL,
    `status` BOOLEAN NOT NULL DEFAULT true,
    `observacoes` VARCHAR(191) NULL,
    `origem` VARCHAR(191) NULL,
    `ncm` VARCHAR(191) NULL,
    `cest` VARCHAR(191) NULL,
    `csosn` VARCHAR(191) NULL,
    `icmsInterno` DOUBLE NULL,
    `baseCalculo` DOUBLE NULL,
    `ipi` DOUBLE NULL,
    `cstPis` VARCHAR(191) NULL,
    `cstCofins` VARCHAR(191) NULL,
    `pesoBruto` DOUBLE NULL,
    `pesoLiquido` DOUBLE NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Composicao` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `produtoId` INTEGER NOT NULL,
    `componenteId` INTEGER NOT NULL,
    `quantidade` DOUBLE NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `FornecedorProduto` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `produtoId` INTEGER NOT NULL,
    `fornecedorId` INTEGER NOT NULL,

    UNIQUE INDEX `FornecedorProduto_produtoId_fornecedorId_key`(`produtoId`, `fornecedorId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Composicao` ADD CONSTRAINT `Composicao_produtoId_fkey` FOREIGN KEY (`produtoId`) REFERENCES `Produto`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Composicao` ADD CONSTRAINT `Composicao_componenteId_fkey` FOREIGN KEY (`componenteId`) REFERENCES `Produto`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `FornecedorProduto` ADD CONSTRAINT `FornecedorProduto_produtoId_fkey` FOREIGN KEY (`produtoId`) REFERENCES `Produto`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `FornecedorProduto` ADD CONSTRAINT `FornecedorProduto_fornecedorId_fkey` FOREIGN KEY (`fornecedorId`) REFERENCES `Fornecedor`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
