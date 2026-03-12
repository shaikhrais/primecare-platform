import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { ROUTE_METADATA } from '../../../_shared/constants/route_metadata';

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

const calculateDistance = (lat1: number, lon1: number, lat2: number, lon2: number) => {
    const R = 6371e3; // Earth radius in meters
    const phi1 = lat1 * Math.PI / 180;
    const phi2 = lat2 * Math.PI / 180;
    const dPhi = (lat2 - lat1) * Math.PI / 180;
    const dLambda = (lon2 - lon1) * Math.PI / 180;

    const a = Math.sin(dPhi / 2) * Math.sin(dPhi / 2) +
        Math.cos(phi1) * Math.cos(phi2) *
        Math.sin(dLambda / 2) * Math.sin(dLambda / 2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

    return R * c; // Distance in meters
};

// POST Check-In
const checkInRoute = createRoute({
    ...ROUTE_METADATA.PSW_SCHEDULE.CHECK_IN,
    method: 'post',
    path: '/{id}/check-in',
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
            content: { 'application/json': { schema: z.any() } },
            description: 'Check-in successful',
        },
        400: {
            content: { 'application/json': { schema: z.any() } },
            description: 'Validation error (e.g., too far)',
        },
        404: {
            description: 'Visit or profile not found',
        },
    },
});

r.openapi(checkInRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const { id: visitId } = c.req.valid('param');
    const { lat, lng, accuracy } = c.req.valid('json');

    const profile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const visit = await prisma.visit.findUnique({
        where: { id: visitId },
        include: { client: true },
    });
    if (!visit || visit.assignedPswId !== profile.id) {
        return c.json({ error: 'Visit not found or not assigned' }, 404);
    }

    // Feature 12: EVV GPS Validation
    let isEvvFlagged = false;
    let distance = 0;
    if (visit.client?.lat && visit.client?.lng) {
        distance = calculateDistance(lat, lng, visit.client.lat, visit.client.lng);
        if (distance > 300) {
            isEvvFlagged = true;
            console.log(`[Worker] Feature 12 Fired: EVV validation failed (>300m). Creating Technical Audit.`);
        }
    }

    const [event] = await prisma.$transaction([
        prisma.visitCheckEvent.create({
            data: {
                visitId, pswId: profile.id, eventType: 'check_in',
                lat, lng, accuracyM: accuracy, result: isEvvFlagged ? 'flagged_distance' : 'success', tenantId: profile.tenantId
            },
        }),
        prisma.visit.update({ where: { id: visitId }, data: { status: 'in_progress' } }),
        prisma.auditLog.create({
            data: {
                actorUserId: userId, action: 'CHECK_IN', resourceType: 'VISIT',
                resourceId: visitId, metadataString: JSON.stringify({ lat, lng, isEvvFlagged, distance }), tenantId: profile.tenantId
            }
        }),
        // Only run if flagged
        ...(isEvvFlagged ? [
             prisma.systemEvent.create({
                 data: {
                     tenantId: profile.tenantId,
                     operation: 'AUDIT_FAILURE',
                     modelName: 'VisitCheckEvent',
                     entityId: visitId,
                     payload: JSON.stringify({ reason: 'EVV Distance Exceeded', distance, threshold: 300 })
                 }
             })
        ] : [])
    ]);

    return c.json(event, 200);
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
            content: { 'application/json': { schema: z.any() } },
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

    let distance = 0;
    let isEvvFlagged = false;
    const visit = await prisma.visit.findUnique({ where: { id: visitId }, include: { client: true } });

    if (visit?.client?.lat && visit?.client?.lng) {
        distance = calculateDistance(lat, lng, visit.client.lat, visit.client.lng);
        if (distance > 300) {
            isEvvFlagged = true;
        }
    }

    const [event] = await prisma.$transaction([
        prisma.visitCheckEvent.create({
            data: {
                visitId, pswId: profile.id, eventType: 'check_out',
                lat, lng, accuracyM: accuracy, result: isEvvFlagged ? 'flagged_distance' : 'success', tenantId: profile.tenantId
            },
        }),
        prisma.visit.update({ where: { id: visitId }, data: { status: 'completed' } }),
        prisma.auditLog.create({
            data: {
                actorUserId: userId, action: 'CHECK_OUT', resourceType: 'VISIT',
                resourceId: visitId, metadataString: JSON.stringify({ lat, lng, isEvvFlagged, distance }), tenantId: profile.tenantId
            }
        })
    ]);

    return c.json(event, 200);
});

export default r;
