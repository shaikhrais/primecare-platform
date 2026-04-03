/**
 * Cron Workforce Handlers
 * Features: Timesheet Auto-Approval, Missed/Late Shift Alerts,
 *           Performance Reviews, Dismissal Safeguard, No-Show Prediction,
 *           Targeted Surveys, Birthday Wishes
 */
import { logAudit } from "../../_shared/utils/audit";

export async function processTimesheetAutoApproval(prisma: any) {
  let autoApprovedCount = 0;
  const pendingTimesheets = await prisma.timesheet.findMany({
    where: { status: "PENDING" },
    include: { items: { include: { visit: { include: { checkEvents: true } } } } },
  });
  for (const sheet of pendingTimesheets) {
    let hasFlags = false;
    for (const item of sheet.items) {
      if (item.visit?.checkEvents) {
        for (const ev of item.visit.checkEvents) {
          if (ev.result === "flagged_distance" || ev.result === "manual_override") hasFlags = true;
        }
      }
    }
    if (!hasFlags && sheet.items.length > 0) {
      await prisma.timesheet.update({ where: { id: sheet.id }, data: { status: "APPROVED" as any, reviewedBy: "SYSTEM_CRON", reviewedAt: new Date() } });
      await logAudit(prisma, "SYSTEM", "AUTO_APPROVE_TIMESHEET", "TIMESHEET", sheet.id, { reason: "clean_evv_logs" });
      autoApprovedCount++;
    }
  }
  return { autoApprovedCount };
}

export async function processMissedShiftAlerts(prisma: any, env: any, reqUrl: string) {
  const fifteenMinutesAgo = new Date(Date.now() - 15 * 60 * 1000);
  let missedShiftCount = 0;
  const missedShifts = await prisma.visit.findMany({
    where: { status: "scheduled", requestedStartAt: { lt: fifteenMinutesAgo }, checkEvents: { none: { eventType: "check_in" } } },
    include: { client: true, assignedPsw: { include: { user: true } } },
  });
  for (const shift of missedShifts) {
    if (!shift.tenantId) continue;
    const coordinator = await prisma.user.findFirst({ where: { tenantId: shift.tenantId, role: "manager" } });
    if (!coordinator) continue;
    await prisma.communicationLog.create({
      data: { direction: "outbound", channel: "email", recipient: coordinator.email,
        subject: `[URGENT] Missed Shift Alert - ${shift.client?.fullName}`,
        bodyText: `PSW ${shift.assignedPsw?.user?.fullName} has not checked into their scheduled visit for Client ${shift.client?.fullName} which began 15+ minutes ago. Please re-staff immediately.`,
        status: "queued", tenantId: shift.tenantId },
    });
    await prisma.visit.update({ where: { id: shift.id }, data: { status: "missed" as any } });
    await logAudit(prisma, "SYSTEM", "MISSED_SHIFT_FLAGGED", "VISIT", shift.id, { delay: ">15m" });
    missedShiftCount++;
    if (env.REALTIME_SYNC) {
      try {
        const doId = env.REALTIME_SYNC.idFromName(shift.tenantId);
        const stub = env.REALTIME_SYNC.get(doId);
        const broadcastUrl = new URL(reqUrl); broadcastUrl.pathname = '/broadcast';
        await stub.fetch(new Request(broadcastUrl.toString(), {
          method: 'POST', body: JSON.stringify({ type: 'INCIDENT', severity: 'critical', title: 'Missed Shift Alert',
            message: `PSW ${shift.assignedPsw?.user?.fullName || 'Unassigned'} has missed their start time for ${shift.client?.fullName} by >15 minutes.`, visitId: shift.id })
        }));
      } catch (e) {}
    }
  }
  return { missedShiftCount };
}

