import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

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

export default billing;
