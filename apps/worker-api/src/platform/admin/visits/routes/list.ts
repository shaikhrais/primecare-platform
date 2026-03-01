import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../../';
import { ROUTE_METADATA } from '../../../../constants/route_metadata';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET /
const listVisitsRoute = createRoute({
    ...ROUTE_METADATA.ADMIN_VISITS.LIST,
    method: 'get',
    path: '/',
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'List of visits',
        },
    },
});

r.openapi(listVisitsRoute, async (c) => {
    const prisma = c.get('prisma');
    const visits = await prisma.visit.findMany({
        include: {
            client: { select: { fullName: true, addressLine1: true } },
            psw: { select: { fullName: true } },
            service: true,
        },
        orderBy: { requestedStartAt: 'desc' },
    });
    return c.json(visits, 200);
});

export default r;




