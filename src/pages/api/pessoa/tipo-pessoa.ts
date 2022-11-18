import { NextApiRequest, NextApiResponse } from "next";
import { prisma } from "../../../lib/prisma";

export default async function handlerPeopleType(
  req: NextApiRequest,
  resp: NextApiResponse
) {
  const { method } = req;
  switch (method) {
    case "GET":
      const findPeopleType = await prisma.peopleType.findMany({
        select: {
          description: true,
          id: true,
        },
        orderBy: {
          description: "asc",
        },
      });
      return resp.status(200).json({ findPeopleType });
    case "POST":
      const { description } = req.body;
      const peopleTypeExists = await prisma.peopleType.findUnique({
        where: {
          description,
        },
      });
      if (peopleTypeExists) {
        return resp
          .status(400)
          .json({ message: "Tipo de pessoa já existe no sistema!" });
      }
      const createPeopleType = await prisma.peopleType.create({
        data: {
          description,
        },
      });
      return resp.status(201).json(createPeopleType);
  }
}
