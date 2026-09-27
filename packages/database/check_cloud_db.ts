// Governance - Category: service | Purpose: Sample the first 3 to verify data consistency
import { PrismaClient } from './generated/client';

const prisma = new PrismaClient();

async function main() {
  const dbUrl = process.env.DATABASE_URL || '';
  const host = dbUrl.split('@')[1]?.split(':')[0] || 'unknown';
  
  console.log(`🔍 Verifying connection to host: ${host}`);
  
  try {
    const count = await prisma.uIIntent.count();
    console.log(`✅ Connection successful.`);
    console.log(`📊 Current UIIntent count: ${count}`);
    
    if (count === 527) {
      console.log('✨ Cloud DB is fully synchronized (527 intents found).');
    } else {
      console.log(`⚠️  Warning: Expected 527 intents, but found ${count}.`);
    }

    // Sample the first 3 to verify data consistency
    const samples = await prisma.uIIntent.findMany({
      take: 3,
      select: { enumName: true, status: true, implementationClass: true }
    });
    console.log('🧬 Sample Data:', JSON.stringify(samples, null, 2));

  } catch (error) {
    console.error('❌ Database verification failed:', error);
    process.exit(1);
  } finally {
    await prisma.$disconnect();
  }
}

main();
