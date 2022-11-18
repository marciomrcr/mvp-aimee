/*
  Warnings:

  - The primary key for the `consumidor` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `peopleTypeId` on the `consumidor` table. All the data in the column will be lost.
  - The primary key for the `fornecedor` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `peopleTypeId` on the `fornecedor` table. All the data in the column will be lost.
  - The primary key for the `pessoa_fisica` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `peopleId` on the `pessoa_fisica` table. All the data in the column will be lost.
  - The primary key for the `pessoa_juridica` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `peopleId` on the `pessoa_juridica` table. All the data in the column will be lost.
  - Added the required column `customerId` to the `consumidor` table without a default value. This is not possible if the table is not empty.
  - Added the required column `supplierId` to the `fornecedor` table without a default value. This is not possible if the table is not empty.
  - Added the required column `physicalPersonId` to the `pessoa_fisica` table without a default value. This is not possible if the table is not empty.
  - Added the required column `legalPersonId` to the `pessoa_juridica` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "consumidor" DROP CONSTRAINT "consumidor_peopleTypeId_fkey";

-- DropForeignKey
ALTER TABLE "fornecedor" DROP CONSTRAINT "fornecedor_peopleTypeId_fkey";

-- DropForeignKey
ALTER TABLE "pessoa_fisica" DROP CONSTRAINT "pessoa_fisica_peopleId_fkey";

-- DropForeignKey
ALTER TABLE "pessoa_juridica" DROP CONSTRAINT "pessoa_juridica_peopleId_fkey";

-- AlterTable
ALTER TABLE "consumidor" DROP CONSTRAINT "consumidor_pkey",
DROP COLUMN "peopleTypeId",
ADD COLUMN     "customerId" TEXT NOT NULL,
ADD CONSTRAINT "consumidor_pkey" PRIMARY KEY ("customerId");

-- AlterTable
ALTER TABLE "fornecedor" DROP CONSTRAINT "fornecedor_pkey",
DROP COLUMN "peopleTypeId",
ADD COLUMN     "supplierId" TEXT NOT NULL,
ADD CONSTRAINT "fornecedor_pkey" PRIMARY KEY ("supplierId");

-- AlterTable
ALTER TABLE "pessoa_fisica" DROP CONSTRAINT "pessoa_fisica_pkey",
DROP COLUMN "peopleId",
ADD COLUMN     "physicalPersonId" TEXT NOT NULL,
ADD CONSTRAINT "pessoa_fisica_pkey" PRIMARY KEY ("physicalPersonId");

-- AlterTable
ALTER TABLE "pessoa_juridica" DROP CONSTRAINT "pessoa_juridica_pkey",
DROP COLUMN "peopleId",
ADD COLUMN     "legalPersonId" TEXT NOT NULL,
ADD CONSTRAINT "pessoa_juridica_pkey" PRIMARY KEY ("legalPersonId");

-- CreateTable
CREATE TABLE "filial" (
    "branchOfficeId" TEXT NOT NULL,

    CONSTRAINT "filial_pkey" PRIMARY KEY ("branchOfficeId")
);

-- AddForeignKey
ALTER TABLE "consumidor" ADD CONSTRAINT "consumidor_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "pessoas"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fornecedor" ADD CONSTRAINT "fornecedor_supplierId_fkey" FOREIGN KEY ("supplierId") REFERENCES "pessoas"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "filial" ADD CONSTRAINT "filial_branchOfficeId_fkey" FOREIGN KEY ("branchOfficeId") REFERENCES "pessoas"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pessoa_fisica" ADD CONSTRAINT "pessoa_fisica_physicalPersonId_fkey" FOREIGN KEY ("physicalPersonId") REFERENCES "pessoas"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pessoa_juridica" ADD CONSTRAINT "pessoa_juridica_legalPersonId_fkey" FOREIGN KEY ("legalPersonId") REFERENCES "pessoas"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
