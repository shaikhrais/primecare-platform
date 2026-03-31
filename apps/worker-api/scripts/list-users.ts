import { PrismaClient } from '@prisma/client';
import { withAccelerate } from '@prisma/extension-accelerate';

// Wrap the client with the Prisma Accelerate extension
// This is strictly required when the DATABASE_URL points to db.prisma.io!
const prisma = new PrismaClient().$extends(withAccelerate());

async function main() {
    console.log("Fetching users from Accelerate database...");
    const users = await prisma.user.findMany({
        select: { id: true, email: true, roles: true, status: true, tenantId: true }
    });
    console.table(users);
    console.log(`Successfully retrieved ${users.length} users!`);
}

main()
  .catch(e => console.error("FATAL:", e))
  .finally(() => prisma.$disconnect());
