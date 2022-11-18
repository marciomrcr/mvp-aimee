import { NextApiRequest, NextApiResponse } from "next";
import { prisma } from "../../../lib/prisma";

export default async function handlerLegalPerson(
  req: NextApiRequest,
  resp: NextApiResponse
) {
  const { method } = req;
  switch (method) {
    case "GET":
      const findLegalPerson = await prisma.legalPerson.findMany({
        select: {
          name: true,
          whatsApp: true,
          contactName: true,
          legalPersonId: true,
        },
        orderBy: {
          name: "asc",
        },
      });
      return resp.status(200).json({ findLegalPerson });

    case "POST":
      const {
        legalPersonId,
        name,
        cnpj,
        contactName,
        whatsApp,
        email,
        foundingDate,
        creditLimit,
        pixkey,
      } = req.body;
      const legalPersonExists = await prisma.legalPerson.findUnique({
        where: {
          name,
        },
      });
      const legalPersonIdExists = await prisma.legalPerson.findUnique({
        where: {
          legalPersonId,
        },
      });
      if (legalPersonIdExists) {
        return resp
          .status(400)
          .json({ message: "Código já existe no sistema!" });
      }
      if (legalPersonExists) {
        return resp
          .status(400)
          .json({ message: "Fornecedor já existe no sistema!" });
      }
      const createLegalPerson = await prisma.legalPerson.create({
        data: {
          legalPersonId,
          name,
          cnpj,
          contactName,
          whatsApp,
          email,
          creditLimit,
          foundingDate,
          pixkey,
        },
      });
      return resp.status(201).json(createLegalPerson);
  }
}
