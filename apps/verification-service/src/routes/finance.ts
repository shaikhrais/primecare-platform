import { LedgerService, RecordTransactionInput } from '@primecare/domain/src/services/LedgerService';

export function registerFinanceRoutes(app: any) {
    /**
     * POST /v1/finance/ledger/transaction
     * Creates a new double-entry transaction record with concurrency-safe locking.
     */
    app.post('/v1/finance/ledger/transaction', async (c: any) => {
        try {
            const tenantId = c.req.header('x-tenant-id');
            const payload = c.get('jwtPayload');
            const clientIp = c.req.header('CF-Connecting-IP') || '127.0.0.1';

            if (!tenantId) {
                return c.json({ error: 'Missing x-tenant-id header' }, 400);
            }

            const body = await c.req.json();

            const input: RecordTransactionInput = {
                tenantId: tenantId as string,
                type: body.type || 'PAYMENT',
                referenceId: body.referenceId,
                entries: body.entries,
                description: body.description,
                actorUserId: payload?.sub || body.actorUserId, // Fallback to body for inter-service
                ipAddress: clientIp
            };

            const result = await LedgerService.recordTransaction(input);
            return c.json(result, 201);
        } catch (error: any) {
            console.error('Ledger Transaction Error:', error);
            if (error.name === 'LedgerImbalanceError') {
                return c.json({ error: error.message }, 422);
            }
            return c.json({ error: 'Internal Server Error' }, 500);
        }
    });

    /**
     * POST /v1/finance/ledger/void
     * Reverses a sealed transaction with a reversal entry.
     */
    app.post('/v1/finance/ledger/void', async (c: any) => {
        try {
            const body = await c.req.json();
            const { transactionId } = body;
            const payload = c.get('jwtPayload');

            if (!transactionId) {
                return c.json({ error: 'Missing transactionId' }, 400);
            }

            const result = await LedgerService.voidTransaction(transactionId, payload?.sub);
            return c.json(result, 200);
        } catch (error: any) {
            console.error('Ledger Void Error:', error);
            return c.json({ error: error.message }, 400);
        }
    });

    /**
     * GET /v1/finance/ledger/tax-report
     * Generates a tax filing report for HST/GST compliance.
     */
    app.get('/v1/finance/ledger/tax-report', async (c: any) => {
        try {
            const tenantId = c.req.header('x-tenant-id');
            if (!tenantId) {
                return c.json({ error: 'Missing x-tenant-id header' }, 400);
            }

            const { startDate, endDate } = c.req.query();
            const start = startDate ? new Date(startDate as string) : undefined;
            const end = endDate ? new Date(endDate as string) : undefined;

            const report = await LedgerService.generateTaxFilingReport(tenantId as string, start, end);
            return c.json(report, 200);
        } catch (error: any) {
            console.error('Tax Report Error:', error);
            return c.json({ error: 'Internal Server Error' }, 500);
        }
    });
}
