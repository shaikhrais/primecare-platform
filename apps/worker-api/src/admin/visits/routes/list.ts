import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET /
const listVisitsRoute = createRoute({
    method: 'get',
    path: '/',
    summary: 'List All Visits',
    description: 'Retrieve a list of all visits with client, psw, and service details.',
    tags: ['Admin Visits'],
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




