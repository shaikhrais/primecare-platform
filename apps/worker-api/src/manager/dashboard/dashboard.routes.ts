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
        incidents: incidentData, // existing
        visitVolume: shiftData.map(d => ({ name: d.day, visits: d.filled + d.open })),

        // 4. Service Popularity (Last 30 Days) & Staff Utilization
        ...(await (async () => {
            const thirtyDaysAgo = new Date();
            thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);

            const recentVisits = await prisma.visit.findMany({
                where: { requestedStartAt: { gte: thirtyDaysAgo } },
                include: { service: true }
            });

            // Service Popularity
            const serviceMap = new Map<string, number>();
            const cityTravelMap = new Map<string, { travel: number, service: number }>();

            recentVisits.forEach(v => {
                const sName = v.service?.name || 'Unknown';
                serviceMap.set(sName, (serviceMap.get(sName) || 0) + 1);

                const city = v.serviceCity || 'Unknown';
                if (!cityTravelMap.has(city)) cityTravelMap.set(city, { travel: 0, service: 0 });
                const entry = cityTravelMap.get(city)!;
                entry.service += (v.durationMinutes || 0);
                entry.travel += (v.durationMinutes || 0) * 0.2; // Mock 20% travel
            });

            const servicePopularity = Array.from(serviceMap.entries()).map(([name, value]) => ({ name, value }));

            // Staff Utilization
            const billableHours = recentVisits.reduce((acc, v) => acc + (v.durationMinutes || 0), 0) / 60;
            const staffUtilization = [
                { name: 'Billable Hours', value: Math.round(billableHours) },
                { name: 'Travel Time', value: Math.round(billableHours * 0.2) },
                { name: 'Admin/Training', value: Math.round(billableHours * 0.1) },
            ];

            // Travel Time
            const travelTime = Array.from(cityTravelMap.entries()).slice(0, 5).map(([zone, data]) => ({
                zone,
                travel: Math.round(data.travel),
                service: data.service
            }));

            return { servicePopularity, staffUtilization, travelTime };
        })()),

        // 9. Staff Attendance Heatmap (Real - Lateness Analysis)
        ...(await (async () => {
            const thirtyDaysAgo = new Date();
            thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);
            const lateVisits = await prisma.visit.findMany({
                where: {
                    requestedStartAt: { gte: thirtyDaysAgo },
                    status: 'completed'
                },
                select: { requestedStartAt: true, actualStartAt: true }
            });

            const heatmapMap = new Map<string, number>();

            lateVisits.forEach((v: any) => {
                if (v.actualStartAt && v.requestedStartAt) {
                    const diff = (new Date(v.actualStartAt).getTime() - new Date(v.requestedStartAt).getTime()) / 60000;
                    if (diff > 10) { // Considered late if > 10 mins
                        const d = new Date(v.actualStartAt);
                        const day = d.getDay(); // 0-6
                        const hour = d.getHours();
                        const key = `${day}-${hour}`;
                        heatmapMap.set(key, (heatmapMap.get(key) || 0) + 1);
                    }
                }
            });

            const staffAttendance = Array.from(heatmapMap.entries()).map(([key, count]) => {
                const [day, hour] = key.split('-').map(Number);
                return { day, hour, count };
            });

            return { staffAttendance };
        })()),

        // Mocked/Static for now due to schema limitations
        carePlanAdherence: [
            { name: 'Adherent', count: 85, fill: '#10B981' },
            { name: 'Non-Adherent', count: 15, fill: '#EF4444' },
        ],
        clientSatisfaction: [
            { subject: 'Reliability', A: 120, fullMark: 150 },
            { subject: 'Communication', A: 98, fullMark: 150 },
            { subject: 'Care Quality', A: 140, fullMark: 150 },
            { subject: 'Responsiveness', A: 110, fullMark: 150 },
            { subject: 'Safety', A: 135, fullMark: 150 },
        ],
        overtimeRisk: [
            { name: 'Low Risk', value: 80 },
            { name: 'Medium Risk', value: 15 },
            { name: 'High Risk', value: 5 },
        ],
        resourceAvailability: [
            { time: '08:00', available: 12, total: 15 },
            { time: '12:00', available: 8, total: 15 },
            { time: '16:00', available: 10, total: 15 },
        ]
    });
});

export default r;
