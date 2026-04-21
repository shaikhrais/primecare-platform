import { PrismaClient } from './generated/client';
import * as fs from 'fs';
import * as path from 'path';

const prisma = new PrismaClient();

async function main() {
  const intentsPath = path.join(__dirname, '../../.agents/ui_intents.json');
  if (!fs.existsSync(intentsPath)) {
    console.error(`UI Intents JSON not found at ${intentsPath}`);
    process.exit(1);
  }

  const intents = JSON.parse(fs.readFileSync(intentsPath, 'utf-8'));
  console.log(`Seeding ${intents.length} UI Intents...`);

  let count = 0;
  for (const intent of intents) {
    await prisma.uIIntent.upsert({
      where: { intentId: intent.intentId },
      update: {
        enumName: intent.enumName,
        status: intent.status,
        implementationClass: intent.implementationClass,
        updatedAt: new Date(),
      },
      create: {
        enumName: intent.enumName,
        intentId: intent.intentId,
        status: intent.status,
        implementationClass: intent.implementationClass,
      },
    });
    count++;
    if (count % 50 === 0) {
      console.log(`...processed ${count} intents`);
    }
  }

  console.log(`Successfully seeded ${count} UI Intents.`);
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
