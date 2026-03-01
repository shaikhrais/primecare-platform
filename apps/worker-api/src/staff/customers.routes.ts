import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../bindings';
import { requireRole } from '../_shared/middleware/rbac';

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
    return c.json([], 200);
});

export default r;
