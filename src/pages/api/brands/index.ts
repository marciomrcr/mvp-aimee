import { NextApiRequest, NextApiResponse } from "next";
import { prisma } from "../../../lib/prisma";

export default async function handlerBrand(
  req: NextApiRequest,
  resp: NextApiResponse
) {
  const { method } = req;
  switch (method) {
    case "GET":
      const findBrands = await prisma.brand.findMany({
        select: {
          name: true,
          description: true,
          id: true,
        },
      });
      return resp.status(200).json({ findBrands });

    case "POST":
      const { name, description } = req.body;
      const brandExists = await prisma.brand.findUnique({
        where: {
          name,
        },
      });
      if (brandExists) {
        return resp
          .status(400)
          .json({ message: "Essa marca já existe no sistema!" });
      }
      const createBrand = await prisma.brand.create({
        data: {
          name,
          description,
        },
      });
      return resp.status(201).json(createBrand);
  }
}
