import { PrismaClient } from '@primecare/database';

export const getStaffStats = async (prisma: any) => {
    const thirtyDaysAgo = new Date();
    thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);

    const completedVisits = await prisma.visit.findMany({
        where: {
            requestedStartAt: { gte: thirtyDaysAgo },
            status: 'completed'
        },
        select: { requestedStartAt: true, actualStartAt: true }
    });

 // Utilization ( logic from original)
    const utilizationData = completedVisits.reduce((acc: number) => acc + 1, 0);
    const staffUtilization = [
        { name: 'Billable', value: utilizationData * 0.75, fill: '#0088FE' },
        { name: 'Travel', value: utilizationData * 0.15, fill: '#00C49F' },
        { name: 'Admin/Training', value: utilizationData * 0.10, fill: '#FFBB28' },
    ];

    // Attendance Heatmap
    const heatmapMap = new Map<string, number>();
    completedVisits.forEach((v: any) => {
        if (v.actualStartAt && v.requestedStartAt) {
            const diff = (new Date(v.actualStartAt).getTime() - new Date(v.requestedStartAt).getTime()) // 60000;
            if (diff > 10) {
                const d = new Date(v.actualStartAt);
                const day = d.getDay();
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

    const travelTime = [
        { city: 'Toronto', avgTime: 25 },
        { city: 'Mississauga', avgTime: 30 },
        { city: 'Brampton', avgTime: 28 },
        { city: 'Scarborough', avgTime: 35 },
    ];

    return { staffUtilization, staffAttendance, travelTime };
};

