import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';

const fleet = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// POST /fleet/heartbeat — PSW sends GPS + battery update
const heartbeatRoute = createRoute({
    method: 'post', path: '/heartbeat',
    summary: 'PSW sends GPS heartbeat (lat/lng, battery, status)', tags: ['Fleet Tracking'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        lat: z.number(), lng: z.number(),
                        batteryLevel: z.number().optional(),
                        status: z.enum(['available', 'en_route', 'on_site', 'offline']).optional(),
                        currentVisitId: z.string().optional(),
                    })
                }
            }
        }
    },
    responses: {
        200: { content: { 'application/json': { schema: z.object({ success: z.boolean() }) } }, description: 'Heartbeat recorded' },
        404: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'PSW not found' },
    },
});

fleet.openapi(heartbeatRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = (c.get('jwtPayload') as any).sub;
    const body = c.req.valid('json');

    const psw = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!psw) return c.json({ error: 'PSW profile not found' }, 404);

    await prisma.fleetStatus.upsert({
        where: { pswId: psw.id },
        update: {
            lat: body.lat, lng: body.lng,
            batteryLevel: body.batteryLevel,
            status: body.status || 'available',
            currentVisitId: body.currentVisitId,
            lastHeartbeatAt: new Date(),
        },
        create: {
            pswId: psw.id, lat: body.lat, lng: body.lng,
            batteryLevel: body.batteryLevel,
            status: body.status || 'available',
            currentVisitId: body.currentVisitId,
        },
    });

    return c.json({ success: true }, 200);
});

// GET /fleet/positions — Live fleet map data
const positionsRoute = createRoute({
    method: 'get', path: '/positions',
    summary: 'Get live positions of all PSWs', tags: ['Fleet Tracking'],
    request: { query: z.object({ status: z.string().optional() }) },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.object({
                        pswId: z.string(), pswName: z.string(),
                        lat: z.number().nullable(), lng: z.number().nullable(),
                        status: z.string(), batteryLevel: z.number().nullable(),
                        currentVisitId: z.string().nullable(), lastHeartbeatAt: z.string(),
                    }))
                }
            }, description: 'Fleet positions'
        },
    },
});

fleet.openapi(positionsRoute, async (c) => {
    const prisma = c.get('prisma');
    const statusFilter = c.req.query('status');

    const where: any = {};
    if (statusFilter) where.status = statusFilter;

    const fleetData = await prisma.fleetStatus.findMany({
        where,
        include: { psw: { select: { fullName: true } } },
    });

    return c.json(fleetData.map((f: any) => ({
        pswId: f.pswId, pswName: f.psw?.fullName || '',
        lat: f.lat, lng: f.lng,
        status: f.status, batteryLevel: f.batteryLevel,
        currentVisitId: f.currentVisitId, lastHeartbeatAt: f.lastHeartbeatAt,
    })), 200);
});

// GET /fleet/eta/:visitId — Estimated arrival for a visit
const etaRoute = createRoute({
    method: 'get', path: '/eta/{visitId}',
    summary: 'Get ETA for a PSW arriving at a visit', tags: ['Fleet Tracking'],
    request: { params: z.object({ visitId: z.string() }) },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        visitId: z.string(), pswId: z.string().nullable(),
                        distanceKm: z.number().nullable(), estimatedMinutes: z.number().nullable(),
                    })
                }
            }, description: 'ETA'
        },
        404: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Not found' },
    },
});

fleet.openapi(etaRoute, async (c) => {
    const prisma = c.get('prisma');
    const { visitId } = c.req.valid('param');

    const visit = await prisma.visit.findUnique({ where: { id: visitId } });
    if (!visit || !visit.assignedPswId) return c.json({ error: 'Visit or PSW not found' }, 404);

    const fleetStatus = await prisma.fleetStatus.findUnique({ where: { pswId: visit.assignedPswId } });

    let distanceKm: number | null = null;
    let estimatedMinutes: number | null = null;

    if (fleetStatus?.lat && fleetStatus?.lng && visit.serviceLat && visit.serviceLng) {
        // Haversine distance
        const R = 6371;
        const dLat = (visit.serviceLat - fleetStatus.lat) * Math.PI / 180;
        const dLng = (visit.serviceLng - fleetStatus.lng) * Math.PI / 180;
        const a = Math.sin(dLat / 2) ** 2 + Math.cos(fleetStatus.lat * Math.PI / 180)
            * Math.cos(visit.serviceLat * Math.PI / 180) * Math.sin(dLng / 2) ** 2;
        distanceKm = Math.round(R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a)) * 10) / 10;
        estimatedMinutes = Math.round(distanceKm / 0.5); // ~30 km/h avg urban speed
    }

    return c.json({ visitId, pswId: visit.assignedPswId, distanceKm, estimatedMinutes }, 200);
});

export default fleet;
