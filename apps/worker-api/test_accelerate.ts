import { PrismaClient } from './generated/client/edge.js';
import { withAccelerate } from '@prisma/extension-accelerate';

// Removing the username to see if Prisma Accelerate natively accepts the API key as the only credential
const dbUrl = "prisma+postgres://sk_cj7PFouwLgmoCsO-0ZOSI@db.prisma.io:5432/postgres?sslmode=require";

async function main() {
  console.log("Connecting with accelerate and API key only...");
  const prisma = new PrismaClient({ datasourceUrl: dbUrl }).$extends(withAccelerate());
  
  try {
      const users = await prisma.user.findMany({ take: 1 });
      console.log("Users:", users);
  } catch (err) {
      console.error("Error:", err);
  }
}

main().catch(console.error);
