/**
 * Operations Center Handler — /ops/center
 * Returns real-time fleet status, active visits, operational alerts, and KPIs.
 */
import { createRoute, z } from '@hono/zod-openapi';

export const opsCenterRoute = createRoute({
    method: 'get', path: '/ops/center', summary: 'Live Operations Center Data',
    description: 'Aggregated real-time view: fleet status, active visits, operational alerts, and key metrics.',
    tags: ['Admin', 'Operations'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        stats: z.object({
                            activeVisits: z.number(),
                            enRoutePsws: z.number(),
                            availablePool: z.number(),
                            completedToday: z.number(),
                            incidentsOpen: z.number(),
                            avgResponseMin: z.number(),
                            utilizationRate: z.number(),
                            lateArrivals: z.number(),
                        }),
                        fleet: z.array(z.object({
                            id: z.string(),
                            name: z.string(),
                            status: z.string(),
                            lat: z.number().optional(),
                            lng: z.number().optional(),
                            currentVisitId: z.string().optional(),
                            batteryLevel: z.number().optional(),
                            lastHeartbeatAt: z.string(),
                        })),
                        visits: z.array(z.object({
                            id: z.string(),
                            clientName: z.string(),
                            pswName: z.string(),
                            status: z.string(),
                            startAt: z.string(),
                            duration: z.number(),
                            city: z.string().optional(),
                            checkInAt: z.string().optional(),
                            checkOutAt: z.string().optional(),
                        })),
                        alerts: z.array(z.object({
                            id: z.string(),
                            type: z.string(),
                            severity: z.string(),
                            message: z.string(),
                            timestamp: z.string(),
                            visitId: z.string().optional(),
                            providerId: z.string().optional(),
                        })),
                    }),
                },
            },
            description: 'Operations center data',
        },
        500: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Internal Server Error' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

