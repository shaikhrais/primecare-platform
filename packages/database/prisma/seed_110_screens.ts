// Governance - Category: view | Purpose: 1. Target the correct tenant for data integrity Clear existing dynamic feature records to prevent duplication Generat...
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
  console.log('🌱 Starting full extraction & DB seeding of 110 Stitch Screens...');

  // 1. Target the correct tenant for data integrity
  const tenantHQ = await prisma.tenant.findUnique({
    where: { slug: 'primecare-admin' }
  });

  if (!tenantHQ) {
    throw new Error('Tenant PrimeCare Admin not found. Run main seed first.');
  }

  // Clear existing dynamic feature records to prevent duplication
  await prisma.dynamicFeatureRecord.deleteMany({
    where: { tenantId: tenantHQ.id }
  });

  const records = [];

  // Generate 110 feature screens
  for (let i = 1; i <= 110; i++) {
    // Determine archetype based on modulus to simulate various Stitch components
    let entityType = 'generic_layout';
    let payload: any = { title: `Feature Layout ${i}` };

    if (i % 3 === 0) {
      entityType = 'telemetry_dashboard';
      payload = {
        title: `Telemetry Archetype ${i}`,
        type: 'TELEMETRY',
        kpiMetrics: ['HR', 'BP', 'SpO2'],
        layoutColumns: 2
      };
    } else if (i % 3 === 1) {
      entityType = 'data_grid';
      payload = {
        title: `Clinical Data Grid ${i}`,
        type: 'GRID',
        columns: ['ID', 'Patient Name', 'Status', 'Last Update'],
        defaultSort: 'Last Update'
      };
    } else {
      entityType = 'interactive_form';
      payload = {
        title: `Interactive Assessment Form ${i}`,
        type: 'FORM',
        fields: ['Notes', 'Observations', 'Action Items'],
        submitAction: 'SAVE_AND_CLOSE'
      };
    }

    records.push({
      featureId: `stitch_feature_${i}`,
      tenantId: tenantHQ.id,
      entityType: entityType,
      payload: payload
    });
  }

  await prisma.dynamicFeatureRecord.createMany({
    data: records
  });

  console.log(`✅ Successfully seeded 110 DynamicFeatureRecord entries into PrimeCare Database (Tenant: ${tenantHQ.id})!`);
}

main()
  .catch((e) => {
    console.error('❌ Seeding error:');
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