export async function processLateShiftAlerts(prisma: any, env: any, reqUrl: string) {
  const fifteenMinutesAgo = new Date(Date.now() - 15 * 60 * 1000);
  const fiveMinutesAgo = new Date(Date.now() - 5 * 60 * 1000);
  const lateShifts = await prisma.visit.findMany({
    where: { status: "scheduled", requestedStartAt: { lt: fiveMinutesAgo, gte: fifteenMinutesAgo }, checkEvents: { none: { eventType: "check_in" } } },
    include: { client: true, assignedPsw: { include: { user: true } } },
  });
  for (const shift of lateShifts) {
    if (!shift.tenantId) continue;
    const alreadyNotified = await prisma.appNotification.findFirst({ where: { tenantId: shift.tenantId, title: 'Late Shift Warning', message: { contains: shift.id } } });
    if (alreadyNotified) continue;
    const coordinator = await prisma.user.findFirst({ where: { tenantId: shift.tenantId, role: "manager" } });
    if (!coordinator) continue;
    const warningTitle = 'Late Shift Warning';
    const warningMsg = `PSW ${shift.assignedPsw?.user?.fullName || 'Unassigned'} is over 5 minutes late checking in for ${shift.client?.fullName}. [ID:${shift.id}]`;
    await prisma.appNotification.create({ data: { userId: coordinator.id, tenantId: shift.tenantId, type: 'warning', title: warningTitle, message: warningMsg } });
    if (env.REALTIME_SYNC) {
      try {
        const doId = env.REALTIME_SYNC.idFromName(shift.tenantId);
        const stub = env.REALTIME_SYNC.get(doId);
        const broadcastUrl = new URL(reqUrl); broadcastUrl.pathname = '/broadcast';
        await stub.fetch(new Request(broadcastUrl.toString(), { method: 'POST', body: JSON.stringify({ type: 'INCIDENT', severity: 'warning', title: warningTitle, message: warningMsg, visitId: shift.id }) }));
      } catch (e) {}
    }
  }
}

export async function processPerformanceReviews(prisma: any) {
  let reviewDraftsCreated = 0;
  const oneYearAgo = new Date(); oneYearAgo.setFullYear(oneYearAgo.getFullYear() - 1);
  const oneYearAnniversaries = await prisma.providerProfile.findMany({ where: { createdAt: { lte: oneYearAgo } }, include: { user: true } });
  for (const psw of oneYearAnniversaries) {
    if (!psw.user?.tenantId) continue;
    const recentReview = await prisma.auditLog.findFirst({ where: { resourceType: "PSW_PROFILE", resourceId: psw.id, action: "ANNIVERSARY_REVIEW_CREATED", createdAt: { gte: new Date(Date.now() - 330 * 24 * 60 * 60 * 1000) } } });
    if (!recentReview) {
      const hrManager = await prisma.user.findFirst({ where: { tenantId: psw.user.tenantId, role: "manager" } });
      if (hrManager) {
        await prisma.appNotification.create({
          data: { userId: hrManager.id, tenantId: psw.user.tenantId, title: "Action Required: Annual Performance Review",
            message: `PSW ${psw.user.fullName} has reached their 1-year anniversary. A blank Performance Review draft has been generated for your completion.`, type: "info" },
        });
        await logAudit(prisma, "SYSTEM", "ANNIVERSARY_REVIEW_CREATED", "PSW_PROFILE", psw.id, { reason: "1-year-anniversary" });
        reviewDraftsCreated++;
      }
    }
  }
  return { reviewDraftsCreated };
}

export async function processDismissalSafeguard(prisma: any) {
  let dangerZoneFlags = 0;
  const activePsws = await prisma.providerProfile.findMany({ include: { user: true } });
  for (const psw of activePsws) {
    if (!psw.user?.tenantId) continue;
    const missedCount = await prisma.visit.count({ where: { assignedProviderId: psw.id, status: "missed" as any } });
    if (missedCount >= 3) {
      const alerted = await prisma.systemEvent.findFirst({ where: { operation: "DISMISSAL_SAFEGUARD_ALERT", entityId: psw.id } });
      if (!alerted) {
        const manager = await prisma.user.findFirst({ where: { tenantId: psw.user.tenantId, role: "manager" } });
        if (manager) {
          await prisma.appNotification.create({
            data: { userId: manager.id, tenantId: psw.user.tenantId, type: "critical",
              title: "DANGER ZONE: Dismissal Safeguard Triggered",
              message: `PSW ${psw.user.fullName} has accumulated ${missedCount} "No Show" incidents. Automated suspension protocols are recommended.` },
          });
          await prisma.systemEvent.create({
            data: { tenantId: psw.user.tenantId, operation: "DISMISSAL_SAFEGUARD_ALERT", modelName: "ProviderProfile", entityId: psw.id, payload: "3+ missed shifts" },
          });
          dangerZoneFlags++;
        }
      }
    }
  }
  return { dangerZoneFlags };
}

// Re-export from cron-workforce-extra.ts
export { processNoShowPrediction, processTargetedSurveys, processBirthdayWishes } from './cron-workforce-extra';
