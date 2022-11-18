import { NextApiRequest, NextApiResponse } from "next";
import { prisma } from "../../../lib/prisma";

export default async function handlerStock(
  req: NextApiRequest,
  resp: NextApiResponse
) {
  const { method } = req;
  switch (method) {
    case "GET":
      const findStock = await prisma.stock.findMany({
        select: {
          product: {
            select: {
              name: true,
            },
          },
          amount: true,
          min_stock: true,
          ReservedStock: {
            select: {
              amount: true,
            },
          },
        },
      });
      return resp.status(200).json({ findStock });

    case "POST":
      const { branchOfficeId, productId, amount, min_stock } = req.body;
      const StockExists = await prisma.stock.findUnique({
        where: {
          branchOfficeId_productId: {
            branchOfficeId,
            productId,
          },
        },
      });
      if (StockExists) {
        return resp
          .status(400)
          .json({
            message: "Produto já existe estoque! Favor alterar a quantidade!",
          });
      }
      const createStock = await prisma.stock.create({
        data: {
          branchOfficeId,
          productId,
          amount,
          min_stock,
        },
      });
      return resp.status(201).json(createStock);
  }
}
