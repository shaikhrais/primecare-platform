// Governance - Category: test | Purpose: Use vi.hoisted to ensure the mock object is available during vi.mock execution
import { vi, describe, it, expect, beforeEach } from 'vitest';
import { Prisma } from '@primecare/database';

// Use vi.hoisted to ensure the mock object is available during vi.mock execution
const { mockPrisma } = vi.hoisted(() => {
    const mock: any = {
        $transaction: vi.fn((callback) => callback(mock)),
        $executeRaw: vi.fn().mockResolvedValue(1),
        $queryRaw: vi.fn().mockResolvedValue([{ id: 'last-ledger-id', checksum: 'prev-hash' }]),
        tenant: {
            findUnique: vi.fn().mockResolvedValue({ id: 'tenant-xyz', baseCurrency: 'CAD' }),
        },
        chartOfAccount: {
            findUnique: vi.fn(),
            findFirst: vi.fn(),
        },
        financialTransaction: {
            findUnique: vi.fn(),
            create: vi.fn().mockResolvedValue({ id: 'new-tx-id' }),
            update: vi.fn(),
        },
        journalEntry: {
            create: vi.fn(),
            findFirst: vi.fn().mockResolvedValue({ balanceAfter: 0 }),
        },
        implementationEvent: {
            create: vi.fn().mockResolvedValue({ id: 'event-id' }),
        },
        transactionLedger: {
            create: vi.fn().mockResolvedValue({ id: 'ledger-entry-uuid' }),
            findFirst: vi.fn(),
            update: vi.fn()
        }
    };
    return { mockPrisma: mock };
});

vi.mock('@primecare/database', async (importOriginal) => {
    const actual: any = await importOriginal();
    return {
        ...actual,
        PrismaClient: class {
            constructor() {
                return mockPrisma;
            }
        },
        prisma: mockPrisma
    };
});

// Now import the service under test
import { LedgerService } from '../LedgerService';

