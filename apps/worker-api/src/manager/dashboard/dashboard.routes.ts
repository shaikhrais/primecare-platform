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

    // 2. Revenue Forecast (Last 6 Months)
    const sixMonthsAgo = new Date();
    sixMonthsAgo.setMonth(sixMonthsAgo.getMonth() - 5);
    sixMonthsAgo.setDate(1); // Start of that month

    const invoices = await prisma.invoice.findMany({
        where: { createdAt: { gte: sixMonthsAgo } },
        select: { createdAt: true, total: true, status: true }
    });

    const revenueMap = new Map<string, { actual: number; projected: number }>();

    // Initialize map for last 6 months
    for (let i = 0; i < 6; i++) {
        const d = new Date();
        d.setMonth(d.getMonth() - i);
        const monthStr = d.toLocaleDateString('en-US', { month: 'short' });
        revenueMap.set(monthStr, { actual: 0, projected: 0 });
    }

    invoices.forEach(inv => {
        const monthStr = new Date(inv.createdAt).toLocaleDateString('en-US', { month: 'short' });
        if (revenueMap.has(monthStr)) {
            const amount = Number(inv.total) || 0;
            const entry = revenueMap.get(monthStr)!;
            if (inv.status === 'paid') {
                entry.actual += amount;
            } else {
                entry.projected += amount;
            }
        }
    });

    // Convert map to array and reverse to show chronological order
    const revenueData = Array.from(revenueMap.entries()).map(([month, data]) => ({
        month,
        actual: data.actual,
        projected: data.actual + data.projected // Projected includes actual + pending
    })).reverse();


    // 3. Incident Trends (Last 6 months)
    const incidents = await prisma.incident.findMany({
        where: { createdAt: { gte: sixMonthsAgo } },
        select: { createdAt: true }
    });

    const incidentMap = new Map<string, number>();
    for (let i = 0; i < 6; i++) {
        const d = new Date();
        d.setMonth(d.getMonth() - i);
        const monthStr = d.toLocaleDateString('en-US', { month: 'short' });
        incidentMap.set(monthStr, 0);
    }

    incidents.forEach(inc => {
        const monthStr = new Date(inc.createdAt).toLocaleDateString('en-US', { month: 'short' });
        if (incidentMap.has(monthStr)) {
            incidentMap.set(monthStr, incidentMap.get(monthStr)! + 1);
        }
    });

    const incidentData = Array.from(incidentMap.entries()).map(([name, count]) => ({
        name,
        count
    })).reverse();

    return c.json({
        shiftFulfillment: shiftData,
        revenue: revenueData,
        incidents: incidentData,
    });
});

export default r;
