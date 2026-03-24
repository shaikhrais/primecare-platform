/**
 * PSW Home Handlers
 * Extracted from psw home.routes.ts
 */

export async function handleGetHomeStats(c: any) {
    const prisma = c.get('prisma');
    try {
        const userId = c.get('jwtPayload').sub;
        const pswProfile = await prisma.pswProfile.findUnique({ where: { userId } });
        if (!pswProfile) return c.json({ error: 'Profile not found' }, 404);
        const timesheets = await prisma.timesheet.findMany({ where: { pswId: pswProfile.id }, orderBy: { createdAt: 'desc' }, take: 4, select: { weekId: true, totalMinutes: true } });
        const earningsData = timesheets.reverse().map((ts: any) => ({ name: ts.weekId, earnings: ((ts.totalMinutes || 0) / 60) * 25 }));
        if (earningsData.length === 0) earningsData.push({ name: 'Current', earnings: 0 });
        const checkEvents = await prisma.visitCheckEvent.findMany({ where: { pswId: pswProfile.id }, select: { result: true } });
        const onTime = checkEvents.filter((e: any) => e.result === 'success').length;
        const late = checkEvents.filter((e: any) => e.result === 'rejected').length;
        const reliabilityData = [{ metric: 'On-Time', score: onTime || 10, color: '#10B981' }, { metric: 'Issue', score: late, color: '#EF4444' }];
        const visits = await prisma.visit.findMany({ where: { assignedPswId: pswProfile.id }, select: { requestedStartAt: true } });
        let day = 0, night = 0, weekend = 0;
        visits.forEach((v: any) => { const date = new Date(v.requestedStartAt); const hour = date.getHours(); const getDay = date.getDay(); if (getDay === 0 || getDay === 6) weekend++; else if (hour >= 6 && hour < 18) day++; else night++; });
        const shiftData = [{ type: 'Day', count: day || 5 }, { type: 'Night', count: night || 2 }, { type: 'Weekend', count: weekend || 1 }];
        const hoursLogged = (timesheets.reduce((acc: number, cur: any) => acc + (cur.totalMinutes || 0), 0) / 60) || 0;
        const currentStreak = onTime > 5 ? Math.floor(onTime / 2) : onTime;
        return c.json({ earnings: earningsData, reliability: reliabilityData, shifts: shiftData, attendance: [], hoursLogged: Number(hoursLogged.toFixed(1)), currentStreak }, 200);
    } catch (err: any) { console.error("DASHBOARD STATS CRASHED:", err); throw err; }
}

export async function handleRedeemStore(c: any) {
    const prisma = c.get('prisma'); const { itemId, cost } = c.req.valid('json'); const userId = c.get('jwtPayload').sub;
    const pswProfile = await prisma.pswProfile.findUnique({ where: { userId } });
    const gamification = await prisma.gamificationProfile.findUnique({ where: { userId } });
    if (!gamification || gamification.careCoins < cost) return c.json({ error: 'Insufficient CareCoins' }, 400);
    await prisma.$transaction(async (tx: any) => {
        await tx.gamificationProfile.update({ where: { id: gamification.id }, data: { careCoins: { decrement: cost } } });
        if (itemId === 'gas-card-50') { await tx.payout.create({ data: { pswId: pswProfile!.id, tenantId: pswProfile!.tenantId, amount: 50.0, status: 'pending' } }); }
        await tx.auditLog.create({ data: { tenantId: pswProfile!.tenantId, actorUserId: userId, action: 'CARECOIN_REDEEMED', resourceType: 'GAMIFICATION', resourceId: gamification.id, metadata: JSON.stringify({ item: itemId, cost }) } });
    });
    return c.json({ success: true, newBalance: gamification.careCoins - cost }, 200);
}
