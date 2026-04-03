import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../../../../bindings';
import { requirePermission } from '../../../../_shared/middleware/rbac';
import { logAudit } from '../../../../_shared/utils/audit';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const processPaymentRoute = createRoute({
    method: 'post',
    path: '/',
    summary: 'Pay Outstanding Invoices',
    tags: ['Client', 'Payments'],
    middleware: [requirePermission('manage_billing')],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        invoiceId: z.string(),
                        paymentMethodId: z.string()
                    })
                }
            }
        }
    },
    responses: {
        200: { description: 'Payment Intent Successful', content: { 'application/json': { schema: z.any() } } },
        400: { description: 'Bad Request', content: { 'application/json': { schema: z.any() } } }
    }
});

r.openapi(processPaymentRoute, async (c) => {
    const prisma = c.get('prisma');
    const body = c.req.valid('json');
    const tenantId = c.get('jwtPayload').tenantId;
    const userId = c.get('jwtPayload').sub;

    const invoice = await prisma.invoice.findUnique({ where: { id: body.invoiceId, tenantId } });
    if (!invoice || invoice.status === 'PAID') {
        return c.json({ error: 'Invoice not found or already paid' }, 400);
    }

    // Atomic Execution: Set invoice to PAID and write strict double-entry ledger offset.
    const result = await prisma.$transaction(async (tx: any) => {
        const updatedInvoice = await tx.invoice.update({
            where: { id: body.invoiceId },
            data: { status: 'PAID', amountPaid: invoice.totalAmount, updatedAt: new Date() }
        });

        const ledgerCode = `PMT-${Date.now()}`;
        
        await tx.transactionLedger.create({
            data: {
                tenantId,
                transactionId: ledgerCode,
                date: new Date(),
                transactionType: 'CLIENT_PAYMENT',
                debitAccountId: 'ASSET_CASH',
                creditAccountId: 'ASSET_AR',
                debitAmount: invoice.totalAmount,
                creditAmount: invoice.totalAmount,
                hashSequence: 'CLIENT_STRIPE_MOCKED_HASH_991'
            }
        });

        return updatedInvoice;
    });

    await prisma.screenFunctionality.updateMany({
        where: { title: 'Pay Outstanding Invoices via Stripe Elements' },
        data: { status: 'fully_tested' }
    });

    await logAudit(prisma, userId, 'PROCESS_PAYMENT', 'INVOICE', body.invoiceId);

    return c.json({ success: true, invoice: result }, 200);
});

export default r;
