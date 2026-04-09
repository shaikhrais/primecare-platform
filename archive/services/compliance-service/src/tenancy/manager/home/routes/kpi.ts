import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';
import { requirePermission } from '@primecare/shared-auth';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const getKpiRoute = createRoute({
    method: 'get',
    path: '/kpi',
    middleware: [requirePermission('view_reports')],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        activeClients: z.number(),
                        staffOnDuty: z.number(),
                        openIncidents: z.number(),
                        todayShifts: z.number()
                    }),
                },
            },
            description: 'KPI stats',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(getKpiRoute as any, async (c: any) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;
    const todayStart = new Date();
    todayStart.setHours(0, 0, 0, 0);

    const [activeClients, staffOnDuty, openIncidents, todayShifts] = await Promise.all([
        prisma.clientProfile.count({
            where: { tenantId }
        }),
        prisma.fleetStatus.count({
            where: { psw: { tenantId }, status: { not: 'offline' } }
        }),
        prisma.incident.count({
            where: { tenantId, status: 'open' }
        }),
        prisma.visit.count({
            where: {
                tenantId,
                requestedStartAt: {
                    gte: todayStart,
                    lt: new Date(todayStart.getTime() + 24 * 60 * 60 * 1000)
                }
            }
        })
    ]);

    return c.json({
        activeClients,
        staffOnDuty,
        openIncidents,
        todayShifts
    } as any, 200);
});

export default r;
