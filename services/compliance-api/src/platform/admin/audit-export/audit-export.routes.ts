import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';

const auditExport = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET /download — CSV export of audit logs
const downloadRoute = createRoute({
    method: 'get', path: '/download',
    summary: 'Download Audit Logs (CSV)', tags: ['Audit Export'],
    request: { query: z.object({ startDate: z.string(), endDate: z.string(), action: z.string().optional() }) },
    responses: { 200: { description: 'CSV download' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

auditExport.openapi(downloadRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const { startDate, endDate, action } = c.req.valid('query');

    const where: any = {
        tenantId, createdAt: { gte: new Date(startDate), lte: new Date(endDate) },
    };
    if (action) where.action = action;

    const logs = await prisma.auditLog.findMany({
        where, orderBy: { createdAt: 'asc' },
        include: { actor: { select: { email: true } } },
    });

    const header = 'timestamp,actor_email,action,resource_type,resource_id\n';
    const rows = logs.map((l: any) =>
        `${l.createdAt.toISOString()},${l.actor?.email || 'system'},${l.action},${l.resourceType},${l.resourceId}`
    ).join('\n');

    return new Response(header + rows, {
        headers: {
            'Content-Type': 'text/csv',
            'Content-Disposition': `attachment; filename=audit-log-${startDate}-to-${endDate}.csv`,
        },
    });
});

// GET /compliance-home — PHIPA compliance score
const complianceDashRoute = createRoute({
    method: 'get', path: '/compliance-home',
    summary: 'PHIPA Compliance Home', tags: ['Audit Export'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        overallScore: z.number(),
                        expiredCredentials: z.number(),
                        unsignedConsents: z.number(),
                        lateCheckIns: z.number(),
                        incompleteTraining: z.number(),
                        recentAuditActions: z.number(),
                    })
                }
            }, description: 'Home'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

auditExport.openapi(complianceDashRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;

    const now = new Date();
    const thirtyDaysAgo = new Date(); thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);

    const [expiredCreds, unsignedConsents, lateCheckIns, incompleteTraining, recentActions] = await Promise.all([
        // Expired credentials — PSWs with credential expiry in the past
        prisma.pswDocument.count({ where: { psw: { tenantId }, expiryDate: { lt: now } } }).catch(() => 0),
        // Unsigned consent forms
        prisma.consentForm.count({ where: { tenantId, status: 'pending' } }).catch(() => 0),
        // Late check-ins (exceptions in EVV)
        prisma.eVVRecord.count({ where: { tenantId, status: 'exception' } }).catch(() => 0),
        // Incomplete training assignments
        prisma.trainingAssignment.count({ where: { status: 'assigned' } }).catch(() => 0),
        // Recent audit actions
        prisma.auditLog.count({ where: { tenantId, createdAt: { gte: thirtyDaysAgo } } }),
    ]);

    // Score: 100 minus deductions
    const deductions = (expiredCreds * 5) + (unsignedConsents * 3) + (lateCheckIns * 2) + (incompleteTraining * 1);
    const overallScore = Math.max(0, Math.min(100, 100 - deductions));

    return c.json({
        overallScore, expiredCredentials: expiredCreds,
        unsignedConsents, lateCheckIns, incompleteTraining, recentAuditActions: recentActions,
    }, 200);
});

// GET /regulatory-report — Formatted report for MOHLTC
const regulatoryRoute = createRoute({
    method: 'get', path: '/regulatory-report',
    summary: 'MOHLTC Regulatory Report', tags: ['Audit Export'],
    request: { query: z.object({ quarter: z.string().optional() }) },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        period: z.string(), activeClients: z.number(), activeStaff: z.number(),
                        totalVisits: z.number(), completedVisits: z.number(),
                        incidentCount: z.number(), avgSatisfaction: z.number(),
                        evvCompliance: z.number(),
                    })
                }
            }, description: 'Report'
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

auditExport.openapi(regulatoryRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = (c.get('jwtPayload') as any).tenantId;
    const { quarter } = c.req.valid('query');

    const now = new Date();
    const qStart = quarter ? new Date(quarter) : new Date(now.getFullYear(), Math.floor(now.getMonth() / 3) * 3, 1);
    const qEnd = new Date(qStart); qEnd.setMonth(qEnd.getMonth() + 3);

    const [clients, staff, totalVisits, completedVisits, incidents, feedbacks, evvValid, evvTotal] = await Promise.all([
        prisma.clientProfile.count({ where: { tenantId, status: 'active' } }),
        prisma.providerProfile.count({ where: { tenantId } }),
        prisma.visit.count({ where: { createdAt: { gte: qStart, lt: qEnd } } }),
        prisma.visit.count({ where: { status: 'completed', createdAt: { gte: qStart, lt: qEnd } } }),
        prisma.incident.count({ where: { tenantId, createdAt: { gte: qStart, lt: qEnd } } }),
        prisma.feedback.findMany({ where: { tenantId, createdAt: { gte: qStart, lt: qEnd } } }),
        prisma.eVVRecord.count({ where: { tenantId, status: { in: ['valid', 'overridden'] }, capturedAt: { gte: qStart, lt: qEnd } } }).catch(() => 0),
        prisma.eVVRecord.count({ where: { tenantId, capturedAt: { gte: qStart, lt: qEnd } } }).catch(() => 0),
    ]);

    const avgSat = feedbacks.length > 0 ? feedbacks.reduce((s: number, f: any) => s + f.rating, 0) / feedbacks.length : 0;

    return c.json({
        period: `${qStart.toISOString().split('T')[0]} to ${qEnd.toISOString().split('T')[0]}`,
        activeClients: clients, activeStaff: staff,
        totalVisits, completedVisits, incidentCount: incidents,
        avgSatisfaction: Math.round(avgSat * 10) / 10,
        evvCompliance: evvTotal > 0 ? Math.round((evvValid / evvTotal) * 10000) / 100 : 100,
    }, 200);
});

export default auditExport;
