// Governance - Category: test | Purpose: Using a seeded tenant to satisfy foreign key constraints Setup dummy user for auditing
import { describe, it, expect, beforeAll, afterAll } from 'vitest';
import { LedgerService } from '../LedgerService';
import { PrismaClient } from '@primecare/database';
import { Result } from '../../utils/Result';

const prisma = new PrismaClient();

describe('LedgerService Concurrency Hardening', () => {
    // Using a seeded tenant to satisfy foreign key constraints
    const tenantId = 'tenant-toronto';
    let assetAccountId: string | undefined;
    let revenueAccountId: string | undefined;
    let actorUserId: string;

    beforeAll(async () => {
        // Setup dummy user for auditing
        const user = await prisma.user.create({
            data: {
                email: `tester-${Date.now()}@concurrency.com`,
                firstName: 'Test',
                lastName: 'Actor',
                roles: 'admin',
                tenantId,
                status: 'active'
            }
        });
        actorUserId = user.id;

        // Setup test accounts with missing 'currency' field added
        const assetAccount = await prisma.chartOfAccount.create({
            data: {
                tenantId,
                code: '1001-TEST-CONC',
                name: 'Test Cash Concurrency',
                type: 'ASSET',
                currency: 'CAD'
            }
        });
        assetAccountId = assetAccount.id;

        const revenueAccount = await prisma.chartOfAccount.create({
            data: {
                tenantId,
                code: '4001-TEST-CONC',
                name: 'Test Revenue Concurrency',
                type: 'REVENUE',
                currency: 'CAD'
            }
        });
        revenueAccountId = revenueAccount.id;
    });

    afterAll(async () => {
        // Cleanup test artifacts
        if (assetAccountId && revenueAccountId) {
            await prisma.journalEntry.deleteMany({ where: { accountId: { in: [assetAccountId, revenueAccountId] } } });
            await prisma.transactionLedger.deleteMany({ where: { tenantId, referenceId: { startsWith: 'SALE-CONC-' } } });
            await prisma.chartOfAccount.delete({ where: { id: assetAccountId } });
            await prisma.chartOfAccount.delete({ where: { id: revenueAccountId } });
            await prisma.user.delete({ where: { id: actorUserId } });
        }
    });

    it('should handle simultaneous transactions without balance drift using row-level locking', async () => {
        if (!assetAccountId || !revenueAccountId) throw new Error('Setup failed');
        
        const transactionCount = 5; 
        const amountPerTransaction = 100;

        // Fire multiple transactions simultaneously
        const results = await Promise.all(
            Array.from({ length: transactionCount }).map((_, i) =>
                LedgerService.recordTransaction(prisma, {
                    tenantId,
                    type: 'SALE',
                    referenceId: `SALE-CONC-${i}`,
                    entries: [
                        { accountId: '1001-TEST-CONC', debit: amountPerTransaction },
                        { accountId: '4001-TEST-CONC', credit: amountPerTransaction }
                    ],
                    actorUserId
                })
            )
        );

        // All should succeed
        results.forEach(r => {
            if (!r.isSuccess) {
                console.error('Transaction Failed:', r.error);
            }
            expect(r.isSuccess).toBe(true);
        });

        // Verify Balance Integrity
        const lastAssetEntry = await prisma.journalEntry.findFirst({
            where: { accountId: assetAccountId },
            orderBy: { createdAt: 'desc' }
        });

        const lastRevenueEntry = await prisma.journalEntry.findFirst({
            where: { accountId: revenueAccountId },
            orderBy: { createdAt: 'desc' }
        });

        const expectedBalance = transactionCount * amountPerTransaction;

        expect(Number(lastAssetEntry?.balanceAfter)).toBe(expectedBalance);
        expect(Number(lastRevenueEntry?.balanceAfter)).toBe(expectedBalance);
    }, 30000);
});
