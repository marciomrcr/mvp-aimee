import { NextApiRequest, NextApiResponse } from "next";
import { prisma } from "../../../lib/prisma";

export default async function handlerCustomer(
  req: NextApiRequest,
  resp: NextApiResponse
) {
  const { method } = req;
  switch (method) {
    case "GET":
      const findCustomer = await prisma.customer.findMany({
        select: {
          people: {
            select: {
              PhysicalPerson: {
                select: {
                  name: true,
                },
              },
              LegalPerson: {
                select: {
                  name: true,
                },
              },
            },
          },
        },

        orderBy: {
          people: {
            peopleType: {
              description: "asc",
            },
          },
        },
      });
      return resp.status(200).json({ findCustomer });

    case "POST":
      const { customerId } = req.body;
      const physicalPersonExists = await prisma.customer.findUnique({
        where: {
          customerId,
        },
      });
      if (physicalPersonExists) {
        return resp
          .status(400)
          .json({ message: "Consumidor já existe no sistema!" });
      }
      const createPhysicalPerson = await prisma.customer.create({
        data: {
          customerId,
        },
      });
      return resp.status(201).json(createPhysicalPerson);
  }
}
