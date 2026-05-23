// Governance - Category: service | Purpose: Core implementation file for the Check Plans platform logic.
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function run() {
  const missing = await prisma.screenFunctionality.findMany({
    where: {
      OR: [
        { status: 'unimplemented' },
        { apiEndpoint: { equals: null } }
      ]
    },
    include: {
      screen: {
        select: { name: true }
      }
    }
  });

  console.log(`Found \${missing.length} missing implementation functions:`);
  missing.forEach(m => console.log(`- \${m.title} (on \${m.screen.name}): \${m.justification || 'No justification'}`));
}

run();
