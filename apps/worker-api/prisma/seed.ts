import { FinancialService } from '../src/_shared/services/financial.service';
import { prisma, seedDomainEntities, seedLogistics, seedAuditLogs } from './seed-helpers';

async function main() {
    console.log('🌱 Seeding database...');
    const financialService = new FinancialService(prisma as any);

    // 1. Create Tenants
    const tenantA = await prisma.tenant.upsert({ where: { slug: 'prime-toronto' }, update: {}, create: { name: 'PrimeCare Toronto', slug: 'prime-toronto', status: 'active', allowedVpnRanges: '', corsAllowedOrigins: '', corsAllowedMethods: '', corsAllowedHeaders: '' } });
    const tenantHQ = await prisma.tenant.upsert({ where: { slug: 'primecare-admin' }, update: {}, create: { name: 'PrimeCare Admin', slug: 'primecare-admin', status: 'active', allowedVpnRanges: '', corsAllowedOrigins: '', corsAllowedMethods: '', corsAllowedHeaders: '' } });
    await prisma.tenant.upsert({ where: { slug: 'prime-vancouver' }, update: {}, create: { name: 'PrimeCare Vancouver', slug: 'prime-vancouver', status: 'active', allowedVpnRanges: '', corsAllowedOrigins: '', corsAllowedMethods: '', corsAllowedHeaders: '' } });

    // 2. Initialize Chart of Accounts
    await financialService.initializeChartOfAccounts(tenantA.id);
    const dbAccounts = await prisma.chartOfAccount.findMany({ where: { tenantId: tenantA.id } });
    const acctMap: Record<string, string> = {};
    for (const a of dbAccounts) acctMap[a.code] = a.id;

    // 3. Create Users & Profiles
    const roles = ['admin', 'manager', 'staff', 'rn', 'psw', 'client', 'scrum_master', 'finance_director'];
    for (const role of roles) {
        const email = `${role}.a@primecare.ca`;
        const targetTenantId = ['admin', 'scrum_master', 'finance_director'].includes(role) ? tenantHQ.id : tenantA.id;
        const user = await prisma.user.upsert({ where: { email }, update: {}, create: { email, passwordHash: '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', roles: role, tenantId: targetTenantId, status: 'active' } });
        if (role === 'client') await prisma.clientProfile.upsert({ where: { userId: user.id }, update: {}, create: { userId: user.id, tenantId: tenantA.id, fullName: 'John Client A' } });
        else if (role === 'psw') await prisma.pswProfile.upsert({ where: { userId: user.id }, update: {}, create: { userId: user.id, tenantId: tenantA.id, fullName: 'Walker PSW A', languages: '', serviceAreas: '', skills: '' } });
    }

    // 4. Financial transactions
    console.log('📊 Creating financial transactions...');
    const tx1 = await prisma.financialTransaction.create({ data: { tenantId: tenantA.id, type: 'INVOICE', amount: 1130.00, currency: 'CAD', status: 'posted' } });
    await prisma.journalEntry.createMany({ data: [
        { tenantId: tenantA.id, transactionId: tx1.id, accountId: acctMap['1100'], debit: 1130.00, currency: 'CAD' },
        { tenantId: tenantA.id, transactionId: tx1.id, accountId: acctMap['4000'], paidOutAmount: 1000.00, currency: 'CAD' },
        { tenantId: tenantA.id, transactionId: tx1.id, accountId: acctMap['2100'], paidOutAmount: 130.00, currency: 'CAD' },
    ] });
    const tx2 = await prisma.financialTransaction.create({ data: { tenantId: tenantA.id, type: 'EXPENSE', amount: 500.00, currency: 'CAD', status: 'posted' } });
    await prisma.journalEntry.createMany({ data: [
        { tenantId: tenantA.id, transactionId: tx2.id, accountId: acctMap['5200'], debit: 500.00, currency: 'CAD' },
        { tenantId: tenantA.id, transactionId: tx2.id, accountId: acctMap['1000'], paidOutAmount: 500.00, currency: 'CAD' },
    ] });

    // 5. Bank Transaction
    await prisma.bankTransaction.create({ data: { tenantId: tenantA.id, amount: 1130.00, currency: 'CAD', description: 'DEP: INVOICE #1001', bankDate: new Date(), status: 'unreconciled', externalRef: 'BANK_TX_001' } });

    // 6. Services
    await prisma.service.upsert({ where: { slug: 'personal-care' }, update: {}, create: { name: 'Personal Care', slug: 'personal-care', baseRateHourly: 35.0, tenantId: tenantA.id, isActive: true } });

    // 7-9. Domain entities, logistics, audit (extracted)
    await seedDomainEntities(tenantA.id);
    await seedLogistics(tenantA.id);
    await seedAuditLogs(tenantHQ.id, tenantA.id);

    console.log('✅ Seeding complete.');
}

main()
    .catch((e) => { console.error('❌ Seeding error:'); console.error(e.message || e); })
    .finally(async () => { await prisma.$disconnect(); });
