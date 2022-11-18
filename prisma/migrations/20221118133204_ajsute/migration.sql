/*
  Warnings:

  - The primary key for the `pessoa_fisica` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `pessoa_fisica` table. All the data in the column will be lost.
  - You are about to drop the column `peoplePeopleTypeId` on the `pessoa_fisica` table. All the data in the column will be lost.
  - The primary key for the `pessoa_juridica` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `pessoa_juridica` table. All the data in the column will be lost.
  - You are about to drop the column `peoplePeopleTypeId` on the `pessoa_juridica` table. All the data in the column will be lost.
  - The primary key for the `pessoas` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the `tipo_pessoas` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "pessoa_fisica" DROP CONSTRAINT "pessoa_fisica_peopleId_peoplePeopleTypeId_fkey";

-- DropForeignKey
ALTER TABLE "pessoa_juridica" DROP CONSTRAINT "pessoa_juridica_peopleId_peoplePeopleTypeId_fkey";

-- DropForeignKey
ALTER TABLE "pessoas" DROP CONSTRAINT "pessoas_peopleTypeId_fkey";

-- AlterTable
ALTER TABLE "pessoa_fisica" DROP CONSTRAINT "pessoa_fisica_pkey",
DROP COLUMN "id",
DROP COLUMN "peoplePeopleTypeId",
ADD CONSTRAINT "pessoa_fisica_pkey" PRIMARY KEY ("peopleId");

-- AlterTable
ALTER TABLE "pessoa_juridica" DROP CONSTRAINT "pessoa_juridica_pkey",
DROP COLUMN "id",
DROP COLUMN "peoplePeopleTypeId",
ADD CONSTRAINT "pessoa_juridica_pkey" PRIMARY KEY ("peopleId");

-- AlterTable
ALTER TABLE "pessoas" DROP CONSTRAINT "pessoas_pkey",
ADD CONSTRAINT "pessoas_pkey" PRIMARY KEY ("id");

-- DropTable
DROP TABLE "tipo_pessoas";

-- CreateTable
CREATE TABLE "PeopleType" (
    "id" TEXT NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "PeopleType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "consumidor" (
    "peopleTypeId" TEXT NOT NULL,

    CONSTRAINT "consumidor_pkey" PRIMARY KEY ("peopleTypeId")
);

-- CreateTable
CREATE TABLE "fornecedor" (
    "peopleTypeId" TEXT NOT NULL,

    CONSTRAINT "fornecedor_pkey" PRIMARY KEY ("peopleTypeId")
);

-- CreateIndex
CREATE UNIQUE INDEX "PeopleType_description_key" ON "PeopleType"("description");

-- AddForeignKey
ALTER TABLE "pessoas" ADD CONSTRAINT "pessoas_peopleTypeId_fkey" FOREIGN KEY ("peopleTypeId") REFERENCES "PeopleType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "consumidor" ADD CONSTRAINT "consumidor_peopleTypeId_fkey" FOREIGN KEY ("peopleTypeId") REFERENCES "PeopleType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fornecedor" ADD CONSTRAINT "fornecedor_peopleTypeId_fkey" FOREIGN KEY ("peopleTypeId") REFERENCES "PeopleType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pessoa_fisica" ADD CONSTRAINT "pessoa_fisica_peopleId_fkey" FOREIGN KEY ("peopleId") REFERENCES "pessoas"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pessoa_juridica" ADD CONSTRAINT "pessoa_juridica_peopleId_fkey" FOREIGN KEY ("peopleId") REFERENCES "pessoas"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
