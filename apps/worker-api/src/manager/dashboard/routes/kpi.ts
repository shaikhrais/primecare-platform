import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { requireRole } from '../../../_shared/middleware/rbac';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const getKpiRoute = createRoute({
    method: 'get',
    path: '/kpi',
    middleware: [requireRole(['manager', 'admin', 'coordinator'])],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        revenue: z.number(),
                        fulfillment: z.number(),
                        satisfaction: z.number(),
                        utilization: z.number()
                    }),
                },
            },
            description: 'KPI stats',
        },
    },
});

r.openapi(getKpiRoute, async (c) => {
    return c.json({
        revenue: 125000,
        fulfillment: 92.5,
        satisfaction: 4.8,
        utilization: 88
    }, 200);
});

export default r;
