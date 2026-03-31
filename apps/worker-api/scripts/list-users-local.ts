import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient({
    datasourceUrl: "postgres://postgres:primecare_local_password@localhost:5432/primecare_db"
});

async function main() {
    console.log("Connecting directly to local default PostgreSQL cluster over TCP...");
    const users = await prisma.user.findMany({
        select: { id: true, email: true, roles: true, status: true, tenantId: true }
    });
    console.table(users);
    console.log(`Successfully retrieved ${users.length} accounts!`);
}

main()
  .catch(e => console.error("FATAL:", e.message))
  .finally(() => prisma.$disconnect());
