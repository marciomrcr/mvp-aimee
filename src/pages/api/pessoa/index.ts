import { NextApiRequest, NextApiResponse } from "next";
import { prisma } from "../../../lib/prisma";

export default async function handlerPeople(
  req: NextApiRequest,
  resp: NextApiResponse
) {
  const { method } = req;
  switch (method) {
    case "GET":
      const findPeople = await prisma.people.findMany();
      return resp.status(200).json({ findPeople });

    case "POST":
      const { peopleTypeId } = req.body;
      const peopleExists = await prisma.people.findUnique({
        where: {
          id: peopleTypeId,
        },
      });
      if (peopleExists) {
        return resp
          .status(400)
          .json({ message: "Pessoa já existe no sistema!" });
      }
      const createPeople = await prisma.people.create({
        data: {
          peopleTypeId,
        },
      });
      return resp.status(201).json(createPeople);
  }
}
