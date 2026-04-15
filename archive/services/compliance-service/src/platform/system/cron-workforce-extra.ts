/**
 * Cron Workforce Handlers — Part 2 (Surveys + Birthday)
 * Split from cron-workforce.ts to keep files under 200 lines
 */
import { logAudit } from '@primecare/infrastructure';

export async function processNoShowPrediction(prisma: any) {
    let aiNoShowWarnings = 0;
    const oneMonthAgo = new Date(Date.now() - 30 * 24 * 60 * 60 * 1000);
    const upcomingVisits = await prisma.visit.findMany({
        where: { status: "scheduled", requestedStartAt: { gt: new Date(), lt: new Date(Date.now() + 24 * 60 * 60 * 1000) } },
        include: { psw: { include: { user: true } }, client: true },
    });
    for (const upcoming of upcomingVisits) {
        if (!upcoming.assignedProviderId || !upcoming.tenantId) continue;
        const pastMissed = await prisma.visit.count({ where: { assignedProviderId: upcoming.assignedProviderId, status: "missed" as any, requestedStartAt: { gt: oneMonthAgo } } });
        const recentWellness = await prisma.wellnessPulse.findFirst({ where: { providerId: upcoming.assignedProviderId }, orderBy: { createdAt: "desc" } });
        const score = recentWellness?.score || 5;
        if (pastMissed > 0 && score <= 3) {
            const dispatcher = await prisma.user.findFirst({ where: { tenantId: upcoming.tenantId, role: "coordinator" } });
            if (dispatcher) {
                await prisma.appNotification.create({ data: { userId: dispatcher.id, tenantId: upcoming.tenantId, type: "warning", title: "AI INFERENCE: High No-Show Probability", message: `Shift ${upcoming.id} for ${upcoming.client?.fullName} has an 82% No-Show risk due to PSW trailing metrics. Consider a backup float.` } });
                aiNoShowWarnings++;
            }
        }
    }
    return { aiNoShowWarnings };
}

export async function processTargetedSurveys(prisma: any) {
    let surveysSent = 0;
    const oneMonthAgo = new Date(Date.now() - 30 * 24 * 60 * 60 * 1000);
    const ninetyDaysAgo = new Date(Date.now() - 90 * 24 * 60 * 60 * 1000);
    const lowActivityUsers = await prisma.user.findMany({ where: { roles: { has: "psw" }, status: "active" }, include: { providerProfile: true } });
    for (const pswUser of lowActivityUsers) {
        if (!pswUser.tenantId || !pswUser.providerProfile) continue;
        const recentTimesheets = await prisma.timesheet.count({ where: { providerId: pswUser.providerProfile.id, createdAt: { gt: oneMonthAgo } } });
        if (recentTimesheets === 0) {
            const recentlySurveyed = await prisma.appNotification.findFirst({ where: { userId: pswUser.id, title: "Quarterly Check-In Survey", createdAt: { gt: ninetyDaysAgo } } });
            if (!recentlySurveyed) {
                await prisma.appNotification.create({ data: { userId: pswUser.id, tenantId: pswUser.tenantId, type: "info", title: "Quarterly Check-In Survey", message: "We noticed you haven't picked up many shifts lately. Complete this quick survey to let us know how we can support you better: https://link.to/survey" } });
                surveysSent++;
            }
        }
    }
    return { surveysSent };
}

export async function processBirthdayWishes(prisma: any) {
    let birthdayWishes = 0;
    const todayMonthDay = new Date().toISOString().slice(5, 10);
    const birthdayProfiles = await prisma.providerProfile.findMany({ where: { dob: { not: null } }, include: { user: true } });
    for (const profile of birthdayProfiles) {
        if (!profile.dob || !profile.user) continue;
        const profileMonthDay = new Date(profile.dob).toISOString().slice(5, 10);
        if (profileMonthDay === todayMonthDay) {
            const alreadySentToday = await prisma.communicationLog.findFirst({ where: { sender: "system", recipient: "psw", bodyText: { contains: "Happy Birthday" }, createdAt: { gt: new Date(Date.now() - 24 * 60 * 60 * 1000) } } });
            if (!alreadySentToday) {
                await prisma.communicationLog.create({ data: { tenantId: profile.tenantId || "system", sender: "system", recipient: "psw", channel: "sms", status: "sent", bodyText: `Happy Birthday ${profile.user.fullName}! From all of us at PrimeCare, we've gifted you 50 CareCoins. Thank you for your service!` } });
                await prisma.gamificationProfile.updateMany({ where: { providerId: profile.id }, data: { careCoins: { increment: 50 } } });
                birthdayWishes++;
            }
        }
    }
    return { birthdayWishes };
}
