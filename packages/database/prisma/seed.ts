// Governance - Category: service | Purpose: Call the new Universal Seeder
import { PrismaClient } from '../generated/client';
import { main as seedEverything } from './seed_everything';

const prisma = new PrismaClient();

async function main() {
  console.log('🌱 Starting Global Hydration Cycle...');
  
  // Call the new Universal Seeder
  await seedEverything();

  console.log('✅ Hydration cycle complete.');
}

main()
  .catch((e) => {
    console.error('❌ Hydration error:');
    console.error(e.message || e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
