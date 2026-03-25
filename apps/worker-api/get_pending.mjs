import { PrismaClient } from './generated/client/index.js';
import fs from 'fs';

const prisma = new PrismaClient();

async function main() {
  const pending = await prisma.screenFunctionality.findMany({
    where: {
      status: { not: 'fully_tested' }
    },
    include: {
      screen: {
        include: {
          role: true
        }
      }
    },
    orderBy: {
      orderIndex: 'asc'
    }
  });

  fs.writeFileSync('C:/tmp/pending_tasks.json', JSON.stringify(pending, null, 2));
}

main()
  .catch(e => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
