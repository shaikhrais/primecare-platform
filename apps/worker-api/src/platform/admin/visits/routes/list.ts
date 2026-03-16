import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../../bindings';
import { ROUTE_METADATA } from '../../../../_shared/constants/route_metadata';
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
    },
});

r.openapi(listVisitsRoute, async (c) => {
    const service = new VisitService(c.get('prisma'));
    const visits = await service.list();
    return c.json(visits, 200);
});

export default r;
