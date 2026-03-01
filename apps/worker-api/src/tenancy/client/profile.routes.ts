import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../';
import { requireRole } from '../../middleware/rbac';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const getProfileRoute = createRoute({
    method: 'get',
    path: '/profile',
    middleware: [requireRole(['client', 'admin'])],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'Client profile',
        },
    },
});

r.openapi(getProfileRoute, async (c) => {
    return c.json({ name: 'Mock Client Profile' }, 200);
});

export default r;
