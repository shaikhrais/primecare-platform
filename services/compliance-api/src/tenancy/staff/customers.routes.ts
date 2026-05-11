import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';
import { requirePermission } from '@primecare/security';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const getCustomersRoute = createRoute({
    method: 'get',
    path: '/customers',
    summary: 'Get Customers',
    tags: ['Staff'],
    middleware: [requirePermission('view_users')],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'Customers list',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(getCustomersRoute, async (c) => {
    const prisma = c.get('prisma');
    const payload = c.get('jwtPayload') as any;

    try {
        const customers = await prisma.clientProfile.findMany({
            where: { tenantId: payload.tenantId },
            include: { user: { select: { email: true, status: true } } }
        });
        return c.json(customers, 200);
    } catch (e) {
        return c.json([], 200);
    }
});

export default r;
