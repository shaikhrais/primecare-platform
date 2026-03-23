const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
    const users = await prisma.user.findMany({
        select: {
            email: true,
            roles: true,
            status: true,
            createdAt: true
        }
    });
    console.log("----- PRODUCTION USERS LIST -----");
    console.table(users.map(u => ({
        ...u,
        roles: JSON.stringify(u.roles)
    })));
    console.log("---------------------------------");
}

main()
  .catch(e => {
    console.error('Prisma connection failed:', e);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
