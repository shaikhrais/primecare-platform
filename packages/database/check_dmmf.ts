import { PrismaClient, Prisma } from './generated/client';

const prisma = new PrismaClient();

async function main() {
  const models = Prisma.dmmf.datamodel.models;
  console.log(`Analyzing ${models.length} models for required scalar fields without default values...`);
  
  const fkNames = new Set();
  
  for (const m of models) {
    const requiredScalars = m.fields.filter(f => f.kind === 'scalar' && f.isRequired && !f.hasDefaultValue && f.name !== 'id');
    for (const f of requiredScalars) {
      if (f.name.endsWith('Id')) {
        fkNames.add(f.name);
      }
    }
  }
  
  console.log('Foreign key fields needed:', Array.from(fkNames));
}

main().finally(() => prisma.$disconnect());
