import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../';
import { ROUTE_METADATA } from '../../../constants/route_metadata';
import { requirePermission } from '../../../middleware/rbac';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const PswParamsSchema = z.object({
    pswId: z.string().openapi({ param: { name: 'pswId', in: 'path' } }),
});

/**
 * RN supervisor view of PSW logs/performance
 */
const getPswSupervisionOverviewRoute = createRoute({
    ...ROUTE_METADATA.RN.SUPERVISION_OVERVIEW,
    method: 'get',
    path: '/psw/{pswId}/overview',
    middleware: [requirePermission('PSW_SUPERVISE')],
    request: {
        params: PswParamsSchema,
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        psw: z.any(),
                        recentVisits: z.array(z.any()),
                        recentIncidents: z.array(z.any()),
                    }),
                },
            },
            description: 'PSW supervision overview',
        },
        404: {
            description: 'PSW not found',
        },
    },
});

r.openapi(getPswSupervisionOverviewRoute, async (c) => {
    const prisma = c.get('prisma');
    const { pswId } = c.req.valid('param');

    const [psw, visits, profile] = await Promise.all([
        prisma.pswProfile.findUnique({
            where: { id: pswId },
            include: { user: { select: { email: true } } }
        }),
        prisma.visit.findMany({
            where: { assignedPswId: pswId },
            take: 10,
            orderBy: { requestedStartAt: 'desc' },
            include: { client: { select: { fullName: true } } }
        }),
        prisma.pswProfile.findUnique({ where: { id: pswId }, select: { userId: true } })
    ]);

    if (!psw) return c.json({ error: 'PSW not found' }, 404);

    const incidents = profile?.userId ? await prisma.incident.findMany({
        where: { reporterUserId: profile.userId },
        take: 5,
        orderBy: { createdAt: 'desc' }
    }) : [];

    return c.json({
        psw,
        recentVisits: visits,
        recentIncidents: incidents
    }, 200);
});

export default r;
