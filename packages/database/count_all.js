const { PrismaClient, Prisma } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  const models = Prisma.dmmf.datamodel.models;
  const results = [];
  
  for (const model of models) {
    const fnName = model.name.charAt(0).toLowerCase() + model.name.slice(1);
    try {
      const count = await prisma[fnName].count();
      results.push({ Entity: model.name, Count: count });
    } catch (e) {
      results.push({ Entity: model.name, Count: 'ERROR' });
    }
  }
  
  console.table(results);
}

main().finally(() => prisma.$disconnect());
