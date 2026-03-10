import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import { requireRole } from '../../_shared/middleware/rbac';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const getCustomersRoute = createRoute({
    method: 'get',
    path: '/customers',
    middleware: [requireRole(['staff', 'admin'])],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'Customers list',
        },
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
