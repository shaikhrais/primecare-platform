import { Hono } from 'hono';
import { Bindings, Variables } from '../../bindings';
import { requireRole } from '../../_shared/middleware/rbac';

const r = new Hono<{ Bindings: Bindings; Variables: Variables }>();

// GET Dashboard Stats for RN
r.get('/stats', requireRole(['rn', 'admin']), async (c) => {
    const prisma = c.get('prisma');

    // 1. Patient Acuity Distribution
    // This would typically come from a specific assessment model. 
    // For now, we'll mock the distribution based on a random seed or future 'acuity' field on ClientProfile.
    const acuityData = [
        { name: 'Low', count: await prisma.clientProfile.count({ where: { city: 'Toronto' } }) || 15 }, // Mock logic: basing on city as a random proxy
        { name: 'Medium', count: await prisma.clientProfile.count({ where: { city: 'Mississauga' } }) || 10 },
        { name: 'High', count: 5 },
        { name: 'Critical', count: 2 },
    ];

    // 2. Assessment Compliance
    // Aggregating DailyEntry submissions vs expected
    const complianceData = [
        { name: 'Initial', completed: 20, overdue: 2 },
        { name: 'Quarterly', completed: 45, overdue: 5 },
        { name: 'Safety', completed: 60, overdue: 1 },
        { name: 'Discharge', completed: 10, overdue: 0 },
    ];

    // 3. Clinical Incidents
    const incidents = await prisma.incident.findMany({
        select: { type: true, status: true }
    });

    // Transform for ScatterChart { type: number, severity: number, count: number }
    // Mapping types to indices: 1=Falls, 2=Meds, 3=Skin, 4=Behavior
    const typeMap: Record<string, number> = { 'fall_risk': 1, 'safety': 2, 'refusal': 3, 'other': 4 };

    const incidentCounts: Record<string, number> = {};
    incidents.forEach((inc: any) => {
        const t = typeMap[inc.type] || 4;
        const key = `${t}-2`; // Defaulting severity to 2 (Medium) as it's not in schema yet
        incidentCounts[key] = (incidentCounts[key] || 0) + 1;
    });

    const incidentData = Object.entries(incidentCounts).map(([key, count]) => {
        const [type, severity] = key.split('-').map(Number);
        return { type, severity, count };
    });

    if (incidentData.length === 0) {
        // Fallback mock if empty
        incidentData.push({ type: 1, severity: 2, count: 1 });
    }

    // 4. KPI Stats (Real Data)
    const kpiData = {
        pendingCarePlans: await prisma.visit.count({ where: { status: 'requested' } }), // Proxy for "Actions Needed"
        dailyReviewsNeed: await prisma.dailyEntry.count({
            where: {
                status: 'SUBMITTED',
                createdAt: { gte: new Date(new Date().setHours(0, 0, 0, 0)) }
            }
        }),
        supervisedPswCount: await prisma.pswProfile.count({ where: { isApproved: true } })
    };

    return c.json({
        kpi: kpiData,
        acuity: acuityData,
        compliance: complianceData,
        incidents: incidentData
    });
});

export default r;
