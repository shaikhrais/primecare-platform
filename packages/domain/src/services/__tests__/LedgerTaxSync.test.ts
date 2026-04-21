import { describe, it, expect, vi, beforeEach } from 'vitest';
import { LedgerService } from '../LedgerService';
import { Prisma } from '@primecare/database';

// Use vi.hoisted to ensure the mock object is available during vi.mock execution
const { mockPrisma } = vi.hoisted(() => {
    const mock: any = {
        $transaction: vi.fn((callback) => callback(mock)),
        $executeRaw: vi.fn().mockResolvedValue(1),
        $queryRaw: vi.fn().mockResolvedValue([{ id: 'last-ledger-id', checksum: 'prev-hash' }]),
        tenant: {
            findUnique: vi.fn()
        },
        chartOfAccount: {
            findUnique: vi.fn(),
            findFirst: vi.fn(),
            update: vi.fn()
        },
        financialTransaction: {
            create: vi.fn()
        },
        journalEntry: {
            createMany: vi.fn(),
            create: vi.fn(),
            findFirst: vi.fn()
        },
        implementationEvent: {
            create: vi.fn().mockResolvedValue({ id: 'event-id' })
        },
        transactionLedger: {
            create: vi.fn().mockResolvedValue({ id: 'ledger-entry-uuid' }),
            findFirst: vi.fn(),
            update: vi.fn()
        }
    };
    return { mockPrisma: mock };
});

vi.mock('@primecare/database', () => {
    return {
        PrismaClient: class {
            constructor() {
                return mockPrisma;
            }
        },
        prisma: mockPrisma
    };
});

describe('LedgerTaxSync Integration', () => {
    const tenantId = 'test-tenant-123';
    const actorUserId = 'user-456';

    beforeEach(() => {
        vi.clearAllMocks();
        
        // Mock Tenant
        mockPrisma.tenant.findUnique.mockResolvedValue({
            id: tenantId,
            baseCurrency: 'CAD',
            region: 'ON'
        });

        // Mock Accounts
        const mockAccounts = {
            '1100': { id: 'acc-ar', code: '1100', type: 'ASSET', balance: new Prisma.Decimal(0), currency: 'CAD' },
            '4100': { id: 'acc-rev', code: '4100', type: 'REVENUE', balance: new Prisma.Decimal(0), currency: 'CAD' },
            '2100': { id: 'acc-tax', code: '2100', type: 'LIABILITY', balance: new Prisma.Decimal(0), currency: 'CAD' }
        };

        mockPrisma.chartOfAccount.findUnique.mockImplementation(({ where }: any) => {
            const code = where.code || where.tenantId_code?.code;
            return Promise.resolve(mockAccounts[code as keyof typeof mockAccounts]);
        });

        mockPrisma.chartOfAccount.findFirst.mockImplementation(({ where }: any) => {
            return Promise.resolve(mockAccounts[where.code as keyof typeof mockAccounts]);
        });

        mockPrisma.transactionLedger.findFirst.mockResolvedValue({
            id: 'last-ledger-id',
            balance: new Prisma.Decimal(1000),
            hash: 'last-hash'
        });

        mockPrisma.financialTransaction.create.mockResolvedValue({ id: 'new-tx-id' });
    });

    it('should automatically split tax when recording revenue in Ontario', async () => {
        const input = {
            tenantId,
            type: 'INVOICE' as const,
            referenceId: 'inv-001',
            description: 'Test Invoice with Tax',
            actorUserId,
            region: 'ON',
            taxIncluded: true,
            entries: [
                { accountCode: '1100', debit: 113, credit: 0 },
                { accountCode: '4100', debit: 0, credit: 113 }
            ]
        };

        const result = await LedgerService.recordTransaction(input);

        expect(result.transactionId).toBe('new-tx-id');

        // Verify journal entries
        const createCalls = mockPrisma.journalEntry.create.mock.calls;
        expect(createCalls).toHaveLength(3); // AR, Revenue, Tax

        const entries = createCalls.map((c: any) => c[0].data);

        const arEntry = entries.find((e: any) => e.accountId === 'acc-ar');
        const revEntry = entries.find((e: any) => e.accountId === 'acc-rev');
        const taxEntry = entries.find((e: any) => e.accountId === 'acc-tax');

        // Total 113 -> 100 Revenue, 13 Tax
        expect(revEntry.paidOutAmount).toBe(100);
        expect(taxEntry.paidOutAmount).toBe(13);
        expect(arEntry.debit).toBe(113);
    });

    it('should NOT split tax if No region is provided', async () => {
        const input = {
            tenantId,
            type: 'INVOICE' as const,
            referenceId: 'inv-002',
            description: 'Test Invoice no tax',
            actorUserId,
            entries: [
                { accountCode: '1100', debit: 100, credit: 0 },
                { accountCode: '4100', debit: 0, credit: 100 }
            ]
        };

        await LedgerService.recordTransaction(input);

        const createCalls = mockPrisma.journalEntry.create.mock.calls;
        // In the first test we had 3 calls, now we adding more? 
        // No, I clear mocks in beforeEach.
        expect(createCalls).toHaveLength(2); // Only AR and Revenue
    });
});
