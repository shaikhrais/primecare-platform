import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';
import { ROUTE_METADATA } from '@primecare/shared-utils';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const ScheduleParamsSchema = z.object({
    id: z.string().openapi({
        param: { name: 'id', in: 'path' },
        example: 'visit-uuid',
    }),
});

// GET Assigned Visits
const listVisitsRoute = createRoute({
    ...ROUTE_METADATA.PSW_SCHEDULE.LIST_VISITS,
    method: 'get',
    path: '/',
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'List of assigned visits',
        },
        404: {
            description: 'Profile not found',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(listVisitsRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;

    const profile = await prisma.providerProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const visits = await prisma.visit.findMany({
        where: {
            assignedProviderId: profile.id,
            status: { in: ['scheduled', 'en_route', 'arrived', 'in_progress'] },
        },
        orderBy: { requestedStartAt: 'asc' },
        include: {
            client: { select: { fullName: true, addressLine1: true, city: true } },
            service: true,
        },
    });

    return c.json(visits, 200);
});

// POST Client Not Present (No-Show)
const reportNoShowRoute = createRoute({
    ...ROUTE_METADATA.PSW_SCHEDULE.REPORT_NO_SHOW,
    method: 'post',
    path: '/{id}/no-show',
    request: {
        params: ScheduleParamsSchema,
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({ success: z.boolean(), status: z.string() }),
                },
            },
            description: 'No-show reported successfully',
        },
        400: {
            description: 'Must check-in or wait 15 minutes',
        },
        404: {
            description: 'Visit or profile not found',
        },
    },
});

r.openapi(reportNoShowRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const { id: visitId } = c.req.valid('param');

    const profile = await prisma.providerProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const visit = await prisma.visit.findFirst({
        where: { id: visitId, assignedProviderId: profile.id },
        include: { checkEvents: { where: { eventType: 'check_in' }, orderBy: { serverTime: 'desc' } } }
    });

    if (!visit) return c.json({ error: 'Visit not found' }, 404);

    const checkIn = visit.checkEvents[0];
    if (!checkIn) return c.json({ error: 'Must check-in first before reporting no-show' }, 400);

    const waitTimeMs = 15 * 60 * 1000;
    const elapsed = Date.now() - new Date(checkIn.serverTime || Date.now()).getTime();
    if (elapsed < waitTimeMs) {
        return c.json({
            error: 'You must wait 15 minutes after check-in before flagging as no-show',
            remainingMinutes: Math.ceil((waitTimeMs - elapsed) / 60000)
        }, 400);
    }

    await prisma.$transaction([
        prisma.visit.update({
            where: { id: visitId },
            data: { status: 'no_show' }
        }),
        prisma.auditLog.create({
            data: {
                actorUserId: userId,
                action: 'CLIENT_NO_SHOW',
                resourceType: 'VISIT',
                resourceId: visitId,
                tenantId: profile.tenantId,
                metadata: JSON.stringify({ waitTimeMinutes: 15 })
            }
        })
    ]);

    return c.json({ success: true, status: 'no_show' }, 200);
});

export default r;
