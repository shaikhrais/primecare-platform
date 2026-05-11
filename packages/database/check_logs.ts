import { PrismaClient } from './generated/client';

const prisma = new PrismaClient();

async function main() {
  const logs = await prisma.verificationLog.findMany({
    take: 5,
    orderBy: { verifiedAt: 'desc' }
  });
  console.log('--- RECENT VERIFICATION LOGS ---');
  console.log(JSON.stringify(logs, null, 2));
}

main()
  .catch(console.error)
  .finally(() => prisma.$disconnect());
