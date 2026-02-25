import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import { requireRole } from '../../_shared/middleware/rbac';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET Invoices
const listInvoicesRoute = createRoute({
    method: 'get',
    path: '/invoices',
    summary: 'List Client Invoices',
    description: 'Retrieve a list of all invoices for the authenticated client.',
    tags: ['Client Services'],
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
    method: 'get',
    path: '/services',
    summary: 'List Available Services',
    description: 'Retrieve a list of all available services for the current tenant.',
    tags: ['Client Services'],
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
