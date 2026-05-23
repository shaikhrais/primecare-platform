// Governance - Category: service | Purpose: Get all model names from the prisma client Prisma doesn't expose a clean list of models easily without a helper But w...
import { PrismaClient } from '../generated/client';

const prisma = new PrismaClient();

async function main() {
  console.log('🧹 Purging PrimeCare Database - High Security Wipe...');

  if (process.env.ALLOW_WIPE !== 'true') {
    console.error('❌ ACCESS DENIED: Set ALLOW_WIPE=true to perform a database purge.');
    process.exit(1);
  }

  // Get all model names from the prisma client
  // Prisma doesn't expose a clean list of models easily without a helper
  // But we can extract them from the property names that are not prefixed with $
  const modelNames = Object.keys(prisma).filter(
    (key) => !key.startsWith('_') && !key.startsWith('$')
  );

  console.log(`🔍 Found ${modelNames.length} models to truncate.`);

  // Disable triggers/constraints for raw truncate if possible, or just delete in order
  // For PostgreSQL, TRUNCATE with CASCADE is efficient
  for (const modelName of modelNames) {
    try {
      // Convert modelName to table name (Prisma convention is usually camelCase -> snake_case or just the name)
      // Since we are using raw queries, we need to be careful.
      // Alternatively, we can use prisma[modelName].deleteMany({})
      console.log(`   Removing all records from: ${modelName}...`);
      await (prisma as any)[modelName].deleteMany({});
    } catch (e) {
      console.warn(`   ⚠️ Could not wipe ${modelName}: ${(e as Error).message}`);
    }
  }

  console.log('✅ Recovery Complete: Database is now a clean state.');
}

main()
  .catch((e) => {
    console.error('❌ Wipe failed:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
