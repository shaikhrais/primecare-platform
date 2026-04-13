import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';

const billing = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET /billing/invoices — Client's invoices
const invoicesRoute = createRoute({
    method: 'get', path: '/invoices',
    summary: 'List invoices for the current client', tags: ['Client Billing'],
    request: { query: z.object({ status: z.string().optional(), page: z.string().optional() }) },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), invoiceNumber: z.string(), amount: z.string(),
                        status: z.string(), dueDate: z.string(), createdAt: z.string(),
                    }))
                }
            }, description: 'Invoices'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

billing.openapi(invoicesRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = (c.get('jwtPayload') as any).sub;

    const client = await prisma.clientProfile.findFirst({ where: { userId } });
    if (!client) return c.json([], 200);

    const status = c.req.query('status');
    const where: any = { clientId: client.id };
    if (status) where.status = status;

    const invoices = await prisma.invoice.findMany({
        where, orderBy: { createdAt: 'desc' }, take: 50,
    });

    return c.json(invoices.map((inv: any) => ({
        id: inv.id, invoiceNumber: inv.invoiceNumber || inv.id.slice(0, 8),
        amount: String(inv.totalAmount || '0.00'), status: inv.status,
        dueDate: inv.dueDate, createdAt: inv.createdAt,
    })), 200);
});

// GET /billing/invoices/:id — Invoice detail
const invoiceDetailRoute = createRoute({
    method: 'get', path: '/invoices/{id}',
    summary: 'Get invoice detail with line items', tags: ['Client Billing'],
    request: { params: z.object({ id: z.string() }) },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        id: z.string(), invoiceNumber: z.string(), amount: z.string(),
                        status: z.string(), lineItems: z.array(z.any()),
                    })
                }
            }, description: 'Invoice detail'
        },
        404: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Not found' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

billing.openapi(invoiceDetailRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.valid('param');

    const inv = await prisma.invoice.findUnique({
        where: { id }, include: { items: true },
    });
    if (!inv) return c.json({ error: 'Invoice not found' }, 404);

    return c.json({
        id: inv.id, invoiceNumber: (inv as any).invoiceNumber || inv.id.slice(0, 8),
        amount: String((inv as any).totalAmount || '0.00'), status: inv.status,
        lineItems: (inv as any).items || [],
    }, 200);
});

// GET /billing/statement — Monthly statement summary
const statementRoute = createRoute({
    method: 'get', path: '/statement',
    summary: 'Monthly billing statement summary', tags: ['Client Billing'],
    request: { query: z.object({ month: z.string().optional() }) },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        totalBilled: z.string(), totalPaid: z.string(), outstanding: z.string(),
                        invoiceCount: z.number(),
                    })
                }
            }, description: 'Statement'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

billing.openapi(statementRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = (c.get('jwtPayload') as any).sub;

    const client = await prisma.clientProfile.findFirst({ where: { userId } });
    if (!client) return c.json({ totalBilled: '0.00', totalPaid: '0.00', outstanding: '0.00', invoiceCount: 0 }, 200);

    const invoices = await prisma.invoice.findMany({ where: { clientId: client.id } });
    const totalBilled = invoices.reduce((s: number, i: any) => s + Number(i.totalAmount || 0), 0);
    const paid = invoices.filter((i: any) => i.status === 'paid');
    const totalPaid = paid.reduce((s: number, i: any) => s + Number(i.totalAmount || 0), 0);

    return c.json({
        totalBilled: totalBilled.toFixed(2), totalPaid: totalPaid.toFixed(2),
        outstanding: (totalBilled - totalPaid).toFixed(2), invoiceCount: invoices.length,
    }, 200);
});

// GET /billing/payment-methods — Payment methods on file
const paymentMethodsRoute = createRoute({
    method: 'get', path: '/payment-methods',
    summary: 'List payment methods on file', tags: ['Client Billing'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        id: z.string(), type: z.string(), last4: z.string(), isDefault: z.boolean(),
                    }))
                }
            }, description: 'Payment methods'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

billing.openapi(paymentMethodsRoute, async (c) => {
    // Payment methods would come from Stripe/payment processor
    // For now return a structured placeholder
    return c.json([
        { id: 'pm_default', type: 'card', last4: '4242', isDefault: true },
    ], 200);
});

export default billing;
