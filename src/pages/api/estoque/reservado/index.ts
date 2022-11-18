import { NextApiRequest, NextApiResponse } from "next";
import { prisma } from "../../../../lib/prisma";

export default async function handlerReservedStock(
  req: NextApiRequest,
  resp: NextApiResponse
) {
  const { method } = req;
  switch (method) {
    case "GET":
      const findReservedStock = await prisma.reservedStock.findMany({
        select: {
          stock: {
            include: {
              product: {
                select: {
                  name: true,
                },
              },
            },
          },
          amount: true,
        },
      });
      return resp.status(200).json({ findReservedStock });

    case "POST":
      const { branchOfficeId, productId, amount } = req.body;
      const reservedStockExists = await prisma.reservedStock.findUnique({
        where: {
          branchOfficeId_productId: {
            branchOfficeId,
            productId,
          },
        },
      });
      if (reservedStockExists) {
        return resp.status(400).json({
          message: "Produto já possui reserva! Favor alterar a quantidade!",
        });
      }
      const createReservedStock = await prisma.reservedStock.create({
        data: {
          branchOfficeId,
          productId,
          amount,
        },
      });
      return resp.status(201).json(createReservedStock);
  }
}
