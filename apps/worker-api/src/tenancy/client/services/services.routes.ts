import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { ROUTE_METADATA } from '../../../_shared/constants/route_metadata';
import { requireRole } from '../../../_shared/middleware/rbac';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET Invoices
const listInvoicesRoute = createRoute({
    ...ROUTE_METADATA.CLIENT.INVOICES,
    method: 'get',
    path: '/invoices',
    middleware: [requireRole(['client'])],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'List of invoices',
        },
        404: {
            description: 'Profile not found',
        },
    },
});

r.openapi(listInvoicesRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;

    const profile = await prisma.clientProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const invoices = await prisma.invoice.findMany({
        where: { clientId: profile.id },
        orderBy: { createdAt: 'desc' },
        include: { payments: true },
    });

    return c.json(invoices, 200);
});

// GET Available Services
const listServicesRoute = createRoute({
    ...ROUTE_METADATA.CLIENT.SERVICES,
    method: 'get',
    path: '/services',
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'List of services',
        },
    },
});

r.openapi(listServicesRoute, async (c) => {
    const prisma = c.get('prisma');
    const services = await prisma.service.findMany({
        where: { tenantId: c.get('jwtPayload').tenantId }
    });
    return c.json(services, 200);
});

export default r;
