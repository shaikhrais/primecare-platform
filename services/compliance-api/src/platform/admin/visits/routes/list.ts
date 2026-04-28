import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';
import { ROUTE_METADATA } from '@primecare/infrastructure';
import { VisitService } from '../visits.service';

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
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(listVisitsRoute, async (c) => {
    const service = new VisitService(c.get('prisma'));
    const visits = await service.list();
    return c.json(visits, 200);
});

export default r;
