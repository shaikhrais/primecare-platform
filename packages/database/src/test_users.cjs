const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  const users = await prisma.user.findMany({
    select: {
      email: true,
      roles: true
    }
  });
  console.log(`Found ${users.length} users in the database.`);
  const sample = users.slice(0, 50);
  sample.forEach(u => {
    console.log(`- ${u.email} | Roles: ${u.roles.join(', ')}`);
  });
}

main()
  .catch(e => console.error(e))
  .finally(async () => {
    await prisma.$disconnect();
  });
