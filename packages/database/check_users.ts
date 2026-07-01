import { PrismaClient } from './generated/client';

const prisma = new PrismaClient();

async function main() {
  console.log('--- USER TABLE ACCOUNTS ---');
  const users = await prisma.user.findMany({
    select: {
      id: true,
      email: true,
      roles: true,
      status: true,
    },
  });
  console.log(`Total users in DB: ${users.length}`);
  users.forEach((u) => {
    console.log(`ID: ${u.id} | Email: ${u.email} | Roles: ${u.roles} | Status: ${u.status}`);
  });
}

main()
  .catch(console.error)
  .finally(() => prisma.$disconnect());
