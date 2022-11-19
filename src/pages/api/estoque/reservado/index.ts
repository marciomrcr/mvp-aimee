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
      if (!branchOfficeId || !productId || !amount) {
        return resp.status(200).json({
          message: "Todos os campos devem ser preenchidos",
        });
      }
      const reservedStockExists = await prisma.reservedStock.findUnique({
        where: {
          branchOfficeId_productId: {
            branchOfficeId,
            productId,
          },
        },
      });

      if (reservedStockExists) {
        // return resp.status(400).json({
        //   message: "Produto já possui reserva! Favor alterar a quantidade",
        // });
        const post = await prisma.reservedStock.update({
          where: {
            branchOfficeId_productId: {
              productId,
              branchOfficeId,
            },
          },

          data: { amount: amount },
        });

        return resp.status(200).json({
          message: "Reserva do Produto atualizada para: " + post.amount,
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
