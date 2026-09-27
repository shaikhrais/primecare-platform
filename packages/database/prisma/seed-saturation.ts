// Governance - Category: service | Purpose: Step 1: Pre-load common FK caches to guarantee referential integrity Common aliases
import { PrismaClient, Prisma } from '../generated/client';
import { faker } from '@faker-js/faker';

const prisma = new PrismaClient();

async function main() {
  console.log('🚀 Starting Deep Saturation DMMF Seeder...');
  
  const models = Prisma.dmmf.datamodel.models;
  const fkCache: Record<string, string[]> = {};

  // Step 1: Pre-load common FK caches to guarantee referential integrity
  console.log('📦 Pre-loading Foreign Key caches...');
  for (const m of models) {
    const propertyName = m.name.charAt(0).toLowerCase() + m.name.slice(1);
    try {
      if (prisma[propertyName] && typeof prisma[propertyName].findMany === 'function') {
        const records = await prisma[propertyName].findMany({ select: { id: true }, take: 100 });
        fkCache[m.name] = records.map((r: any) => r.id);
      }
    } catch(e) {}
  }

  // Common aliases
  fkCache['User'] = fkCache['User'] || [];
  fkCache['Tenant'] = fkCache['Tenant'] || [];
  fkCache['ClientProfile'] = fkCache['ClientProfile'] || [];
  fkCache['ProviderProfile'] = fkCache['ProviderProfile'] || [];

  const aliasMap: Record<string, string> = {
    'userId': 'User',
    'tenantId': 'Tenant',
    'ownerUserId': 'User',
    'senderUserId': 'User',
    'reporterUserId': 'User',
    'reviewerId': 'User',
    'clientId': 'ClientProfile',
    'patientId': 'ClientProfile',
    'providerId': 'ProviderProfile',
    'staffId': 'User',
    'rnId': 'User'
  };

  function getFk(fieldName: string): string | null {
    const targetModel = aliasMap[fieldName];
    if (targetModel && fkCache[targetModel]?.length > 0) {
      return faker.helpers.arrayElement(fkCache[targetModel]);
    }
    // Try to guess by removing 'Id' and capitalizing
    if (fieldName.endsWith('Id')) {
      const g = fieldName.slice(0, -2);
      const guessModel = g.charAt(0).toUpperCase() + g.slice(1);
      if (fkCache[guessModel]?.length > 0) {
         return faker.helpers.arrayElement(fkCache[guessModel]);
      }
    }
    // fallback
    return fkCache['User']?.[0] || '1';
  }

  function generateFakeData(field: any): any {
     if (field.isList) return [];
     if (field.kind === 'enum') return field.enumValues?.[0]?.name || 'Active';
     
     if (field.type === 'String') {
         if (field.name.includes('email')) return faker.internet.email();
         if (field.name.includes('name') || field.name.includes('Name')) return faker.person.fullName();
         if (field.name.includes('url') || field.name.includes('Url')) return faker.internet.url();
         return faker.lorem.word();
     }
     if (field.type === 'Int' || field.type === 'Float' || field.type === 'Decimal') return faker.number.int({ min: 1, max: 100 });
     if (field.type === 'Boolean') return faker.datatype.boolean();
     if (field.type === 'DateTime') return new Date();
     if (field.type === 'Json') return "{}";
     return null;
  }

  // Step 2: Seed missing tables
  let totalSeededInCycle = 0;
  let cycle = 1;
  const maxCycles = 5;

  do {
    totalSeededInCycle = 0;
    console.log(`\n--- Starting Cycle ${cycle} ---`);
    for (const m of models) {
      const propertyName = m.name.charAt(0).toLowerCase() + m.name.slice(1);
      
      try {
        const modelDelegate = (prisma as any)[propertyName];
        if (!modelDelegate || !modelDelegate.count) continue;
        
        const count = await modelDelegate.count();
        if (count < 10) {
          let successCount = 0;
          
          for (let i = count; i < 10; i++) {
             const data: any = {};
             
             for (const f of m.fields) {
               if (f.name === 'id') continue;
               if (f.kind === 'object') continue;
               
               if (f.name.endsWith('Id') || f.name.endsWith('_id')) {
                  const relField = m.fields.find((rf: any) => rf.kind === 'object' && rf.relationFromFields?.includes(f.name));
                  if (relField) {
                    const targetModel = relField.type;
                    if (fkCache[targetModel] && fkCache[targetModel].length > 0) {
                        data[f.name] = faker.helpers.arrayElement(fkCache[targetModel]);
                    } else {
                        throw new Error(`Missing pre-requisite targetModel: ${targetModel}`);
                    }
                    continue;
                  } else {
                    const fk = getFk(f.name);
                    if (fk) data[f.name] = fk;
                    continue;
                  }
               }
               
               if (f.isRequired && !f.hasDefaultValue) {
                 data[f.name] = generateFakeData(f);
               } else if (!f.isRequired && Math.random() > 0.5) {
                 data[f.name] = generateFakeData(f);
               }
             }
             
             try {
               const created = await modelDelegate.create({ data });
               if (!fkCache[m.name]) fkCache[m.name] = [];
               fkCache[m.name].push(created.id);
               successCount++;
               totalSeededInCycle++;
             } catch(e: any) {
               if (cycle === maxCycles) {
                  console.error(`   [Cycle ${cycle} Error for ${m.name}]: ${e.message.split('\n').pop()}`);
               }
             }
          }
          if (successCount > 0) {
              console.log(`   ✅ Seeded ${successCount} additional rows into ${m.name}`);
          }
        }
      } catch (e) {}
    }
    cycle++;
  } while (totalSeededInCycle > 0 && cycle <= maxCycles);

  console.log('🎉 Deep Saturation cycle complete!');
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
