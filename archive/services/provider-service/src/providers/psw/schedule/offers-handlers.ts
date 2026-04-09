/**
 * Offer Accept Handler Logic
 * Extracted from offers.ts — contains the complex accept logic with wellness, overtime, compliance, and gamification features
 */

export async function handleAcceptOffer(c: any) {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const { id: visitId } = c.req.valid('param');

    const profile = await prisma.providerProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const visit = await prisma.visit.findUnique({ where: { id: visitId }, include: { offers: { where: { providerId: profile.id } } } });
    if (!visit || visit.status !== 'posted') return c.json({ error: 'Offer no longer available' }, 400);

    // Feature 11: Wellness Thresholds -> block CrisisMode shifts
    if (visit.service?.name?.toLowerCase().includes('crisis') || visit.priority === 'CRITICAL') {
        const sevenDaysAgo = new Date(Date.now() - 7 * 24 * 60 * 60 * 1000);
        const recentPulses = await prisma.wellnessPulse.findMany({ where: { providerId: profile.id, createdAt: { gt: sevenDaysAgo }, score: { lt: 3 } } });
        if (recentPulses.length >= 2) {
            console.log(`[Worker] Feature 11 Fired: Blocked CrisisMode shift assignment for burnt-out PSW ${profile.id}`);
            return c.json({ error: 'Wellness Protocol Active. You have reported multiple low wellness scores recently. Please rest. Crisis shifts are temporarily blocked for 48 hours for your safety.' }, 403);
        }
    }

    // Feature 15: Overtime Sentinel Webhook
    const startOfWeek = new Date(); startOfWeek.setDate(startOfWeek.getDate() - startOfWeek.getDay());
    const weekVisits = await prisma.visit.findMany({ where: { assignedProviderId: profile.id, requestedStartAt: { gte: startOfWeek } } });
    const totalHoursBeforeThis = weekVisits.length;
    if (totalHoursBeforeThis >= 44 && profile.tenantId) {
        console.log(`[Worker] Feature 15 Fired: PSW ${profile.id} exceeded 44 hour limit. Triggering Overtime Sentinel Webhook Notification.`);
        const adminManager = await prisma.user.findFirst({ where: { tenantId: profile.tenantId, role: 'manager' } });
        if (adminManager) { await prisma.appNotification.create({ data: { userId: adminManager.id, tenantId: profile.tenantId, title: 'System Alert: Overtime Exceeded', message: `PSW ID ${profile.id} has accepted a shift pushing them past 44 total weekly hours. Standard Overtime parameters will apply to Payroll outputs.`, type: 'warning' } }); }
    }

    // Feature 17: Training Expired Blocker
    const expiredTrainings = await prisma.trainingAssignment.count({ where: { providerId: profile.id, status: 'assigned', dueDate: { lt: new Date() } } });
    if (expiredTrainings > 0) {
        console.log(`[Worker] Feature 17 Fired: Blocked shift assignment for Profile ${profile.id} due to ${expiredTrainings} expired training modules.`);
        return c.json({ error: `Mandatory Compliance Block: You have ${expiredTrainings} overdue training modules. Please complete them to resume accepting shifts.` }, 403);
    }

    await prisma.$transaction(async (tx: any) => {
        await tx.visit.update({ where: { id: visitId }, data: { status: 'scheduled', assignedProviderId: profile.id } });
        await tx.shiftAssignment.updateMany({ where: { visitId, providerId: profile.id }, data: { status: 'accepted' } });
        await tx.shiftAssignment.updateMany({ where: { visitId, providerId: { not: profile.id } }, data: { status: 'expired' } });

        // Feature 32: Gamified Picking
        const coinsAwarded = (visit.priority === 'CRITICAL' || visit.priority === 'HIGH') ? 100 : 50;
        let gamification = await tx.gamificationProfile.findUnique({ where: { userId } });
        if (!gamification) { gamification = await tx.gamificationProfile.create({ data: { userId, tenantId: profile.tenantId || 'system', careCoins: 0, lifetimePoints: 0, currentTier: 'Bronze' } }); }
        const updatedGamification = await tx.gamificationProfile.update({ where: { id: gamification.id }, data: { careCoins: { increment: coinsAwarded } } });

        // Feature 35: Tier Progression Webhook
        if (updatedGamification.careCoins >= 1000 && updatedGamification.currentTier === 'Bronze') {
            await tx.gamificationProfile.update({ where: { id: gamification.id }, data: { currentTier: 'Silver', lifetimePoints: { increment: 1 } } });
            let endpoint = await tx.webhookEndpoint.findFirst({ where: { tenantId: profile.tenantId || 'system', url: 'https://api.printmail.example.com/certificates' } });
            if (!endpoint) { endpoint = await tx.webhookEndpoint.create({ data: { tenantId: profile.tenantId || 'system', url: 'https://api.printmail.example.com/certificates', events: 'gamification.tier_promotion', secret: 'auto-generated', status: 'active' } }); }
            await tx.webhookDelivery.create({ data: { endpointId: endpoint.id, event: 'gamification.tier_promotion', payload: JSON.stringify({ providerId: profile.id, award: 'Bronze to Silver Promotion', instruction: 'Print and mail physical certificate' }), retryCount: 0 } });
            console.log(`[Worker] Feature 35 Fired: Promoted PSW ${profile.id} to Silver. WebhookDelivery queued for physical certificate printing.`);
        }

        await tx.auditLog.create({ data: { tenantId: profile.tenantId || 'system', actorUserId: userId, action: 'GAMIFIED_PICKING_REWARD', resourceType: 'GAMIFICATION', resourceId: gamification.id, metadata: JSON.stringify({ visitId, priority: visit.priority, coinsAwarded }) } });
        console.log(`[Worker] Feature 32 Fired: Awarded ${coinsAwarded} CareCoins to PSW ${profile.id} for accepting ${visit.priority || 'ROUTINE'} shift ${visit.id}.`);
    });

    return c.json({ success: true }, 200);
}
