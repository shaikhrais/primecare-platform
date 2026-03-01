import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { requireRole } from '../../../_shared/middleware/rbac';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const getTodayRoute = createRoute({
    method: 'get',
    path: '/today',
    middleware: [requireRole(['manager', 'admin', 'coordinator'])],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        activeShifts: z.number(),
                        incidents: z.number(),
                        pendingApprovals: z.number(),
                        urgentMessages: z.number()
                    }),
                },
            },
            description: 'Today stats',
        },
    },
});

r.openapi(getTodayRoute, async (c) => {
    return c.json({
        activeShifts: 12,
        incidents: 1,
        pendingApprovals: 5,
        urgentMessages: 3
    }, 200);
});

export default r;
