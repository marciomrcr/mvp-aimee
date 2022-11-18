import { NextApiRequest, NextApiResponse } from "next";
import { prisma } from "../../../lib/prisma";

export default async function handlerProduct(
  req: NextApiRequest,
  resp: NextApiResponse
) {
  const { method } = req;
  switch (method) {
    case "GET":
      const findProducts = await prisma.product.findMany({
        select: {
          name: true,
          id: true,
          brand: {
            select: {
              name: true,
            },
          },
          category: {
            select: {
              name: true,
            },
          },
        },
      });
      return resp.status(200).json({ findProducts });

    case "POST":
      const { categoryId, brandId, name, description, size, colors } = req.body;
      const productExists = await prisma.product.findUnique({
        where: {
          name,
        },
      });
      if (productExists) {
        return resp.status(400).json({
          message: "Já existe um produto cadastrado com esse nome no sistema!",
        });
      }
      const createProduct = await prisma.product.create({
        data: {
          categoryId,
          brandId,
          name,
          description,
          size,
          colors,
        },
      });
      return resp.status(201).json(createProduct);
  }
}
