import { PrismaClient, Role } from '../generated/client';
import { FinancialService } from '../src/_shared/services/financial.service';
import { Decimal } from 'decimal.js';

const prisma = new PrismaClient();

async function main() {
    console.log('🌱 Seeding database...');
    const financialService = new FinancialService(prisma as any);

    // 1. Create Tenants
    const tenantA = await prisma.tenant.upsert({
        where: { slug: 'prime-toronto' },
        update: { taxPercentage: 13.0 },
        create: { name: 'PrimeCare Toronto', slug: 'prime-toronto', status: 'active', taxPercentage: 13.0 }
    });

    const tenantHQ = await prisma.tenant.upsert({
        where: { slug: 'primecare-admin' },
        update: {},
        create: { name: 'PrimeCare Admin', slug: 'primecare-admin', status: 'active' }
    });

    const tenantB = await prisma.tenant.upsert({
        where: { slug: 'prime-vancouver' },
        update: {},
        create: { name: 'PrimeCare Vancouver', slug: 'prime-vancouver', status: 'active' }
    });

    // 2. Initialize Chart of Accounts for Tenant A
    await financialService.initializeChartOfAccounts(tenantA.id);

    // 3. Create Users & Profiles
    const roles: Role[] = ['admin', 'manager', 'staff', 'rn', 'psw', 'client', 'scrum_master', 'finance_director'];

    for (const role of roles) {
        const email = `${role}.a@primecare.ca`;
        const targetTenantId = ['admin', 'scrum_master', 'finance_director'].includes(role) ? tenantHQ.id : tenantA.id;

        const user = await prisma.user.upsert({
            where: { email },
            update: {},
            create: {
                email,
                passwordHash: '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9',
                roles: [role],
                tenantId: targetTenantId,
                status: 'active'
            }
        });

        if (role === 'client') {
            await prisma.clientProfile.upsert({
                where: { userId: user.id },
                update: {},
                create: {
                    userId: user.id,
                    tenantId: tenantA.id,
                    fullName: 'John Client A'
                }
            });
        } else if (role === 'psw') {
            await prisma.pswProfile.upsert({
                where: { userId: user.id },
                update: {},
                create: {
                    userId: user.id,
                    tenantId: tenantA.id,
                    fullName: 'Walker PSW A',
                    isApproved: true
                }
            });
        }
    }

    // 4. Create sample financial data for Tenant A
    console.log('📊 Creating financial transactions...');

    // Revenue Transaction
    const tx1 = await prisma.financialTransaction.create({
        data: {
            tenantId: tenantA.id,
            type: 'INVOICE',
            amount: 1130.00,
            currency: 'CAD',
            description: 'Monthly Care Service - Invoice #1001',
            status: 'posted',
            date: new Date()
        }
    });

    await prisma.journalEntry.createMany({
        data: [
            { tenantId: tenantA.id, transactionId: tx1.id, accountCode: '1100', debit: 1130.00, credit: 0, currency: 'CAD' }, // AR
            { tenantId: tenantA.id, transactionId: tx1.id, accountCode: '4000', debit: 0, credit: 1000.00, currency: 'CAD' }, // Revenue
            { tenantId: tenantA.id, transactionId: tx1.id, accountCode: '2100', debit: 0, credit: 130.00, currency: 'CAD' },  // Tax
        ]
    });

    // Expense Transaction
    const tx2 = await prisma.financialTransaction.create({
        data: {
            tenantId: tenantA.id,
            type: 'EXPENSE',
            amount: 500.00,
            currency: 'CAD',
            description: 'Office Rent - March',
            status: 'posted',
            date: new Date()
        }
    });

    await prisma.journalEntry.createMany({
        data: [
            { tenantId: tenantA.id, transactionId: tx2.id, accountCode: '5200', debit: 500.00, credit: 0, currency: 'CAD' }, // Rent
            { tenantId: tenantA.id, transactionId: tx2.id, accountCode: '1000', debit: 0, credit: 500.00, currency: 'CAD' }, // Cash
        ]
    });

    // 5. Create an unreconciled Bank Transaction for Banner Testing
    await prisma.bankTransaction.create({
        data: {
            tenantId: tenantA.id,
            amount: 1130.00,
            currency: 'CAD',
            description: 'DEP: INVOICE #1001',
            date: new Date(),
            status: 'unreconciled',
            externalId: 'BANK_TX_001'
        }
    });

    // 6. Create basic services
    await prisma.service.upsert({
        where: { slug: 'personal-care' },
        update: {},
        create: {
            name: 'Personal Care',
            slug: 'personal-care',
            baseRateHourly: 35.0,
            tenantId: tenantA.id,
            isActive: true
        }
    });

    console.log('✅ Seeding complete.');
}

main()
    .catch((e) => {
        console.error('❌ Seeding error:');
        console.error(e.message || e);
        process.exit(1);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });
