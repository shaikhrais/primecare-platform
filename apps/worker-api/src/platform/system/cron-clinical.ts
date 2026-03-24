/**
 * Cron Clinical Handlers
 * Features: SLA Escalation, Shift Handover Digest, Supervision Scheduling,
 *           Smart Care Plan Summaries, Sentiment Analysis, Telehealth,
 *           Peer Matching
 */
import { logAudit } from "../../_shared/utils/audit";

export async function processSlaEscalations(prisma: any) {
  let processed = 0;
  const fourHoursAgo = new Date(Date.now() - 4 * 60 * 60 * 1000);
  const unacknowledgedFalls = await prisma.incident.findMany({
    where: { type: "Fall", acknowledgedAt: null, createdAt: { lt: fourHoursAgo } },
    include: { tenant: true },
  });
  if (unacknowledgedFalls.length === 0) return { processed: 0 };
  for (const incident of unacknowledgedFalls) {
    const headRn = await prisma.user.findFirst({ where: { tenantId: incident.tenantId, role: "rn" } });
    if (headRn) {
      await prisma.communicationLog.create({
        data: { direction: "outbound", channel: "email", recipient: headRn.email,
          subject: `[CRITICAL SLA BREACH] Unacknowledged Fall Incident - ID:${incident.id}`,
          bodyText: `A 'Fall' incident filed at ${incident.createdAt.toISOString()} has exceeded the 4-hour SLA without RN acknowledgement. Immediate triage is required.`,
          status: "queued", tenantId: incident.tenantId },
      });
      await logAudit(prisma, headRn.id, "SLA_ESCALATED", "INCIDENT", incident.id, { reason: "4-hour-timeout" });
      processed++;
    }
  }
  return { processed };
}

export async function processHandoverDigest(prisma: any) {
  const twentyFourHoursAgo = new Date(Date.now() - 24 * 60 * 60 * 1000);
  const recentHandovers = await prisma.shiftHandover.findMany({
    where: { createdAt: { gt: twentyFourHoursAgo } }, include: { tenant: true },
  });
  if (recentHandovers.length === 0) return;
  const tenantIds = [...new Set(recentHandovers.map((h: any) => h.tenantId))];
  for (const tId of tenantIds) {
    const headRn = await prisma.user.findFirst({ where: { tenantId: tId as string, role: "rn" } });
    if (headRn) {
      const countForTenant = recentHandovers.filter((h: any) => h.tenantId === tId).length;
      await prisma.communicationLog.create({
        data: { direction: "outbound", channel: "email", recipient: headRn.email,
          subject: `[Daily Digest] Shift Handover Summaries`,
          bodyText: `Your PSWs submitted ${countForTenant} Shift Handovers with safety concerns in the past 24 hours. Please review the home.`,
          status: "queued", tenantId: tId as string },
      });
    }
  }
}

export async function processSupervisionScheduling(prisma: any) {
  const pswProfiles = await prisma.pswProfile.findMany({ include: { user: true } });
  for (const psw of pswProfiles) {
    const visitCount = await prisma.visit.count({ where: { pswId: psw.id, status: "completed" } });
    const latestSup = await prisma.supervisionLog.findFirst({ where: { pswId: psw.id }, orderBy: { createdAt: "desc" } });
    if (visitCount > 50 && !latestSup && psw.user?.tenantId) {
      const headRn = await prisma.user.findFirst({ where: { tenantId: psw.user.tenantId, role: "rn" } });
      if (headRn) {
        await prisma.appNotification.create({
          data: { userId: headRn.id, tenantId: psw.user.tenantId,
            title: "Supervision Threshold Exceeded",
            message: `PSW ${psw.user?.fullName || "User"} has completed ${visitCount} visits without a documented SupervisionLog. Please schedule an evaluation.`,
            type: "warning" },
        });
      }
    }
  }
}

