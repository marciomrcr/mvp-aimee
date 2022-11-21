import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

async function main() {
  const role = await prisma.brand.create({
    data: {
      name: "Adidas",
    },
  });

  const category = await prisma.category.create({
    data: {
      name: "Moda Fitness",
      description: "Confecções para homens",
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
          name: "Adidas",
        },
      },
      name: "Camisa Manga Curta UV",
      description: "Cry cool e uv",
    },
  });
}
main();
