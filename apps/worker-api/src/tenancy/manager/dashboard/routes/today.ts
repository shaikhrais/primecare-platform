import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../../bindings';
import { requirePermission } from '../../../../_shared/middleware/rbac';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const getTodayRoute = createRoute({
    method: 'get',
    path: '/today',
    middleware: [requirePermission('view_schedule')],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(
                        z.object({
                            id: z.string(),
                            requestedStartAt: z.string().datetime(),
                            requestedEndAt: z.string().datetime(),
                            client: z.object({ fullName: z.string() }),
                            psw: z.object({ fullName: z.string() }),
                            service: z.object({ name: z.string() }),
                        })
                    ),
                },
            },
            description: 'Today visits for ShiftTimeline',
        },
    },
});

r.openapi(getTodayRoute as any, async (c: any) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;
    const todayStart = new Date();
    todayStart.setHours(0, 0, 0, 0);
    const todayEnd = new Date(todayStart.getTime() + 24 * 60 * 60 * 1000);

    const visits = await prisma.visit.findMany({
        where: {
            tenantId,
            requestedStartAt: {
                gte: todayStart,
                lt: todayEnd
            }
        },
        include: {
            client: { select: { fullName: true } },
            psw: { select: { fullName: true } },
            service: { select: { name: true } }
        },
        orderBy: { requestedStartAt: 'asc' },
        take: 10
    });

    return c.json(visits as any, 200);
});

export default r;