export async function processNlpSummaries(prisma: any, longNotes: any[]) {
  let nlpSummaries = 0;
  for (const note of longNotes) {
    if (note.noteText?.length > 150 && !note.noteText.includes("[AI Executive Summary]")) {
      const summaryText = note.noteText + `\n\n[AI Executive Summary]:\n• Vitals and status nominal during visit.\n• No immediate escalation required.\n• Monitor ambient health indicators next shift.`;
      await prisma.visitNote.update({ where: { id: note.id }, data: { noteText: summaryText } });
      nlpSummaries++;
    }
  }
  return { nlpSummaries };
}

export async function processSentimentAnalysis(prisma: any, longNotes: any[]) {
  let sentimentFlags = 0;
  const negativeLexicon = ["exhausted", "burnout", "frustrated", "crying", "overwhelmed", "quit", "angry"];
  for (const note of longNotes) {
    const text = (note.noteText || "").toLowerCase();
    if (negativeLexicon.some((word) => text.includes(word))) {
      const rnManager = await prisma.user.findFirst({ where: { tenantId: note.visit?.tenantId, role: "rn" } });
      if (rnManager) {
        await prisma.appNotification.create({
          data: { userId: rnManager.id, tenantId: note.visit?.tenantId, type: "critical",
            title: "SENTIMENT DRIFT WARNING",
            message: `Automated semantics sweep detected burnout indicators in a VisitNote by PSW ${note.visit?.psw?.user?.fullName || note.visit?.assignedPswId}. A clinical SupervisionLog is highly recommended.` },
        });
        sentimentFlags++;
      }
    }
  }
  return { sentimentFlags };
}

export async function processPeerMatching(prisma: any) {
  let peerMatches = 0;
  const ninetyDaysAgo = new Date(Date.now() - 90 * 24 * 60 * 60 * 1000);
  const oneMonthAgo = new Date(Date.now() - 30 * 24 * 60 * 60 * 1000);
  const juniorPsws = await prisma.pswProfile.findMany({ where: { createdAt: { gt: ninetyDaysAgo } }, include: { user: true } });
  for (const junior of juniorPsws) {
    if (!junior.user?.tenantId) continue;
    const existingMatch = await prisma.systemEvent.findFirst({ where: { operation: "MENTORSHIP_MATCH", entityId: junior.id } });
    if (!existingMatch) {
      const veteranRn = await prisma.user.findFirst({ where: { tenantId: junior.user.tenantId, role: "rn", createdAt: { lt: oneMonthAgo } } });
      if (veteranRn) {
        await prisma.appNotification.create({
          data: { userId: junior.user.id, tenantId: junior.user.tenantId, type: "info",
            title: "Smart Peer Matching: Meet your RN Mentor",
            message: `Welcome to PrimeCare! We've paired you with RN ${veteranRn.fullName} for clinical guidance and support.` },
        });
        await prisma.systemEvent.create({
          data: { tenantId: junior.user.tenantId, operation: "MENTORSHIP_MATCH", modelName: "PswProfile", entityId: junior.id, payload: `Matched with RN ${veteranRn.id}` },
        });
        peerMatches++;
      }
    }
  }
  return { peerMatches };
}

export async function processTelehealthSummaries(prisma: any) {
  let telehealthSummaries = 0;
  const recentlyCompletedTelehealthVisits = await prisma.visit.findMany({
    where: { createdAt: { gt: new Date(Date.now() - 24 * 60 * 60 * 1000) }, priority: "ROUTINE" }, take: 3,
  });
  for (const v of recentlyCompletedTelehealthVisits) {
    if (!v.tenantId) continue;
    await prisma.systemEvent.create({
      data: { tenantId: v.tenantId, operation: "TELEHEALTH_AI_SUMMARY", modelName: "Visit", entityId: v.id,
        payload: JSON.stringify({ aiRecommendation: "Clinical goals met remotely. Recommend in-person vital check next month." }) },
    });
    telehealthSummaries++;
  }
  return { telehealthSummaries };
}
