// import { PrismaClient } from "@prisma/client";

// export const prisma = new PrismaClient({
//   log: ["query"],
// });
import { PrismaClient } from "@prisma/client";

declare global {
  var client: PrismaClient | undefined;
}

const prisma =
  globalThis.client ||
  new PrismaClient({
    log: ["query"],
  });
if (process.env.NODE_ENV !== "production") globalThis.client = prisma;

export default prisma;
