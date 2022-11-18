import { NextApiRequest, NextApiResponse } from "next";
import { prisma } from "../../../lib/prisma";

export default async function handlerPhysicalPerson(
  req: NextApiRequest,
  resp: NextApiResponse
) {
  const { method } = req;
  switch (method) {
    case "GET":
      const findPhysicalPerson = await prisma.physicalPerson.findMany({
        select: {
          name: true,
          whatsApp: true,
          physicalPersonId: true,
        },

        orderBy: {
          name: "asc",
        },
      });
      return resp.status(200).json({ findPhysicalPerson });

    case "POST":
      const {
        physicalPersonId,
        name,
        cpf,
        identity,
        birthDate,
        whatsApp,
        creditLimit,
      } = req.body;
      const physicalPersonIdExists = await prisma.physicalPerson.findUnique({
        where: {
          physicalPersonId,
        },
      });
      if (physicalPersonIdExists) {
        return resp
          .status(400)
          .json({ message: "Código já existe no sistema!" });
      }

      const physicalPersonExists = await prisma.physicalPerson.findUnique({
        where: {
          name: name,
        },
      });
      if (physicalPersonExists) {
        return resp
          .status(400)
          .json({ message: "Pessoa já existe no sistema!" });
      }
      const createPhysicalPerson = await prisma.physicalPerson.create({
        data: {
          physicalPersonId,
          name,
          cpf,
          identity,
          birthDate,
          whatsApp,
          creditLimit,
        },
      });
      return resp.status(201).json(createPhysicalPerson);
  }
}
