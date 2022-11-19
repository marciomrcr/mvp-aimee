import { NextApiRequest, NextApiResponse } from "next";
import { prisma } from "../../../lib/prisma";

export default async function handlerOrderSale(
  req: NextApiRequest,
  resp: NextApiResponse
) {
  const { method } = req;
  switch (method) {
    case "GET":
      const findOrderSale = await prisma.orderSale.findMany({
        select: {
          id: true,
          operation: {
            select: {
              name: true,
            },
          },
          operationStatus: {
            select: {
              descripion: true,
            },
          },
          customer: {
            select: {
              people: {
                select: {
                  peopleType: {
                    select: {
                      description: true,
                    },
                  },
                },
              },
            },
          },
        },
      });
      return resp.status(200).json({ findOrderSale });

    case "POST":
      const { operationId, operationStatusId, emitterId, customerId } =
        req.body;
      if (!operationId || !operationStatusId || !emitterId || !customerId) {
        return resp.status(200).json({
          message: "Todos os campos devem ser preenchidos",
        });
      }
      const orderOperationIdExists = await prisma.operation.findUnique({
        where: {
          id: operationId,
        },
      });
      const operationStatusIdExists = await prisma.operationStatus.findUnique({
        where: {
          id: operationStatusId,
        },
      });
      const emitterIdExists = await prisma.branchOffice.findUnique({
        where: {
          branchOfficeId: emitterId,
        },
      });
      const customerIdExists = await prisma.customer.findUnique({
        where: {
          customerId,
        },
      });

      if (!orderOperationIdExists) {
        return resp.status(400).json({
          message: "Operação não cadastrada!",
        });
      }
      if (!operationStatusIdExists) {
        return resp.status(400).json({
          message: "Status não cadastrado!",
        });
      }
      if (!emitterIdExists) {
        return resp.status(400).json({
          message: "Filial não cadastrada!",
        });
      }
      if (!customerIdExists) {
        return resp.status(400).json({
          message: "Consumidor não cadastrado!",
        });
      }

      const createOrderSale = await prisma.orderSale.create({
        data: {
          operationId,
          operationStatusId,
          emitterId,
          customerId,
        },
      });
      return resp.status(201).json(createOrderSale);
  }
}
