import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

async function main() {
  const role = await prisma.brand.create({
    data: {
      name: "Mizuno",
    },
  });

  const category = await prisma.category.create({
    data: {
      name: "Calçados Masculinos",
      description: "Calçados esportivos",
    },
  });

  const product = await prisma.product.create({
    data: {
      category: {
        connect: {
          id: category.id,
        },
      },
      brand: {
        connect: {
          name: "Mizuno",
        },
      },
      name: "Tênis Mizuno Wave Titan 2",
      description: "Tênis Masculino para caminhada",
    },
  });
  // const poll = await prisma.poll.create({
  //   data: {
  //     title: "Bolão 01",
  //     code: "BOL001",
  //     ownerId: user.id,
  //     participants: {
  //       create: {
  //         userId: user.id,
  //       },
  //     },
  //   },
  // });

  // await prisma.game.create({
  //   data: {
  //     date: "2022-11-04T16:05:53.449Z",
  //     firstTeamCountryCode: "BR",
  //     secondTeamCountryCode: "DE",
  //   },
  // });

  // await prisma.game.create({
  //   data: {
  //     date: "2022-11-04T16:05:53.449Z",
  //     firstTeamCountryCode: "BR",
  //     secondTeamCountryCode: "AR",
  //     guesses: {
  //       create: {
  //         firstTeamPoint: 2,
  //         secondTeamPoint: 0,
  //         participants: {
  //           connect: {
  //             userId_pollId: {
  //               userId: user.id,
  //               pollId: poll.id,
  //             },
  //           },
  //         },
  //       },
  //     },
  //   },
  // });
}
main();
