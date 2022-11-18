/*
  Warnings:

  - The primary key for the `estoque` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `estoque` table. All the data in the column will be lost.
  - The primary key for the `estoque_reservado` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `reservedStockId` on the `estoque_reservado` table. All the data in the column will be lost.
  - You are about to drop the `compras` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `itens_comprados` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `itens_vendidos` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `vendas` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `branchOfficeId` to the `estoque` table without a default value. This is not possible if the table is not empty.
  - Added the required column `branchOfficeId` to the `estoque_reservado` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updateddAt` to the `estoque_reservado` table without a default value. This is not possible if the table is not empty.
  - Added the required column `branchOfficeId` to the `movimento_estoque` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "compras" DROP CONSTRAINT "compras_operationId_fkey";

-- DropForeignKey
ALTER TABLE "compras" DROP CONSTRAINT "compras_saleOrderStatusId_fkey";

-- DropForeignKey
ALTER TABLE "estoque_reservado" DROP CONSTRAINT "estoque_reservado_productId_fkey";

-- DropForeignKey
ALTER TABLE "estoque_reservado" DROP CONSTRAINT "estoque_reservado_reservedStockId_fkey";

-- DropForeignKey
ALTER TABLE "itens_comprados" DROP CONSTRAINT "itens_comprados_productId_fkey";

-- DropForeignKey
ALTER TABLE "itens_comprados" DROP CONSTRAINT "itens_comprados_purchaseId_fkey";

-- DropForeignKey
ALTER TABLE "itens_vendidos" DROP CONSTRAINT "itens_vendidos_productId_fkey";

-- DropForeignKey
ALTER TABLE "itens_vendidos" DROP CONSTRAINT "itens_vendidos_saleId_fkey";

-- DropForeignKey
ALTER TABLE "vendas" DROP CONSTRAINT "vendas_operationId_fkey";

-- DropForeignKey
ALTER TABLE "vendas" DROP CONSTRAINT "vendas_saleStatusId_fkey";

-- AlterTable
ALTER TABLE "estoque" DROP CONSTRAINT "estoque_pkey",
DROP COLUMN "id",
ADD COLUMN     "branchOfficeId" TEXT NOT NULL,
ADD CONSTRAINT "estoque_pkey" PRIMARY KEY ("branchOfficeId", "productId");

-- AlterTable
ALTER TABLE "estoque_reservado" DROP CONSTRAINT "estoque_reservado_pkey",
DROP COLUMN "reservedStockId",
ADD COLUMN     "branchOfficeId" TEXT NOT NULL,
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updateddAt" TIMESTAMP(3) NOT NULL,
ADD CONSTRAINT "estoque_reservado_pkey" PRIMARY KEY ("branchOfficeId", "productId");

-- AlterTable
ALTER TABLE "movimento_estoque" ADD COLUMN     "branchOfficeId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "pessoa_juridica" ALTER COLUMN "cnpj" SET DATA TYPE CHAR(14);

-- DropTable
DROP TABLE "compras";

-- DropTable
DROP TABLE "itens_comprados";

-- DropTable
DROP TABLE "itens_vendidos";

-- DropTable
DROP TABLE "vendas";

-- CreateTable
CREATE TABLE "venda" (
    "id" TEXT NOT NULL,
    "operationId" TEXT NOT NULL,
    "operationStatusId" TEXT NOT NULL,
    "emitterId" TEXT NOT NULL,
    "customerId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateddAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "venda_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pedido_compra" (
    "id" TEXT NOT NULL,
    "operationId" TEXT NOT NULL,
    "operationStatusId" TEXT NOT NULL,
    "branchOfficeId" TEXT NOT NULL,
    "supplierId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateddAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "pedido_compra_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "iten_Pedido_venda" (
    "orderSaleId" TEXT NOT NULL,
    "productId" TEXT NOT NULL,
    "mount" INTEGER NOT NULL,
    "unitPrice" DECIMAL(7,2) NOT NULL,
    "discount" DECIMAL(7,2) NOT NULL DEFAULT 0,
    "sum_total" DECIMAL(7,2) NOT NULL,

    CONSTRAINT "iten_Pedido_venda_pkey" PRIMARY KEY ("orderSaleId","productId")
);

-- AddForeignKey
ALTER TABLE "estoque" ADD CONSTRAINT "estoque_branchOfficeId_fkey" FOREIGN KEY ("branchOfficeId") REFERENCES "filial"("branchOfficeId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "estoque_reservado" ADD CONSTRAINT "estoque_reservado_branchOfficeId_productId_fkey" FOREIGN KEY ("branchOfficeId", "productId") REFERENCES "estoque"("branchOfficeId", "productId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "movimento_estoque" ADD CONSTRAINT "movimento_estoque_branchOfficeId_fkey" FOREIGN KEY ("branchOfficeId") REFERENCES "filial"("branchOfficeId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "venda" ADD CONSTRAINT "venda_emitterId_fkey" FOREIGN KEY ("emitterId") REFERENCES "filial"("branchOfficeId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "venda" ADD CONSTRAINT "venda_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "consumidor"("customerId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "venda" ADD CONSTRAINT "venda_operationId_fkey" FOREIGN KEY ("operationId") REFERENCES "operacoes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "venda" ADD CONSTRAINT "venda_operationStatusId_fkey" FOREIGN KEY ("operationStatusId") REFERENCES "status_venda"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pedido_compra" ADD CONSTRAINT "pedido_compra_branchOfficeId_fkey" FOREIGN KEY ("branchOfficeId") REFERENCES "filial"("branchOfficeId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pedido_compra" ADD CONSTRAINT "pedido_compra_operationId_fkey" FOREIGN KEY ("operationId") REFERENCES "operacoes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pedido_compra" ADD CONSTRAINT "pedido_compra_operationStatusId_fkey" FOREIGN KEY ("operationStatusId") REFERENCES "status_venda"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pedido_compra" ADD CONSTRAINT "pedido_compra_supplierId_fkey" FOREIGN KEY ("supplierId") REFERENCES "fornecedor"("supplierId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "iten_Pedido_venda" ADD CONSTRAINT "iten_Pedido_venda_orderSaleId_fkey" FOREIGN KEY ("orderSaleId") REFERENCES "venda"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "iten_Pedido_venda" ADD CONSTRAINT "iten_Pedido_venda_productId_fkey" FOREIGN KEY ("productId") REFERENCES "produtos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
