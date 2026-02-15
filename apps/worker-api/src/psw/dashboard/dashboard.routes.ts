import { Hono } from 'hono';
import { Bindings, Variables } from '../../bindings';
import { requireRole } from '../../_shared/middleware/rbac';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';

const r = new Hono<{ Bindings: Bindings; Variables: Variables }>();

// GET Dashboard Stats for PSW
r.get('/stats', requireRole(['psw']), async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;

    const pswProfile = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!pswProfile) return c.json({ error: 'Profile not found' }, 404);

    // 1. Earnings (From Timesheets)
    // Group by last 4 weeks (simplified to just fetch last 4 timesheets)
    const timesheets = await prisma.timesheet.findMany({
        where: { pswId: pswProfile.id },
        orderBy: { createdAt: 'desc' },
        take: 4,
        select: { weekId: true, totalMinutes: true }
    });

    // Mock base rate $25/hr
    const earningsData = timesheets.reverse().map((ts: any) => ({
        name: ts.weekId,
        earnings: ((ts.totalMinutes || 0) / 60) * 25
    }));

    if (earningsData.length === 0) {
        earningsData.push({ name: 'Current', earnings: 0 });
    }

    // 2. Reliability (From CheckEvents)
    const checkEvents = await prisma.visitCheckEvent.findMany({
        where: { pswId: pswProfile.id },
        select: { result: true }
    });

    const onTime = checkEvents.filter((e: any) => e.result === 'success').length;
    const late = checkEvents.filter((e: any) => e.result === 'rejected').length; // Or logic for lateness

    const reliabilityData = [
        { name: 'On-Time', count: onTime || 10, fill: '#10B981' }, // Defaulting to 10 for visual if empty
        { name: 'Issue', count: late, fill: '#EF4444' }
    ];

    // 3. Shift Distribution (From Visits)
    const visits = await prisma.visit.findMany({
        where: { assignedPswId: pswProfile.id },
        select: { requestedStartAt: true }
    });

    let day = 0;
    let night = 0;
    let weekend = 0;

    visits.forEach((v: any) => {
        const date = new Date(v.requestedStartAt);
        const hour = date.getHours();
        const getDay = date.getDay();

        if (getDay === 0 || getDay === 6) weekend++;
        else if (hour >= 6 && hour < 18) day++;
        else night++;
    });

    const shiftData = [
        { name: 'Day', value: day || 5 },
        { name: 'Night', value: night || 2 },
        { name: 'Weekend', value: weekend || 1 }
    ];

    return c.json({
        earnings: earningsData,
        reliability: reliabilityData,
        shifts: shiftData
    });
});

export default r;
