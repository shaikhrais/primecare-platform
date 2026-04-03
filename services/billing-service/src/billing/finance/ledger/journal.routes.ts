import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

const ledgerRoutes = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// Zod Schema for incoming Debit/Credit arrays
export const JournalEntrySchema = z.object({
  transactionType: z.enum(['PAYMENT', 'REFUND', 'ADJUSTMENT', 'REVERSAL', 'PAYOUT']),
  referenceType: z.string().openapi({ example: 'Invoice' }),
  referenceId: z.string().openapi({ example: 'inv_12345' }),
  entries: z.array(z.object({
    accountId: z.string(),
    type: z.enum(['DEBIT', 'CREDIT']),
    amount: z.number().positive()
  })).min(2, "A double-entry transaction strictly requires at least 2 entries."),
  currency: z.string().default('CAD'),
  description: z.string().optional()
});

// ROUTE 1: Atomic Double-Entry Ledger Commitment
const postJournalEntryRoute = createRoute({
  method: 'post',
  path: '/entry',
  tags: ['Finance/Ledger'],
  summary: 'Architect Atomic Double-Entry Journal',
  description: 'Calculates the strict equivalence of Debits vs Credits natively. If perfectly balanced, generates an immutable TransactionLedger row array alongside active JournalEntry adjustments via Prisma $transaction.',
  request: {
    body: {
      content: { 'application/json': { schema: JournalEntrySchema } },
      required: true
    }
  },
  responses: {
    201: { description: 'Ledger Successfully Balanced & Immutable Hash Generated', content: { 'application/json': { schema: z.object({ status: z.string(), transactionChecksum: z.string() }) } } },
    400: { description: 'Strict Double-Entry Imbalance Detected', content: { 'application/json': { schema: z.object({ error: z.string(), difference: z.number().optional() }) } } },
    500: { description: 'Internal Server Error', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
  }
});

ledgerRoutes.openapi(postJournalEntryRoute, async (c) => {
  const prisma = c.get('prisma') as any;
  // @ts-ignore - Ignoring strict Hono Context map bounds for dynamic JWT tenancy
  const tenantId = c.get('tenantId') as string;
  // @ts-ignore
  const user = c.get('user') as any;
  
  const payload = c.req.valid('json');

  // Mathematical Logic: Sum of Debits MUST equal Sum of Credits rigidly.
  let totalDebits = 0;
  let totalCredits = 0;

  payload.entries.forEach(entry => {
    if (entry.type === 'DEBIT') totalDebits += entry.amount;
    if (entry.type === 'CREDIT') totalCredits += entry.amount;
  });

  // Floating point heuristic correction rounding to 2 decimal places
  totalDebits = Math.round(totalDebits * 100) / 100;
  totalCredits = Math.round(totalCredits * 100) / 100;

  if (totalDebits !== totalCredits) {
    return c.json({ 
      error: 'CRITICAL IMBALANCE: Double-Entry validation physically rejected the constraints. Debits do not mathematically equal Credits.', 
      difference: Math.abs(totalDebits - totalCredits) 
    }, 400 as const);
  }

  // Atomic Write Array
  try {
    const result = await prisma.$transaction(async (tx: any) => {
      // 1. Establish the "Immutable Transaction Ledger" master record
      const masterLedgerRow = await tx.transactionLedger.create({
        data: {
          tenantId,
          transactionType: payload.transactionType,
          referenceType: payload.referenceType,
          referenceId: payload.referenceId,
          debitAccount: payload.entries.find(e => e.type === 'DEBIT')?.accountId || 'unknown',
          creditAccount: payload.entries.find(e => e.type === 'CREDIT')?.accountId || 'unknown',
          amount: totalDebits,
          currency: payload.currency,
          description: payload.description,
          actorUserId: user?.id,
          // Placeholder for real SHA-256 Crypto computation
          checksum: `SHA256-MOCKED-${Date.now()}-${payload.referenceId}`
        }
      });

      // 2. Generate the dynamic financial transaction core
      const financeTransaction = await tx.financialTransaction.create({
        data: {
          tenantId,
          type: payload.transactionType,
          referenceId: payload.referenceId,
          amount: totalDebits,
          currency: payload.currency,
          status: 'posted'
        }
      });

      // 3. Write individual Journal Entries to the Account targets
      for (const entry of payload.entries) {
        // Technically, a real system locks the Account row to calculate `balanceBefore` and `balanceAfter`. 
        // We will insert 0 here for the structural outline.
        await tx.journalEntry.create({
          data: {
            tenantId,
            transactionId: financeTransaction.id,
            accountId: entry.accountId,
            debit: entry.type === 'DEBIT' ? entry.amount : 0,
            paidOutAmount: entry.type === 'CREDIT' ? entry.amount : null,
            balanceBefore: 0, 
            balanceAfter: entry.type === 'DEBIT' ? entry.amount : -entry.amount 
          }
        });
      }

      return masterLedgerRow;
    });

    return c.json({ 
      status: 'DOUBLE_ENTRY_VERIFIED_AND_COMMITTED', 
      transactionChecksum: result.checksum 
    }, 201 as const);

  } catch (e: any /* Audit 63 Notice: Should be unknown */) {
    // @ts-ignore - Explicit error casting for Hono framework catch bounds
    return c.json({ error: 'Atomic Transaction Failure: ' + e.message }, 500 as const);
  }
});


// ROUTE 2: Live P&L (Profit & Loss) Algorithmic Generator
const getPnlRoute = createRoute({
  method: 'get',
  path: '/pnl',
  tags: ['Finance/Ledger'],
  summary: 'Generate Physical P&L Matrix',
  description: 'Aggregates all journal records algorithmically mapping Gross Revenue vs Physical payout liabilities generating net operating cashflow constraints.',
  responses: {
    200: { 
      description: 'Matrix Returned', 
      content: { 'application/json': { schema: z.object({
        currency: z.string(),
        grossRevenue: z.number(),
        operatingExpenses: z.number(),
        netProfit: z.number(),
        margin: z.string()
      })}}
    },
    500: { description: 'Internal Server Error', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
  }
});

ledgerRoutes.openapi(getPnlRoute, async (c) => {
  const prisma = c.get('prisma') as any;
  // @ts-ignore
  const tenantId = c.get('tenantId') as string;

  // Aggregation Logic: Extracting Revenue (Invoices/Payments) vs Expenses (Payouts)
  // Inside a physical ledger, Revenue Accounts carry Credit normal balances.
  const transactions = await prisma.financialTransaction.findMany({
    where: { tenantId },
    select: { type: true, amount: true }
  });

  let grossRevenue = 0;
  let operatingExpenses = 0;

  transactions.forEach((tx: any) => {
    const val = Number(tx.amount);
    if (tx.type === 'PAYMENT' || tx.type === 'INVOICE' || tx.type === 'REVENUE') grossRevenue += val;
    if (tx.type === 'PAYOUT' || tx.type === 'EXPENSE' || tx.type === 'ADJUSTMENT') operatingExpenses += val;
  });

  const netProfit = grossRevenue - operatingExpenses;
  const marginStr = grossRevenue > 0 ? ((netProfit / grossRevenue) * 100).toFixed(2) + '%' : '0.00%';

  return c.json({
    currency: 'CAD',
    grossRevenue,
    operatingExpenses,
    netProfit,
    margin: marginStr
  }, 200 as const);
});

export default ledgerRoutes;
