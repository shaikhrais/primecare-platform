import { OpenAPIHono, createRoute, z } from "@hono/zod-openapi";
import { Bindings, Variables } from "../../bindings";
import { ROUTE_METADATA } from "../../_shared/constants/route_metadata";

// Clinical cron handlers
import { processSlaEscalations, processHandoverDigest, processSupervisionScheduling, processNlpSummaries, processSentimentAnalysis, processPeerMatching, processTelehealthSummaries } from "./cron-clinical";
// Workforce cron handlers
import { processTimesheetAutoApproval, processMissedShiftAlerts, processLateShiftAlerts, processPerformanceReviews, processDismissalSafeguard, processNoShowPrediction, processTargetedSurveys, processBirthdayWishes } from "./cron-workforce";
// System cron handlers
import { processComplianceSync, processInventoryWarnings, processWaitlistTriage, processIotSensorBridge, processHardwareFailure, processGlobalSlaMonitor, processApiKeyRotation } from "./cron-system";

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const runSystemSweepsRoute = createRoute({
  method: "post",
  path: "/incident-sla",
  tags: ['System', 'Cron'],
  description: "Internal cron to ping RNs about unacknowledged Fall incidents, handover digests, and supervision compliance.",
  responses: {
    200: { description: "SLA sweeps executed successfully." },
    500: { description: "Server Error" },
      '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
      '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
},
});

r.openapi(runSystemSweepsRoute, async (c) => {
  const prisma = c.get("prisma");
  if (!prisma) return c.json({ error: "Database disconnected" }, 500);

  // Fetch shared data
  const longNotes = await prisma.visitNote.findMany({
    where: { createdAt: { gt: new Date(Date.now() - 24 * 60 * 60 * 1000) } },
    include: { visit: { include: { psw: true } } },
  });

  // Execute all cron sweeps
  const sla = await processSlaEscalations(prisma);
  if (sla.processed === 0) {
    // Continue with other sweeps even if no SLA breaches
  }
  await processHandoverDigest(prisma);
  await processSupervisionScheduling(prisma);

  const timesheets = await processTimesheetAutoApproval(prisma);
  const missed = await processMissedShiftAlerts(prisma, c.env, c.req.url);
  await processLateShiftAlerts(prisma, c.env, c.req.url);
  const reviews = await processPerformanceReviews(prisma);
  const compliance = await processComplianceSync(prisma);
  const dismissal = await processDismissalSafeguard(prisma);
  const noShow = await processNoShowPrediction(prisma);
  const nlp = await processNlpSummaries(prisma, longNotes);
  const surveys = await processTargetedSurveys(prisma);
  const sentiment = await processSentimentAnalysis(prisma, longNotes);
  const peers = await processPeerMatching(prisma);
  const inventory = await processInventoryWarnings(prisma);
  const telehealth = await processTelehealthSummaries(prisma);
  const waitlist = await processWaitlistTriage(prisma);
  const iot = await processIotSensorBridge(prisma);
  const hardware = await processHardwareFailure(prisma);
  const birthdays = await processBirthdayWishes(prisma);
  const slaMonitor = await processGlobalSlaMonitor(prisma);
  const apiKeys = await processApiKeyRotation(prisma);

  const results = {
    processed: sla.processed,
    autoApprovedCount: timesheets.autoApprovedCount,
    missedShiftCount: missed.missedShiftCount,
    reviewDraftsCreated: reviews.reviewDraftsCreated,
    complianceMetricsProcessed: compliance.complianceMetricsProcessed,
    dangerZoneFlags: dismissal.dangerZoneFlags,
    surveysSent: surveys.surveysSent,
    sentimentFlags: sentiment.sentimentFlags,
    peerMatches: peers.peerMatches,
    inventoryWarnings: inventory.inventoryWarnings,
    telehealthSummaries: telehealth.telehealthSummaries,
    waitlistSorts: waitlist.waitlistSorts,
    welfareChecks: iot.welfareChecks,
    phantomExpirations: hardware.phantomExpirations,
    birthdayWishes: birthdays.birthdayWishes,
    revokedKeys: apiKeys.revokedKeys,
    slaAlerts: slaMonitor.slaAlerts,
    aiNoShowWarnings: noShow.aiNoShowWarnings,
    nlpSummaries: nlp.nlpSummaries,
    message: `System Sweeps successful.`,
  };

  console.log(`[Cron] System Sweeps: Processed ${results.processed} SLA breaches. Auto-approved ${results.autoApprovedCount} perfect timesheets. Flagged ${results.missedShiftCount} missed shifts. Generated ${results.reviewDraftsCreated} performance reviews. Synced ${results.complianceMetricsProcessed} compliance telemetry metrics. Flagged ${results.dangerZoneFlags} dismissal warnings. Sent ${results.surveysSent} targeted surveys. Flagged ${results.sentimentFlags} sentiment drifts. Generated ${results.peerMatches} AI mentors. Warned ${results.inventoryWarnings} stockouts. Summarized ${results.telehealthSummaries} telehealth sessions. Triaged ${results.waitlistSorts} waitlists. Dispatched ${results.welfareChecks} IoT welfare SMS. Cleaned ${results.phantomExpirations} phantom hardware tokens. Sent ${results.birthdayWishes} B-Day wishes. Revoked ${results.revokedKeys} stale API keys. Monitored ${results.slaAlerts} global SLA latencies.`);
  return c.json(results, 200);
});

export default r;
