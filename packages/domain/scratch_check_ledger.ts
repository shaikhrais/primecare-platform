import { LedgerService } from './src/services/LedgerService';
import { PrismaClient } from '@primecare/database';

const prisma = new PrismaClient();

async function checkAccounts() {
    const tenant = await prisma.tenant.findFirst();
    if (!tenant) throw new Error('No tenant');

    const codes = ['1010', '6100', '6200', '6300', '2100'];
    console.log('Checking accounts for tenant:', tenant.id);
    
    for (const code of codes) {
        const acc = await prisma.chartOfAccount.findFirst({
            where: { tenantId: tenant.id, code }
        });
        if (acc) {
            console.log(`✅ Found account ${code}: ${acc.name}`);
        } else {
            console.log(`❌ Missing account ${code}`);
        }
    }
}

checkAccounts()
    .catch(console.error)
    .finally(() => prisma.$disconnect());
