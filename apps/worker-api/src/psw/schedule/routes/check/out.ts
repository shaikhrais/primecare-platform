import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../../bindings';
import { ROUTE_METADATA } from '../../../../_shared/constants/route_metadata';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const CheckEventSchema = z.object({
    lat: z.number(),
    lng: z.number(),
    accuracy: z.number().optional(),
});

const ScheduleParamsSchema = z.object({
    id: z.string().openapi({
        param: { name: 'id', in: 'path' },
        example: 'visit-uuid',
    }),
});

// POST Check-Out
const checkOutRoute = createRoute({
    ...ROUTE_METADATA.PSW_SCHEDULE.CHECK_OUT,
    method: 'post',
    path: '/{id}/check-out',
    request: {
        params: ScheduleParamsSchema,
        body: {
            content: {
                'application/json': {
                    schema: CheckEventSchema,
                },
            },
        },
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'Check-out successful',
        },
        404: {
            description: 'Profile not found',
        },
    },
});

r.openapi(checkOutRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const { id: visitId } = c.req.valid('param');
    const { lat, lng, accuracy } = c.req.valid('json');

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const [event] = await prisma.$transaction([
        prisma.visitCheckEvent.create({
            data: {
                visitId,
                pswId: profile.id,
                eventType: 'check_out',
                lat,
                lng,
                accuracyM: accuracy,
                result: 'success',
                tenantId: profile.tenantId
            },
        }),
        prisma.visit.update({
            where: { id: visitId },
            data: { status: 'completed' },
        }),
        prisma.auditLog.create({
            data: {
                actorUserId: userId,
                action: 'CHECK_OUT',
                resourceType: 'VISIT',
                resourceId: visitId,
                metadataJson: { lat, lng },
                tenantId: profile.tenantId
            }
        })
    ]);

    return c.json(event, 200);
});

export default r;

