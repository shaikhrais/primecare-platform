import { PrismaClient, Prisma } from './generated/client';

const prisma = new PrismaClient();

async function main() {
  console.log('--- DATABASE STATUS ---');
  console.log('Using endpoint: ' + (process.env.DATABASE_URL || '').replace(/:[^:]*@/, ':***@')); // Hide password
  
  if ((process.env.DATABASE_URL || '').includes('localhost')) {
    console.log('❌ WARNING: Connected to a LOCAL database!');
  } else {
    console.log('✅ Confirmed: Connected to REMOTE/PRODUCTION database! (No local)');
  }
  
  console.log('\n--- PRISMA TABLES ROW COUNTS ---');
  const models = Prisma.dmmf.datamodel.models;
  let totalRows = 0;
  
  const results = [];
  
  for (const model of models) {
    const modelName = model.name;
    const propertyName = modelName.charAt(0).toLowerCase() + modelName.slice(1);
    
    try {
      const prismaDelegate = (prisma as any)[propertyName];
      if (prismaDelegate && typeof prismaDelegate.count === 'function') {
        const count = await prismaDelegate.count();
        results.push({ table: modelName, count });
        totalRows += count;
      }
    } catch (e) {
      results.push({ table: modelName, count: 'Error' });
    }
  }
  
  // Sort by name
  results.sort((a, b) => a.table.localeCompare(b.table));
  
  for (const res of results) {
    const paddedName = res.table.padEnd(30, ' ');
    console.log(`${paddedName} : ${res.count} rows`);
  }
  
  console.log(`\nTotal rows across all tables: ${totalRows}`);
}

main()
  .catch(console.error)
  .finally(() => prisma.$disconnect());
