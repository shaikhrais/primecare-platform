import { Hono } from 'hono';
import { Bindings, Variables } from '../../bindings';
import { requireRole } from '../../_shared/middleware/rbac';
import { z } from 'zod';

const r = new Hono<{ Bindings: Bindings; Variables: Variables }>();

// GET Dashboard Stats for Manager/Admin
r.get('/stats', requireRole(['manager', 'admin']), async (c) => {
    const prisma = c.get('prisma');

    // 1. Shift Fulfillment (Next 7 days)
    // Aggregating visits by status for the upcoming week
    const start = new Date();
    const end = new Date();
    end.setDate(end.getDate() + 7);

    const visits = await prisma.visit.findMany({
        where: {
            requestedStartAt: { gte: start, lte: end }
        },
        select: { requestedStartAt: true, status: true }
    });

    const shiftData = [];
    for (let i = 0; i < 7; i++) {
        const d = new Date();
        d.setDate(d.getDate() + i);
        const dayStr = d.toLocaleDateString('en-US', { weekday: 'short' });

        const dayVisits = visits.filter(v =>
            new Date(v.requestedStartAt).getDate() === d.getDate()
        );

        const filled = dayVisits.filter(v => ['assigned', 'completed', 'in_progress'].includes(v.status || '')).length;
        const open = dayVisits.filter(v => ['requested', 'scheduled'].includes(v.status || '')).length;

        shiftData.push({ day: dayStr, filled, open });
    }

    // 2. Revenue Forecast (Current Month)
    // Actual: Paid/Unpaid invoices. Projected: Upcoming visits * rate.
    // Simplified Mock for "Projected" based on un-invoiced visits
    const revenueData = [
        { month: 'Jan', actual: 4000, projected: 2400 },
        { month: 'Feb', actual: 3000, projected: 1398 }, // Static historical data
        { month: 'Mar', actual: 5000, projected: 4000 },
    ];

    // 3. Incident Trends (Last 6 months)
    const incidentData = [
        { name: 'Jan', count: 4 },
        { name: 'Feb', count: 3 },
        { name: 'Mar', count: 2 },
        // Real aggregation would group by month
    ];

    return c.json({
        shiftFulfillment: shiftData,
        revenue: revenueData,
        incidents: incidentData,
        // Add other stats as needed
    });
});

export default r;
