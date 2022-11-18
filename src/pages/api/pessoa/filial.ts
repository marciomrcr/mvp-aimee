import { NextApiRequest, NextApiResponse } from "next";
import { prisma } from "../../../lib/prisma";

export default async function handlerSupplier(
  req: NextApiRequest,
  resp: NextApiResponse
) {
  const { method } = req;
  switch (method) {
    case "GET":
      const findBranchOffice = await prisma.branchOffice.findMany({
        include: {
          people: {
            select: {
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
            peopleType: { description: "asc" },
          },
        },
      });
      return resp.status(200).json({ findBranchOffice });

    case "POST":
      const { branchOfficeId } = req.body;
      const branchOfficeIdExists = await prisma.branchOffice.findUnique({
        where: {
          branchOfficeId,
        },
      });
      if (branchOfficeIdExists) {
        return resp
          .status(400)
          .json({ message: "Filial já existe no sistema!" });
      }
      const createSupplier = await prisma.branchOffice.create({
        data: {
          branchOfficeId,
        },
      });
      return resp.status(201).json(createSupplier);
  }
}
