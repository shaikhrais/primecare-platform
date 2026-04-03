import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

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
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

fleet.openapi(heartbeatRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = (c.get('jwtPayload') as any).sub;
    const body = c.req.valid('json');

    const psw = await prisma.providerProfile.findUnique({ where: { userId } });
    if (!psw) return c.json({ error: 'PSW profile not found' }, 404);

    await prisma.fleetStatus.upsert({
        where: { providerId: psw.id },
        update: {
            lat: body.lat, lng: body.lng,
            batteryLevel: body.batteryLevel,
            status: body.status || 'available',
            currentVisitId: body.currentVisitId,
            lastHeartbeatAt: new Date(),
        },
        create: {
            providerId: psw.id, lat: body.lat, lng: body.lng,
            batteryLevel: body.batteryLevel,
            status: body.status || 'available',
            currentVisitId: body.currentVisitId,
        },
    });

    // Feature 19: Fleet Battery Warning
    if (body.batteryLevel && body.batteryLevel < 10 && body.status === 'en_route' && psw.user?.tenantId) {
        const dispatchManager = await prisma.user.findFirst({
            where: { tenantId: psw.user.tenantId, role: 'manager' }
        });

        if (dispatchManager) {
            await prisma.appNotification.create({
                data: {
                    userId: dispatchManager.id,
                    tenantId: psw.user.tenantId,
                    title: 'Fleet Tracking: Critical Battery En-Route',
                    message: `PSW ${psw.user.fullName} is en route to Client with ${body.batteryLevel}% battery. They may lose connectivity shortly.`,
                    type: 'critical'
                }
            });
            console.log(`[Fleet Watchdog] Feature 19 Fired: Critical battery alert sent for ${psw.userId}`);
        }
    }

    // Phase 16: True Real-Time WebSocket Push (0ms Latency Map Sync)
    // Avoids clients needing to poll /fleet/positions
    if (psw.user?.tenantId && c.env.REALTIME_SYNC) {
        try {
            const doId = c.env.REALTIME_SYNC.idFromName(psw.user.tenantId);
            const stub = c.env.REALTIME_SYNC.get(doId);
            
            // Build the WebSocket push payload
            const realtimePayload = {
                type: 'TELEMETRY',
                providerId: psw.id,
                lat: body.lat,
                lng: body.lng,
                status: body.status || 'available',
                batteryLevel: body.batteryLevel
            };

            // Fire and forget POST to the Durable Object's internal /broadcast REST endpoint
            const broadcastUrl = new URL(c.req.url);
            broadcastUrl.pathname = '/broadcast';
            
            c.executionCtx.waitUntil(
                stub.fetch(new Request(broadcastUrl.toString(), {
                    method: 'POST',
                    body: JSON.stringify(realtimePayload)
                }))
            );
        } catch (e) {
            console.error('[Fleet Watchdog] Failed to broadcast telemetry ping to REALTIME_SYNC', e);
        }
    }

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
                        providerId: z.string(), pswName: z.string(),
                        lat: z.number().nullable(), lng: z.number().nullable(),
                        status: z.string(), batteryLevel: z.number().nullable(),
                        currentVisitId: z.string().nullable(), lastHeartbeatAt: z.string(),
                    }))
                }
            }, description: 'Fleet positions'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
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
        providerId: f.providerId, pswName: f.psw?.fullName || '',
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
                        visitId: z.string(), providerId: z.string().nullable(),
                        distanceKm: z.number().nullable(), estimatedMinutes: z.number().nullable(),
                    })
                }
            }, description: 'ETA'
        },
        404: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Not found' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

fleet.openapi(etaRoute, async (c) => {
    const prisma = c.get('prisma');
    const { visitId } = c.req.valid('param');

    const visit = await prisma.visit.findUnique({ where: { id: visitId } });
    if (!visit || !visit.assignedProviderId) return c.json({ error: 'Visit or PSW not found' }, 404);

    const fleetStatus = await prisma.fleetStatus.findUnique({ where: { providerId: visit.assignedProviderId } });

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

    return c.json({ visitId, providerId: visit.assignedProviderId, distanceKm, estimatedMinutes }, 200);
});

export default fleet;
