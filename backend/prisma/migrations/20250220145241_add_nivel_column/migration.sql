-- AlterTable
ALTER TABLE `User` ADD COLUMN `nivel` ENUM('admin', 'vendedor', 'padrao') NOT NULL DEFAULT 'padrao';
