import { PrismaClient } from '../../../../../../generated/client/edge';

export const getIncidentStats = async (prisma: any) => {
    const sixMonthsAgo = new Date();
    sixMonthsAgo.setMonth(sixMonthsAgo.getMonth() - 6);
    const incidents = await prisma.incident.findMany({
        where: { reportedAt: { gte: sixMonthsAgo } },
        select: { reportedAt: true, severity: true }
    });

    const incidentMap = new Map<string, { total: number, critical: number }>();
    incidents.forEach((inc: any) => {
        const month = new Date(inc.reportedAt).toLocaleString('default', { month: 'short' });
        if (!incidentMap.has(month)) incidentMap.set(month, { total: 0, critical: 0 });
        const entry = incidentMap.get(month)!;
        entry.total++;
        if (inc.severity === 'critical' || inc.severity === 'high') entry.critical++;
    });

    return Array.from(incidentMap.entries()).map(([name, data]) => ({ name, ...data }));
};

export const getVolumeAndServiceStats = async (prisma: any) => {
    const thirtyDaysAgo = new Date();
    thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);

    const visits = await prisma.visit.findMany({
        where: {
            requestedStartAt: { gte: thirtyDaysAgo },
            status: 'completed'
        },
        include: { service: true }
    });

    const volumeMap = new Map<string, number>();
    visits.forEach((v: any) => {
        const date = new Date(v.requestedStartAt).toLocaleDateString();
        volumeMap.set(date, (volumeMap.get(date) || 0) + 1);
    });
    const visitVolume = Array.from(volumeMap.entries()).map(([date, count]) => ({ date, count }));

    const serviceMap = new Map<string, number>();
    visits.forEach((v: any) => {
        if (v.service?.name) {
            serviceMap.set(v.service.name, (serviceMap.get(v.service.name) || 0) + 1);
        }
    });
    const servicePopularity = Array.from(serviceMap.entries()).map(([name, value]) => ({ name, value }));

    return { visitVolume, servicePopularity };
};

