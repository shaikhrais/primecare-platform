// Governance - Category: service | Purpose: Core implementation file for the Seed Accounts platform logic.
import { PrismaClient } from './generated/client';

const prisma = new PrismaClient();

async function main() {
    console.log('Seeding Chart of Accounts for Financial Ledger...');

    const tenant = await prisma.tenant.findFirst();
    if (!tenant) {
        console.warn('No tenant found. Please migrate and seed a base tenant first.');
        return;
    }

    const accounts = [
        { code: '1000', name: 'Cash', type: 'ASSET' },
        { code: '1010', name: 'Petty Cash', type: 'ASSET' },
        { code: '1200', name: 'Accounts Receivable', type: 'ASSET' },
        { code: '2100', name: 'Sales Tax Payable', type: 'LIABILITY' },
        { code: '2200', name: 'Refund Payable', type: 'LIABILITY' },
        { code: '4000', name: 'Service Revenue', type: 'REVENUE' },
        { code: '6000', name: 'Operating Expenses', type: 'EXPENSE' },
        { code: '6100', name: 'Office Supplies', type: 'EXPENSE' },
        { code: '6200', name: 'Travel & Meals', type: 'EXPENSE' },
        { code: '6300', name: 'Maintenance & Repairs', type: 'EXPENSE' }
    ];

    for (const acc of accounts) {
        await prisma.chartOfAccount.upsert({
            where: {
                tenantId_code: {
                    tenantId: tenant.id,
                    code: acc.code
                }
            },
            update: {
                name: acc.name,
                type: acc.type
            },
            create: {
                tenantId: tenant.id,
                code: acc.code,
                name: acc.name,
                type: acc.type,
                status: 'active'
            }
        });
        console.log(`Seeded account: ${acc.code} - ${acc.name}`);
    }

    console.log('Successfully seeded Chart of Accounts.');
}

main()
    .catch((e) => {
        console.error('Error during Chart of Accounts seeding:', e);
        throw e;
    })
    .finally(async () => {
        await prisma.$disconnect();
    });
