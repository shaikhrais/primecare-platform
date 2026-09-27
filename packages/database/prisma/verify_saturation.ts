// Governance - Category: service | Purpose: Get all models from the prisma object (skipping internal ones)
import { PrismaClient } from '../generated/client';

const prisma = new PrismaClient();

async function main() {
  console.log('🔍 Auditing Database Saturation...');
  
  // Get all models from the prisma object (skipping internal ones)
  const models = Object.keys(prisma).filter(key => 
    !key.startsWith('_') && 
    !key.startsWith('$') && 
    typeof (prisma as any)[key].count === 'function'
  );

  let emptyTables = 0;
  let totalTables = models.length;

  for (const model of models) {
    const count = await (prisma as any)[model].count();
    if (count === 0) {
      console.warn(`⚠️ [EMPTY] ${model}: 0 records`);
      emptyTables++;
    } else {
      console.log(`✅ [OK] ${model}: ${count} records`);
    }
  }

  console.log('\n--- Saturation Report ---');
  console.log(`Total Tables: ${totalTables}`);
  console.log(`Populated:    ${totalTables - emptyTables}`);
  console.log(`Empty:        ${emptyTables}`);
  
  if (emptyTables > 0) {
    process.exit(1);
  }
}

main()
  .catch(e => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
