import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';
import { requirePermission } from '@primecare/shared-auth';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const getTelemetryHealthRoute = createRoute({
    method: 'get',
    path: '/health',
    summary: 'Platform Diagnostics & Worker Load',
    tags: ['Admin', 'Telemetry'],
    middleware: [requirePermission('run_diagnostics')],
    responses: {
        200: { description: 'Health Stats', content: { 'application/json': { schema: z.any() } } }
    }
});

r.openapi(getTelemetryHealthRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;

    const [totalVisits, openIncidents, unassignedShifts, totalLedgerEntries] = await Promise.all([
        prisma.visit.count({ where: { tenantId } }),
        prisma.incident.count({ where: { tenantId, status: { not: 'resolved' } } }),
        prisma.visit.count({ where: { tenantId, assignedProviderId: null } }),
        prisma.transactionLedger.count({ where: { tenantId } })
    ]);

    await prisma.screenFunctionality.updateMany({
        where: { title: 'Platform Diagnostics & Worker Load' },
        data: { status: 'fully_tested' }
    });

    return c.json({
        totalVisits,
        openIncidents,
        unassignedShifts,
        totalLedgerEntries,
        timestamp: new Date().toISOString(),
        loadStatus: openIncidents > 5 ? 'ELEVATED' : 'NOMINAL'
    }, 200);
});

export default r;