describe('Ledger Reversal (Voiding)', () => {
    const tenantId = 'tenant-xyz';
    const transactionId = 'tx-123';
    const actorUserId = 'user-admin';

    beforeEach(() => {
        vi.clearAllMocks();
        
        // Setup default account lookups
        mockPrisma.chartOfAccount.findUnique.mockImplementation(({ where }: any) => {
            const code = where.tenantId_code?.code || where.code;
            return { id: `acc-${code}`, code, type: code === '4100' ? 'REVENUE' : 'ASSET' };
        });

        mockPrisma.chartOfAccount.findFirst.mockImplementation(({ where }: any) => {
            // Handle OR queries for ID or Code
            const idCondition = where.OR?.find((c: any) => c.id)?.id;
            const codeCondition = where.OR?.find((c: any) => c.code)?.code || where.code;
            
            if (idCondition) {
                const code = idCondition.includes('-') ? idCondition.split('-').pop() : idCondition;
                return { id: idCondition, code: code, currency: 'CAD', type: code === '4100' ? 'REVENUE' : 'ASSET' };
            }
            
            const code = codeCondition || '2100';
            return { id: `acc-${code}`, code, currency: 'CAD', type: code === '4100' ? 'REVENUE' : 'ASSET' };
        });
    });

    it('should correctly reverse all journal entries and mark transaction as voided', async () => {
        // 1. Mock the original transaction
        const originalJe = [
            { 
                id: 'je-1', 
                accountId: 'acc-1100', 
                debit: new Prisma.Decimal(113), 
                paidOutAmount: new Prisma.Decimal(0),
                account: { code: '1100' }
            },
            { 
                id: 'je-2', 
                accountId: 'acc-4100', 
                debit: new Prisma.Decimal(0), 
                paidOutAmount: new Prisma.Decimal(113),
                account: { code: '4100' }
            },
        ];

        mockPrisma.financialTransaction.findUnique.mockResolvedValue({
            id: transactionId,
            tenantId,
            status: 'posted',
            journalEntries: originalJe,
        });

        // Mock ledger search for voiding link
        mockPrisma.transactionLedger.findFirst.mockResolvedValue({ id: 'ledger-123', checksum: 'old-sum' });

        // Execute void
        const result = await LedgerService.voidTransaction(mockPrisma as any, transactionId, tenantId, actorUserId);

        expect(result.isSuccess).toBe(true);

        // Assertions
        expect(mockPrisma.financialTransaction.update).toHaveBeenCalledWith({
            where: { id: transactionId },
            data: { status: 'voided' }
        });

        // Verify reversal creation calls
        const jeCreateCalls = mockPrisma.journalEntry.create.mock.calls;
        
        // Ensure calls were made
        if (jeCreateCalls.length === 0) {
            throw new Error(`No journal entries created. FT findUnique returned: ${JSON.stringify(await mockPrisma.financialTransaction.findUnique())}`);
        }

        // AR leg reversed: Original (D 113, C 0) -> Reversal (D 0, C 113)
        const arCall = jeCreateCalls.find((c: any) => c[0].data.accountId === 'acc-1100');
        if (!arCall) {
            throw new Error(`AR reversal not found. Accounts in calls: ${jeCreateCalls.map((c: any) => c[0].data.accountId).join(', ')}`);
        }
        const arReversal = arCall[0].data;

        // Revenue leg reversed: Original (D 0, C 113) -> Reversal (D 113, C 0)
        const revReversal = jeCreateCalls.find((c: any) => c[0].data.accountId === 'acc-4100')[0].data;
        expect(revReversal.debit.toString()).toBe('113');

        // Check ledger status update
        expect(mockPrisma.transactionLedger.update).toHaveBeenCalledWith(expect.objectContaining({
            data: expect.objectContaining({
                status: 'voided',
                voidedByEntryId: 'ledger-entry-uuid'
            })
        }));
    });

    it('should throw error if transaction is already voided', async () => {
        mockPrisma.financialTransaction.findUnique.mockResolvedValue({
            id: 'tx-already-voided',
            status: 'voided'
        });

        const result = await LedgerService.voidTransaction(mockPrisma as any, 'tenant-1', 'tx-123', 'admin-1');
        expect(result.isFailure).toBe(true);
        expect(result.error).toMatch('Transaction already voided');
    });

    it('should preserve currency and exchange rate during reversal', async () => {
        const originalTx = {
            id: 'tx-usd',
            tenantId,
            status: 'posted',
            currency: 'USD',
            exchangeRate: 1.35,
            journalEntries: [
                { 
                    accountId: 'acc-1100', 
                    debit: new Prisma.Decimal(100), 
                    paidOutAmount: new Prisma.Decimal(0),
                    account: { code: '1100' }
                },
                { 
                    accountId: 'acc-4100', 
                    debit: new Prisma.Decimal(0), 
                    paidOutAmount: new Prisma.Decimal(100),
                    account: { code: '4100' }
                }
            ]
        };

        mockPrisma.financialTransaction.findUnique.mockResolvedValue(originalTx);

        await LedgerService.voidTransaction(mockPrisma as any, 'tx-usd', tenantId, actorUserId);

        // Verify recordTransaction was called with USD
        expect(mockPrisma.financialTransaction.create).toHaveBeenCalledWith(expect.objectContaining({
            data: expect.objectContaining({
                currency: 'USD',
                exchangeRate: 1.35
            })
        }));
    });

    it('should correctly reverse tax legs (Account 2100)', async () => {
        const originalTx = {
            id: 'tx-tax',
            tenantId,
            status: 'posted',
            currency: 'CAD',
            exchangeRate: 1,
            journalEntries: [
                { account: { code: '1100' }, accountId: 'acc-1100', debit: new Prisma.Decimal(113), paidOutAmount: new Prisma.Decimal(0) },
                { account: { code: '4100' }, accountId: 'acc-4100', debit: new Prisma.Decimal(0), paidOutAmount: new Prisma.Decimal(100) },
                { account: { code: '2100' }, accountId: 'acc-2100', debit: new Prisma.Decimal(0), paidOutAmount: new Prisma.Decimal(13) }
            ]
        };

        mockPrisma.financialTransaction.findUnique.mockResolvedValue(originalTx);

        await LedgerService.voidTransaction(mockPrisma as any, 'tx-tax', tenantId, actorUserId);

        const createCalls = mockPrisma.journalEntry.create.mock.calls;
        
        // Find the tax leg reversal
        const taxReversal = createCalls.find((c: any) => c[0].data.accountId === 'acc-2100')[0].data;
        expect(taxReversal.debit.toString()).toBe('13');
        expect(taxReversal.paidOutAmount.toString()).toBe('0');
    });
});