export async function handleOpsCenter(c: any) {
    const prisma = c.get('prisma');
    const tenantId = c.get('tenantId');

    const todayStart = new Date();
    todayStart.setHours(0, 0, 0, 0);
    const now = new Date();

    try {
        // ── Parallel data fetch ──
        const [
            fleetRows,
            activeVisitRows,
            completedCount,
            openIncidentCount,
            recentCheckEvents,
        ] = await Promise.all([
            // 1. Fleet status
            prisma.fleetStatus.findMany({
                include: { psw: { select: { fullName: true } } },
            }),
            // 2. Active visits for today (not completed/cancelled)
            prisma.visit.findMany({
                where: {
                    tenantId,
                    requestedStartAt: { gte: todayStart },
                    status: { notIn: ['completed', 'cancelled'] },
                },
                include: {
                    client: { select: { fullName: true } },
                    psw: { select: { fullName: true } },
                },
                orderBy: { requestedStartAt: 'asc' },
                take: 50,
            }),
            // 3. Completed today
            prisma.visit.count({
                where: { tenantId, status: 'completed', updatedAt: { gte: todayStart } },
            }),
            // 4. Open incidents
            prisma.incident.count({
                where: { tenantId, status: { in: ['open', 'investigating'] } },
            }),
            // 5. Recent check-in events (for lateness detection)
            prisma.visitCheckEvent.findMany({
                where: {
                    tenantId,
                    createdAt: { gte: todayStart },
                    eventType: 'check_in',
                },
                orderBy: { createdAt: 'desc' },
                take: 50,
            }),
        ]);

        // ── Transform fleet data ──
        const fleet = fleetRows.map((f: any) => ({
            id: f.id,
            name: f.psw?.fullName || 'Unknown',
            status: f.status || 'offline',
            lat: f.lat,
            lng: f.lng,
            currentVisitId: f.currentVisitId,
            batteryLevel: f.batteryLevel,
            lastHeartbeatAt: f.lastHeartbeatAt?.toISOString() || now.toISOString(),
        }));

        // ── Transform visits ──
        const visits = activeVisitRows.map((v: any) => {
            const checkIn = recentCheckEvents.find((e: any) => e.visitId === v.id && e.eventType === 'check_in');
            return {
                id: v.id,
                clientName: v.client?.fullName || 'Unknown Client',
                pswName: v.psw?.fullName || 'Unassigned',
                status: v.status || 'requested',
                startAt: v.requestedStartAt?.toISOString() || '',
                duration: v.durationMinutes || 0,
                city: v.serviceCity || undefined,
                checkInAt: checkIn?.createdAt?.toISOString() || undefined,
            };
        });

        // ── Compute stats ──
        const enRouteCount = fleet.filter((f: any) => f.status === 'en_route').length;
        const availableCount = fleet.filter((f: any) => f.status === 'available').length;
        const onSiteCount = fleet.filter((f: any) => f.status === 'on_site').length;
        const totalFleet = fleet.length || 1;
        const utilizationRate = Math.round(((onSiteCount + enRouteCount) / totalFleet) * 100);

        // Late arrivals: visits past start time with no check-in
        const lateArrivals = activeVisitRows.filter((v: any) => {
            const startTime = new Date(v.requestedStartAt);
            const isOverdue = startTime < now;
            const hasCheckIn = recentCheckEvents.some((e: any) => e.visitId === v.id);
            return isOverdue && !hasCheckIn && v.status !== 'completed' && v.status !== 'cancelled';
        }).length;

        // ── Generate smart alerts ──
        const alerts: any[] = [];

        // Late arrival alerts
        activeVisitRows.forEach((v: any) => {
            const startTime = new Date(v.requestedStartAt);
            const minsLate = Math.round((now.getTime() - startTime.getTime()) / 60000);
            if (minsLate > 15 && !recentCheckEvents.some((e: any) => e.visitId === v.id)) {
                alerts.push({
                    id: `late-${v.id}`,
                    type: 'late_arrival',
                    severity: minsLate > 30 ? 'critical' : 'warning',
                    message: `${v.psw?.fullName || 'PSW'} is ${minsLate}min late for ${v.client?.fullName || 'client'} visit`,
                    timestamp: now.toISOString(),
                    visitId: v.id,
                    providerId: v.assignedProviderId,
                });
            }
        });

        // Unassigned visit alerts
        activeVisitRows.filter((v: any) => !v.assignedProviderId).forEach((v: any) => {
            alerts.push({
                id: `unassigned-${v.id}`,
                type: 'unassigned',
                severity: 'warning',
                message: `Visit for ${v.client?.fullName || 'client'} has no assigned PSW`,
                timestamp: now.toISOString(),
                visitId: v.id,
            });
        });

        // Low battery alerts
        fleet.filter((f: any) => f.batteryLevel != null && f.batteryLevel < 20).forEach((f: any) => {
            alerts.push({
                id: `battery-${f.id}`,
                type: 'low_battery',
                severity: f.batteryLevel < 10 ? 'critical' : 'warning',
                message: `${f.name}'s device battery is at ${f.batteryLevel}%`,
                timestamp: now.toISOString(),
                providerId: f.id,
            });
        });

        // Sort alerts: critical first
        alerts.sort((a: any, b: any) => {
            const order: Record<string, number> = { critical: 0, warning: 1, info: 2 };
            return (order[a.severity] || 2) - (order[b.severity] || 2);
        });

        const stats = {
            activeVisits: activeVisitRows.length,
            enRoutePsws: enRouteCount,
            availablePool: availableCount,
            completedToday: completedCount,
            incidentsOpen: openIncidentCount,
            avgResponseMin: 12, // Placeholder — would compute from check events
            utilizationRate,
            lateArrivals,
        };

        return c.json({ stats, fleet, visits, alerts }, 200);
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
        return c.json({ error: 'Failed to load operations data' }, 500);
    }
}
