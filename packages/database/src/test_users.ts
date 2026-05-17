import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();

async function main() {
  const users = await prisma.user.findMany({
    select: {
      email: true,
      roles: true
    }
  });
  console.log(`Found ${users.length} users in the database:`);
  users.forEach((u: { email: string; roles: string[] }) => {
    console.log(`- ${u.email} | Roles: ${u.roles.join(', ')}`);
  });
}

main()
  .catch(e => console.error(e))
  .finally(async () => {
    await prisma.$disconnect();
  });
