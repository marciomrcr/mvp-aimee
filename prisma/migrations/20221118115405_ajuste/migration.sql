-- CreateEnum
CREATE TYPE "Role" AS ENUM ('USER', 'ADMIN');

-- CreateTable
CREATE TABLE "usuarios" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT,
    "role" "Role" NOT NULL DEFAULT 'USER',
    "status" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateddAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "usuarios_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pessoas" (
    "id" TEXT NOT NULL,
    "peopleTypeId" TEXT NOT NULL,

    CONSTRAINT "pessoas_pkey" PRIMARY KEY ("id","peopleTypeId")
);

-- CreateTable
CREATE TABLE "tipo_pessoas" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "tipo_pessoas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pessoa_fisica" (
    "id" TEXT NOT NULL,
    "isCustomer" BOOLEAN NOT NULL DEFAULT true,
    "isSupllier" BOOLEAN NOT NULL DEFAULT false,
    "name" TEXT NOT NULL,
    "cpf" CHAR(11),
    "identity" CHAR(10),
    "birthDate" DATE,
    "whatsApp" CHAR(11) NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT true,
    "creditLimit" DECIMAL(7,2) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateddAt" TIMESTAMP(3) NOT NULL,
    "peopleId" TEXT NOT NULL,
    "peoplePeopleTypeId" TEXT NOT NULL,

    CONSTRAINT "pessoa_fisica_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pessoa_juridica" (
    "id" TEXT NOT NULL,
    "isSupllier" BOOLEAN NOT NULL DEFAULT true,
    "isCustomer" BOOLEAN NOT NULL DEFAULT false,
    "name" TEXT NOT NULL,
    "contactName" TEXT,
    "cnpj" CHAR(10),
    "whatsApp" TEXT,
    "email" TEXT NOT NULL,
    "instagram" TEXT,
    "stateRegistration" CHAR(14),
    "foundingDate" DATE NOT NULL,
    "pixkey" TEXT,
    "creditLimit" DECIMAL(7,2) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateddAt" TIMESTAMP(3) NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT true,
    "peopleId" TEXT NOT NULL,
    "peoplePeopleTypeId" TEXT NOT NULL,

    CONSTRAINT "pessoa_juridica_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "marcas" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "manufacturer" TEXT,
    "description" TEXT,
    "status" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateddAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "marcas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "categorias" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "status" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateddAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "categorias_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "produtos" (
    "id" TEXT NOT NULL,
    "categoryId" TEXT NOT NULL,
    "brandId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "size" TEXT,
    "colors" TEXT,
    "status" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "produtos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "estoque" (
    "id" TEXT NOT NULL,
    "productId" TEXT NOT NULL,
    "amount" INTEGER NOT NULL,
    "min_stock" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateddAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "estoque_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "estoque_reservado" (
    "reservedStockId" TEXT NOT NULL,
    "productId" TEXT NOT NULL,
    "amount" INTEGER NOT NULL,

    CONSTRAINT "estoque_reservado_pkey" PRIMARY KEY ("reservedStockId")
);

-- CreateTable
CREATE TABLE "movimento_estoque" (
    "id" TEXT NOT NULL,
    "productId" TEXT NOT NULL,
    "entryOutput" CHAR(1) NOT NULL,
    "amount" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateddAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "movimento_estoque_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "operacoes" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "operacoes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "status_venda" (
    "id" TEXT NOT NULL,
    "descripion" TEXT NOT NULL,

    CONSTRAINT "status_venda_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "vendas" (
    "id" TEXT NOT NULL,
    "operationId" TEXT NOT NULL,
    "saleStatusId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateddAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "vendas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "itens_vendidos" (
    "saleId" TEXT NOT NULL,
    "productId" TEXT NOT NULL,
    "mount" INTEGER NOT NULL,
    "unitPrice" DECIMAL(7,2) NOT NULL,
    "discount" DECIMAL(7,2) NOT NULL,
    "sum_total" DECIMAL(7,2) NOT NULL,

    CONSTRAINT "itens_vendidos_pkey" PRIMARY KEY ("saleId","productId")
);

-- CreateTable
CREATE TABLE "itens_comprados" (
    "purchaseId" TEXT NOT NULL,
    "productId" TEXT NOT NULL,
    "mount" INTEGER NOT NULL,
    "unitPrice" DECIMAL(7,2) NOT NULL,
    "discount" DECIMAL(7,2) NOT NULL,
    "sum_total" DECIMAL(7,2) NOT NULL,
    "barCode" TEXT,

    CONSTRAINT "itens_comprados_pkey" PRIMARY KEY ("purchaseId","productId")
);

-- CreateTable
CREATE TABLE "precos" (
    "productId" TEXT NOT NULL,
    "PurchasePrice" DECIMAL(7,2) NOT NULL,
    "saleprice" DECIMAL(7,2) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "precos_pkey" PRIMARY KEY ("productId")
);

-- CreateTable
CREATE TABLE "compras" (
    "id" TEXT NOT NULL,
    "operationId" TEXT NOT NULL,
    "saleOrderStatusId" TEXT NOT NULL,
    "deliveryForecast" DATE NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "compras_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "receitas" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "status" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "receitas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "despesas" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "status" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "despesas_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "usuarios_email_key" ON "usuarios"("email");

-- CreateIndex
CREATE INDEX "usuarios_name_idx" ON "usuarios"("name");

-- CreateIndex
CREATE UNIQUE INDEX "tipo_pessoas_name_key" ON "tipo_pessoas"("name");

-- CreateIndex
CREATE UNIQUE INDEX "pessoa_fisica_name_key" ON "pessoa_fisica"("name");

-- CreateIndex
CREATE UNIQUE INDEX "pessoa_fisica_whatsApp_key" ON "pessoa_fisica"("whatsApp");

-- CreateIndex
CREATE INDEX "pessoa_fisica_name_idx" ON "pessoa_fisica"("name");

-- CreateIndex
CREATE UNIQUE INDEX "pessoa_juridica_name_key" ON "pessoa_juridica"("name");

-- CreateIndex
CREATE UNIQUE INDEX "pessoa_juridica_cnpj_key" ON "pessoa_juridica"("cnpj");

-- CreateIndex
CREATE UNIQUE INDEX "pessoa_juridica_whatsApp_key" ON "pessoa_juridica"("whatsApp");

-- CreateIndex
CREATE UNIQUE INDEX "pessoa_juridica_email_key" ON "pessoa_juridica"("email");

-- CreateIndex
CREATE UNIQUE INDEX "pessoa_juridica_instagram_key" ON "pessoa_juridica"("instagram");

-- CreateIndex
CREATE UNIQUE INDEX "pessoa_juridica_stateRegistration_key" ON "pessoa_juridica"("stateRegistration");

-- CreateIndex
CREATE UNIQUE INDEX "pessoa_juridica_pixkey_key" ON "pessoa_juridica"("pixkey");

-- CreateIndex
CREATE INDEX "pessoa_juridica_name_idx" ON "pessoa_juridica"("name");

-- CreateIndex
CREATE UNIQUE INDEX "marcas_name_key" ON "marcas"("name");

-- CreateIndex
CREATE INDEX "marcas_name_idx" ON "marcas"("name");

-- CreateIndex
CREATE UNIQUE INDEX "categorias_name_key" ON "categorias"("name");

-- CreateIndex
CREATE UNIQUE INDEX "produtos_name_key" ON "produtos"("name");

-- CreateIndex
CREATE INDEX "produtos_name_idx" ON "produtos"("name");

-- CreateIndex
CREATE UNIQUE INDEX "itens_comprados_barCode_key" ON "itens_comprados"("barCode");

-- CreateIndex
CREATE UNIQUE INDEX "receitas_name_key" ON "receitas"("name");

-- CreateIndex
CREATE UNIQUE INDEX "despesas_name_key" ON "despesas"("name");

-- AddForeignKey
ALTER TABLE "pessoas" ADD CONSTRAINT "pessoas_peopleTypeId_fkey" FOREIGN KEY ("peopleTypeId") REFERENCES "tipo_pessoas"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pessoa_fisica" ADD CONSTRAINT "pessoa_fisica_peopleId_peoplePeopleTypeId_fkey" FOREIGN KEY ("peopleId", "peoplePeopleTypeId") REFERENCES "pessoas"("id", "peopleTypeId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pessoa_juridica" ADD CONSTRAINT "pessoa_juridica_peopleId_peoplePeopleTypeId_fkey" FOREIGN KEY ("peopleId", "peoplePeopleTypeId") REFERENCES "pessoas"("id", "peopleTypeId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "produtos" ADD CONSTRAINT "produtos_brandId_fkey" FOREIGN KEY ("brandId") REFERENCES "marcas"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "produtos" ADD CONSTRAINT "produtos_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "categorias"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "estoque" ADD CONSTRAINT "estoque_productId_fkey" FOREIGN KEY ("productId") REFERENCES "produtos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "estoque_reservado" ADD CONSTRAINT "estoque_reservado_productId_fkey" FOREIGN KEY ("productId") REFERENCES "produtos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "estoque_reservado" ADD CONSTRAINT "estoque_reservado_reservedStockId_fkey" FOREIGN KEY ("reservedStockId") REFERENCES "estoque"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "movimento_estoque" ADD CONSTRAINT "movimento_estoque_productId_fkey" FOREIGN KEY ("productId") REFERENCES "produtos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vendas" ADD CONSTRAINT "vendas_operationId_fkey" FOREIGN KEY ("operationId") REFERENCES "operacoes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vendas" ADD CONSTRAINT "vendas_saleStatusId_fkey" FOREIGN KEY ("saleStatusId") REFERENCES "status_venda"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "itens_vendidos" ADD CONSTRAINT "itens_vendidos_saleId_fkey" FOREIGN KEY ("saleId") REFERENCES "vendas"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "itens_vendidos" ADD CONSTRAINT "itens_vendidos_productId_fkey" FOREIGN KEY ("productId") REFERENCES "produtos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "itens_comprados" ADD CONSTRAINT "itens_comprados_purchaseId_fkey" FOREIGN KEY ("purchaseId") REFERENCES "compras"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "itens_comprados" ADD CONSTRAINT "itens_comprados_productId_fkey" FOREIGN KEY ("productId") REFERENCES "produtos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "precos" ADD CONSTRAINT "precos_productId_fkey" FOREIGN KEY ("productId") REFERENCES "produtos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "compras" ADD CONSTRAINT "compras_operationId_fkey" FOREIGN KEY ("operationId") REFERENCES "operacoes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "compras" ADD CONSTRAINT "compras_saleOrderStatusId_fkey" FOREIGN KEY ("saleOrderStatusId") REFERENCES "status_venda"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
