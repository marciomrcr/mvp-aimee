import { NextApiRequest, NextApiResponse } from "next";
import { prisma } from "../../../lib/prisma";

export default async function handlerSupplier(
  req: NextApiRequest,
  resp: NextApiResponse
) {
  const { method } = req;
  switch (method) {
    case "GET":
      const findSupplier = await prisma.supplier.findMany({
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
      return resp.status(200).json({ findSupplier });

    case "POST":
      const { supplierId } = req.body;
      const SupplierExists = await prisma.supplier.findUnique({
        where: {
          supplierId,
        },
      });
      if (SupplierExists) {
        return resp
          .status(400)
          .json({ message: "Consumidor já existe no sistema!" });
      }
      const createSupplier = await prisma.supplier.create({
        data: {
          supplierId,
        },
      });
      return resp.status(201).json(createSupplier);
  }
}
