// Governance - Category: service | Purpose: Verification script for platform screens status and audit metadata
import { PrismaClient } from './generated/client';

const prisma = new PrismaClient();

async function main() {
  console.log('\n=== VERIFYING PLATFORM SCREENS STATUS AND AUDIT METRICS ===');
  
  const screens = await prisma.platformScreen.findMany({
    orderBy: { orderIndex: 'asc' },
    include: {
      role: true,
    }
  });

  console.log(`Found ${screens.length} platform screens in the database:\n`);
  
  console.log(''.padEnd(110, '-'));
  console.log(
    `${'Role'.padEnd(20)} | ${'Screen Name'.padEnd(25)} | ${'Dev Status'.padEnd(12)} | ${'Audit Status'.padEnd(18)} | ${'Audit Date'}`
  );
  console.log(''.padEnd(110, '-'));

  for (const screen of screens) {
    const roleName = screen.role?.name || 'Unknown';
    const auditDateStr = screen.auditDate ? screen.auditDate.toISOString().split('T')[0] : 'N/A';
    console.log(
      `${roleName.padEnd(20)} | ${screen.name.padEnd(25)} | ${screen.status.padEnd(12)} | ${screen.auditStatus.padEnd(18)} | ${auditDateStr}`
    );
  }
  console.log(''.padEnd(110, '-'));
}

main()
  .catch(console.error)
  .finally(() => prisma.$disconnect());
