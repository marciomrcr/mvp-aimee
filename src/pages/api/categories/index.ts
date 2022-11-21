import { NextApiRequest, NextApiResponse } from "next";
import { prisma } from "../../../lib/prisma";

export default async function handlerCategory(
  req: NextApiRequest,
  resp: NextApiResponse
) {
  const { method } = req;
  switch (method) {
    case "GET":
      const findCategories = await prisma.category.findMany({
        select: {
          name: true,
          id: true,
        },
      });
      return resp.status(200).json({ findCategories });

    case "POST":
      const { name, description } = req.body;
      const categoryExists = await prisma.category.findUnique({
        where: {
          name,
        },
      });
      if (categoryExists) {
        return resp.status(400).json({
          message:
            "Já existe uma categoria cadastrada com esse nome no sistema!",
        });
      }
      const createCategory = await prisma.category.create({
        data: {
          name,
          description,
        },
      });

      return resp.status(201).json(createCategory);
  }
}
