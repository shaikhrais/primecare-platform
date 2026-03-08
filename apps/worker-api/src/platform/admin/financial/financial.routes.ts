import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { FinancialService } from '../../../_shared/services/financial.service';
import { BillingService } from '../../../_shared/services/billing.service';

const financial = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET /ledger
const listLedgerRoute = createRoute({
    method: 'get',
    path: '/',
    summary: 'List Financial Ledger',
    description: 'Returns all financial transactions with their balanced journal entries.',
    tags: ['Financial'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'Success',
        },
    },
});

financial.openapi(listLedgerRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;

    const ledger = await prisma.financialTransaction.findMany({
        where: { tenantId },
        include: {
            journalEntries: {
                include: { account: true }
            },
            reconciliations: true
        },
        orderBy: { createdAt: 'desc' }
    });

    return c.json(ledger, 200);
});

// GET /accounts
const listAccountsRoute = createRoute({
    method: 'get',
    path: '/accounts',
    summary: 'List Chart of Accounts',
    tags: ['Financial'],
    responses: {
        200: {
            content: { 'application/json': { schema: z.array(z.any()) } },
            description: 'Success',
        },
    },
});

financial.openapi(listAccountsRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;

    const accounts = await prisma.chartOfAccount.findMany({
        where: { tenantId },
        orderBy: { code: 'asc' }
    });

    return c.json(accounts, 200);
});

// POST /initialize
const initializeRoute = createRoute({
    method: 'post',
    path: '/initialize',
    summary: 'Initialize Standard Chart of Accounts',
    tags: ['Financial'],
    responses: {
        200: {
            content: { 'application/json': { schema: z.object({ message: z.string() }) } },
            description: 'Success',
        },
    },
});

financial.openapi(initializeRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const financialService = new FinancialService(prisma);

    await financialService.initializeChartOfAccounts(tenantId);
    return c.json({ message: 'Financial accounts initialized successfully' }, 200);
});

// POST /invoice (Manual for Demo/Admin)
const createInvoiceRoute = createRoute({
    method: 'post',
    path: '/invoices',
    summary: 'Generate Manual Invoice',
    tags: ['Financial'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        clientId: z.string(),
                        amount: z.number(),
                        tax: z.number().optional(),
                    }),
                },
            },
        },
    },
    responses: {
        200: { description: 'Invoice generated' },
    },
});

financial.openapi(createInvoiceRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const billingService = new BillingService(prisma);
    const body = c.req.valid('json');

    const invoice = await billingService.generateInvoice({
        tenantId,
        clientId: body.clientId,
        amount: body.amount,
        tax: body.tax
    });

    return c.json(invoice, 200);
});

// GET /balances
const getBalancesRoute = createRoute({
    method: 'get',
    path: '/balances',
    summary: 'Get Account Balances',
    tags: ['Financial'],
    responses: {
        200: { content: { 'application/json': { schema: z.array(z.any()) } }, description: 'Success' },
    },
});

financial.openapi(getBalancesRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const financialService = new FinancialService(prisma);
    const balances = await financialService.getAccountBalances(tenantId);
    return c.json(balances, 200);
});

// POST /reconcile (Manual Matching)
const reconcileRoute = createRoute({
    method: 'post',
    path: '/reconcile',
    summary: 'Match Invoice to Payment',
    tags: ['Financial'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        invoiceTxId: z.string(),
                        paymentTxId: z.string(),
                    }),
                },
            },
        },
    },
    responses: {
        200: { description: 'Matched successfully' },
    },
});

financial.openapi(reconcileRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const financialService = new FinancialService(prisma);
    const body = c.req.valid('json');

    await financialService.matchInvoiceWithPayment(tenantId, body.invoiceTxId, body.paymentTxId);
    return c.json({ success: true }, 200);
});

// GET /reconciliation-summary
const reconciliationSummaryRoute = createRoute({
    method: 'get',
    path: '/reconciliation-summary',
    summary: 'Get Reconciliation Metrics',
    tags: ['Financial'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        unreconciledBankCount: z.number(),
                        unreconciledLedgerCount: z.number(),
                    }),
                },
            },
            description: 'Success',
        },
    },
});

financial.openapi(reconciliationSummaryRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;

    const [unreconciledBankCount, unreconciledLedgerCount] = await Promise.all([
        prisma.bankTransaction.count({ where: { tenantId, status: 'unreconciled' } }),
        prisma.financialTransaction.count({ where: { tenantId, status: 'posted' } })
    ]);

    return c.json({ unreconciledBankCount, unreconciledLedgerCount }, 200);
});

// GET /reports/p-and-l
const pAndLRoute = createRoute({
    method: 'get',
    path: '/reports/p-and-l',
    summary: 'Profit & Loss Report',
    tags: ['Financial'],
    request: {
        query: z.object({
            startDate: z.string().optional(),
            endDate: z.string().optional(),
        }),
    },
    responses: {
        200: { content: { 'application/json': { schema: z.any() } }, description: 'Success' },
    },
});

financial.openapi(pAndLRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const financialService = new FinancialService(prisma);
    const query = c.req.valid('query');

    const start = query.startDate ? new Date(query.startDate) : new Date(new Date().getFullYear(), 0, 1);
    const end = query.endDate ? new Date(query.endDate) : new Date();

    const report = await financialService.getIncomeStatement(tenantId, start, end);
    return c.json(report, 200);
});

// GET /reports/balance-sheet
const balanceSheetRoute = createRoute({
    method: 'get',
    path: '/reports/balance-sheet',
    summary: 'Balance Sheet Snapshot',
    tags: ['Financial'],
    request: {
        query: z.object({
            date: z.string().optional(),
        }),
    },
    responses: {
        200: { content: { 'application/json': { schema: z.any() } }, description: 'Success' },
    },
});

financial.openapi(balanceSheetRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const financialService = new FinancialService(prisma);
    const query = c.req.valid('query');

    const date = query.date ? new Date(query.date) : new Date();
    const report = await financialService.getBalanceSheet(tenantId, date);
    return c.json(report, 200);
});

// GET /reports/daily-summary
const dailySummaryRoute = createRoute({
    method: 'get',
    path: '/reports/daily-summary',
    summary: 'Daily Financial Summary',
    tags: ['Financial'],
    request: {
        query: z.object({
            date: z.string().optional(),
        }),
    },
    responses: {
        200: { content: { 'application/json': { schema: z.any() } }, description: 'Success' },
    },
});

financial.openapi(dailySummaryRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const financialService = new FinancialService(prisma);
    const query = c.req.valid('query');

    const date = query.date ? new Date(query.date) : new Date();
    const summary = await financialService.generateDailySummary(tenantId, date);
    return c.json(summary, 200);
});

// GET /reports/trading-account
const tradingAccountRoute = createRoute({
    method: 'get',
    path: '/reports/trading-account',
    summary: 'Trading Account (Gross Profit)',
    tags: ['Financial'],
    request: {
        query: z.object({
            startDate: z.string().optional(),
            endDate: z.string().optional(),
        }),
    },
    responses: {
        200: { content: { 'application/json': { schema: z.any() } }, description: 'Success' },
    },
});

financial.openapi(tradingAccountRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const financialService = new FinancialService(prisma);
    const query = c.req.valid('query');

    const start = query.startDate ? new Date(query.startDate) : new Date(new Date().getFullYear(), new Date().getMonth(), 1);
    const end = query.endDate ? new Date(query.endDate) : new Date();

    const report = await financialService.getTradingAccount(tenantId, start, end);
    return c.json(report, 200);
});

export default financial;
