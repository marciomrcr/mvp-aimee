import { NextApiRequest, NextApiResponse } from "next";
import { prisma } from "../../../lib/prisma";

export default async function handlerOrderSaleItems(
  req: NextApiRequest,
  resp: NextApiResponse
) {
  const { method } = req;
  switch (method) {
    case "GET":
      const findOrderSaleItems = await prisma.orderSaleItems.findMany({});
      return resp.status(200).json({ findOrderSaleItems });

    case "POST":
      const { orderSaleId, productId, mount, unitPrice, discount, sum_total } =
        req.body;

      if (!orderSaleId || !productId || !mount || !unitPrice || !sum_total) {
        return resp.status(200).json({
          message: "Todos os campos devem ser preenchidos",
        });
      }

      const itemExists = await prisma.orderSaleItems.findUnique({
        where: {
          orderSaleId_productId: {
            orderSaleId,
            productId,
          },
        },
      });
      if (itemExists) {
        return resp.status(200).json({
          message: "Produto já existe nesta venda!",
        });
      }

      const orderSaleIddExists = await prisma.orderSale.findUnique({
        where: {
          id: orderSaleId,
        },
      });
      const productIdExists = await prisma.product.findUnique({
        where: {
          id: productId,
        },
      });

      if (!orderSaleIddExists) {
        return resp.status(400).json({
          message: "Pedido não cadastrado!",
        });
      }
      if (!productIdExists) {
        return resp.status(400).json({
          message: "Produto não cadastrado!",
        });
      }
      if (!mount || mount <= 0) {
        return resp.status(400).json({
          message: "Quantidade tem que ser maior que zero!",
        });
      }
      if (!sum_total || sum_total <= 0) {
        return resp.status(400).json({
          message: "O valor da soma não pode ser zero!",
        });
      }

      const createOrderSaleItems = await prisma.orderSaleItems.create({
        data: {
          orderSaleId,
          productId,
          mount,
          unitPrice,
          discount,
          sum_total,
        },
      });
      return resp.status(201).json(createOrderSaleItems);
  }
}
