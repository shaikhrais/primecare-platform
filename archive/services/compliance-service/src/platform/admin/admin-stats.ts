/**
 * Admin Stats Handler
 * Extracted from admin.module.ts
 */
import { createRoute, z } from '@hono/zod-openapi';

export const statsRoute = createRoute({
    method: 'get', path: '/stats', summary: 'Get Admin Home Statistics',
    description: 'Returns total counts for users, pending visits, total visits, and leads.',
    tags: ['Admin'],
    responses: {
        200: { content: { 'application/json': { schema: z.object({ totalUsers: z.number(), pendingVisits: z.number(), totalVisits: z.number(), totalLeads: z.number() }) } }, description: 'Success' },
        500: { content: { 'application/json': { schema: z.object({ error: z.string(), details: z.string().optional() }) } }, description: 'Internal Server Error' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

export async function handleAdminStats(c: any) {
    const prisma = c.get('prisma');
    const sevenDaysFromNow = new Date(); sevenDaysFromNow.setDate(sevenDaysFromNow.getDate() + 7);
    const threeDaysAgo = new Date(); threeDaysAgo.setDate(threeDaysAgo.getDate() - 3);
    let totalUsers = 0, pendingVisits = 0, totalVisits = 0, totalLeads = 0;
    let complianceRisk = 0, coverageGap = 0, pipelineStagnation = 0;
    try {
        const results = await Promise.all([
            prisma.user.count(), prisma.visit.count({ where: { status: 'requested' } }), prisma.visit.count(), prisma.lead.count(),
            prisma.pswDocument.count({ where: { status: 'pending' } }),
            prisma.visit.count({ where: { status: 'requested', requestedStartAt: { lte: sevenDaysFromNow } } }),
            prisma.lead.count({ where: { status: 'new', createdAt: { lte: threeDaysAgo } } })
        ]);
        [totalUsers, pendingVisits, totalVisits, totalLeads, complianceRisk, coverageGap, pipelineStagnation] = results;
    } catch (e) { /* R15: Don't leak internal errors */ }
    let modelScore = 0;
    try {
        const tenant = await prisma.tenant.findFirst({ select: { businessNumber: true, supportEmail: true, logoUrl: true, taxSettings: true } });
        if (tenant) { if (tenant?.businessNumber) modelScore += 25; if (tenant?.supportEmail) modelScore += 25; if (tenant?.logoUrl) modelScore += 25; if (tenant?.taxSettings) modelScore += 25; }
    } catch (e) { /* R15: Don't leak schema sync details */ }
    return c.json({ totalUsers, pendingVisits, totalVisits, totalLeads, modelScore, MTD_REVENUE: "0.00", healthAlerts: { complianceRisk, coverageGap, pipelineStagnation } }, 200);
}
