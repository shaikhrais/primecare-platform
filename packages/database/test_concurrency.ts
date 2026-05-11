import { PrismaClient } from './src/index';
// @ts-ignore - Importing from sister package in monorepo
import { LedgerService } from '../domain/src/services/LedgerService';

const prisma = new PrismaClient();

async function runConcurrencyTest() {
    // 1. Setup Test Tenant
    const tenantId = 'conc-' + Date.now();
    await prisma.tenant.create({
        data: {
            id: tenantId,
            name: 'Concurrency Test Inc',
            slug: tenantId,
            corsAllowedOrigins: ['*'],
            corsAllowedMethods: ['GET', 'POST'],
            corsAllowedHeaders: ['Content-Type'],
            allowedVpnRanges: '0.0.0.0/0'
        }
    });

    console.log(`\x1b[36m🚀 Starting Concurrency Test for Tenant: ${tenantId}\x1b[0m`);

    // 2. Setup Test User (Actor)
    const actorId = 'actor-' + Date.now();
    await prisma.user.create({
        data: {
            id: actorId,
            email: actorId + '@test.com',
            tenantId: tenantId,
            roles: 'admin'
        }
    });

    // 3. Setup Test Accounts within a Transaction to ensure they exist before we start
    const accountA = await prisma.chartOfAccount.create({
        data: {
            tenantId,
            name: 'Test Asset Account',
            code: 'CONC_ASSET_' + Math.random().toString(36).substring(7),
            type: 'ASSET'
        }
    });

    const accountB = await prisma.chartOfAccount.create({
        data: {
            tenantId,
            name: 'Test Revenue Account',
            code: 'CONC_REV_' + Math.random().toString(36).substring(7),
            type: 'REVENUE'
        }
    });

    console.log(`\x1b[32m✅ Test Accounts Created: ${accountA.id}, ${accountB.id}\x1b[0m`);

    const itrs = 20;
    const amountPerItr = 10;
    
    console.log(`\x1b[33m📊 Spawning ${itrs} concurrent transfers of $${amountPerItr} each...\x1b[0m`);

    const promises = [];
    for (let i = 0; i < itrs; i++) {
        promises.push(LedgerService.recordTransaction({
            tenantId,
            type: 'STRESS_TEST',
            entries: [
                { accountId: accountA.id, debit: amountPerItr },
                { accountId: accountB.id, credit: amountPerItr }
            ],
            description: `Concurrency Test Run ${i}`,
            actorUserId: actorId
        }));
    }

    const startTime = Date.now();
    const results = await Promise.allSettled(promises);
    const endTime = Date.now();
    
    const successes = results.filter(r => r.status === 'fulfilled').length;
    const failures = results.filter(r => r.status === 'rejected').length;

    console.log(`\x1b[34m⏱️  Execution completed in ${endTime - startTime}ms\x1b[0m`);
    console.log(`\x1b[32m✅ Successes: ${successes}\x1b[0m`);
    if (failures > 0) {
        console.log(`\x1b[31m❌ Failures: ${failures}\x1b[0m`);
        results.filter(r => r.status === 'rejected').forEach((r: any, idx) => {
            console.error(`   [Error ${idx}]: ${r.reason.message}`);
        });
    }

    // 2. Verification: Balance Check
    const finalAccountA = await prisma.journalEntry.findFirst({
        where: { accountId: accountA.id },
        orderBy: { createdAt: 'desc' }
    });

    const expectedBalance = successes * amountPerItr;
    const actualBalance = Number(finalAccountA?.balanceAfter || 0);

    console.log(`\x1b[35m💰 Account A Final Balance: ${actualBalance} (Expected: ${expectedBalance})\x1b[0m`);

    // 3. Verification: Ledger Chain Integrity
    const ledgerEntries = await prisma.transactionLedger.findMany({
        where: { tenantId },
        orderBy: { createdAt: 'asc' }
    });

    console.log(`\x1b[36m🔗 Checking Ledger Chain Integrity for ${ledgerEntries.length} blocks...\x1b[0m`);
    let prevHash: string | null = null;
    let chainValid = true;
    for (const entry of ledgerEntries) {
        const entryMetadata = entry.metadata as any;
        if (entryMetadata?.prevHash !== prevHash) {
            console.error(`\x1b[31m❌ Hash Break! Block ${entry.id} expects prevHash '${entryMetadata?.prevHash}' but got '${prevHash}'\x1b[0m`);
            chainValid = false;
        }
        prevHash = entry.checksum;
    }

    // 4. Verification: Telemetry Check
    const telemetryEvents = await prisma.implementationEvent.findMany({
        where: { payload: { path: ['tenantId'], equals: tenantId } }
    });
    console.log(`\x1b[32m📊 Telemetry Events Captured: ${telemetryEvents.length}\x1b[0m`);

    if (chainValid && actualBalance === expectedBalance && successes === itrs) {
        console.log('\x1b[42m\x1b[30m 🏆 TEST PASSED: Zero-Drift Balance & Perfect Ledger Continuity 🏆 \x1b[0m');
    } else {
        console.error('\x1b[41m\x1b[37m 💀 TEST FAILED: Financial Inconsistency Detected 💀 \x1b[0m');
        process.exit(1);
    }
}

runConcurrencyTest()
    .catch(err => {
        console.error(err);
        process.exit(1);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });
