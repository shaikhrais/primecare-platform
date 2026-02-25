import { PrismaClient } from '../../../../../generated/client/edge';

export const getFulfillmentStats = async (prisma: any) => {
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

        const dayVisits = visits.filter((v: any) =>
            new Date(v.requestedStartAt).getDate() === d.getDate()
        );

        const filled = dayVisits.filter((v: any) => ['assigned', 'completed', 'in_progress'].includes(v.status || '')).length;
        const open = dayVisits.filter((v: any) => ['requested', 'scheduled'].includes(v.status || '')).length;

        shiftData.push({ day: dayStr, filled, open });
    }
    return shiftData;
};

export const getRevenueStats = async (prisma: any) => {
    const sixMonthsAgo = new Date();
    sixMonthsAgo.setMonth(sixMonthsAgo.getMonth() - 5);
    sixMonthsAgo.setDate(1);

    const invoices = await prisma.invoice.findMany({
        where: { createdAt: { gte: sixMonthsAgo } },
        select: { createdAt: true, total: true, status: true }
    });

    const revenueMap = new Map<string, { actual: number; projected: number }>();

    for (let i = 0; i < 6; i++) {
        const d = new Date();
        d.setMonth(d.getMonth() - i);
        const monthStr = d.toLocaleDateString('en-US', { month: 'short' });
        revenueMap.set(monthStr, { actual: 0, projected: 0 });
    }

    invoices.forEach((inv: any) => {
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

    return Array.from(revenueMap.entries()).map(([month, data]) => ({
        month,
        actual: data.actual,
        projected: data.actual + data.projected
    })).reverse();
};

