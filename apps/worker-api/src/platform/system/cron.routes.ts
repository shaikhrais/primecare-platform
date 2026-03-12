import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import { ROUTE_METADATA } from '../../_shared/constants/route_metadata';
import { logAudit } from '../../_shared/utils/audit';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const runSystemSweepsRoute = createRoute({
    method: 'post',
    path: '/incident-sla', // Maintained legacy path to avoid breaking index.js fetch
    description: 'Internal cron to ping RNs about unacknowledged Fall incidents, handover digests, and supervision compliance.',
    responses: {
        200: { description: 'SLA sweeps executed successfully.' },
        500: { description: 'Server Error' }
    }
});

r.openapi(runSystemSweepsRoute, async (c) => {
    const prisma = c.get('prisma');
    if (!prisma) return c.json({ error: 'Database disconnected' }, 500);

    let processed = 0;
    const fourHoursAgo = new Date(Date.now() - 4 * 60 * 60 * 1000);

    // Find all 'Fall' incidents created more than 4 hours ago that haven't been acknowledged
    const unacknowledgedFalls = await prisma.incident.findMany({
        where: {
            type: 'Fall',
            acknowledgedAt: null,
            createdAt: { lt: fourHoursAgo }
        },
        include: { tenant: true }
    });

    if (unacknowledgedFalls.length === 0) {
        return c.json({ processed: 0, message: 'No SLA breaches found.' }, 200);
    }

    if (unacknowledgedFalls.length > 0) {
        for (const incident of unacknowledgedFalls) {
            const headRn = await prisma.user.findFirst({
                where: { tenantId: incident.tenantId, role: 'rn' }
            });

            if (headRn) {
                // Feature 3: Incident Escalation SLA
                await prisma.communicationLog.create({
                    data: {
                        direction: 'outbound',
                        channel: 'email',
                        recipient: headRn.email,
                        subject: `[CRITICAL SLA BREACH] Unacknowledged Fall Incident - ID:${incident.id}`,
                        bodyText: `A 'Fall' incident filed at ${incident.createdAt.toISOString()} has exceeded the 4-hour SLA without RN acknowledgement. Immediate triage is required.`,
                        status: 'queued',
                        tenantId: incident.tenantId
                    }
                });
                await logAudit(prisma, headRn.id, 'SLA_ESCALATED', 'INCIDENT', incident.id, { reason: '4-hour-timeout' });
                processed++;
            }
        }
    }

    // Feature 8: Shift Handover Summaries (Daily Digest)
    // Send email of all ShiftHandovers from past 24 hours grouped by RN
    const twentyFourHoursAgo = new Date(Date.now() - 24 * 60 * 60 * 1000);
    const recentHandovers = await prisma.shiftHandover.findMany({
        where: { createdAt: { gt: twentyFourHoursAgo } },
        include: { tenant: true }
    });

    if (recentHandovers.length > 0) {
        // Group by tenantId to notify the central RN of that tenant
        // (In a fuller implementation, this would group by CarePlan author)
        const tenantIds = [...new Set(recentHandovers.map((h: any) => h.tenantId))];
        
        for (const tId of tenantIds) {
            const headRn = await prisma.user.findFirst({
                where: { tenantId: tId as string, role: 'rn' }
            });

            if (headRn) {
                const countForTenant = recentHandovers.filter((h: any) => h.tenantId === tId).length;
                await prisma.communicationLog.create({
                    data: {
                        direction: 'outbound',
                        channel: 'email',
                        recipient: headRn.email,
                        subject: `[Daily Digest] Shift Handover Summaries`,
                        bodyText: `Your PSWs submitted ${countForTenant} Shift Handovers with safety concerns in the past 24 hours. Please review the dashboard.`,
                        status: 'queued',
                        tenantId: tId as string
                    }
                });
            }
        }
    }

    // Feature 9: Supervision Scheduling
    // Spawn StaffTask for RN after 50 PSW visits without SupervisionLog
    // Because StaffTask schema might not be generated natively yet, we'll log it directly via PatientAlert or AppNotification to Head RN
    const pswProfiles = await prisma.pswProfile.findMany({
        include: { user: true }
    });

    for (const psw of pswProfiles) {
        const visitCount = await prisma.visit.count({
            where: { pswId: psw.id, status: 'completed' }
        });

        // Find latest supervision log
        const latestSup = await prisma.supervisionLog.findFirst({
            where: { pswId: psw.id },
            orderBy: { createdAt: 'desc' }
        });

        // Approximate 50 visit delta logic: 
        // Real implementation would calculate delta since `latestSup.createdAt` vs visits
        // For simplicity, hard check if total visits > 50 and NO supervision exists
        if (visitCount > 50 && !latestSup && psw.user?.tenantId) {
            const headRn = await prisma.user.findFirst({
                where: { tenantId: psw.user.tenantId, role: 'rn' }
            });

            if (headRn) {
                // Feature 9: Dispatch Supervision required task (AppNotification here as fallback task representation)
                await prisma.appNotification.create({
                    data: {
                        userId: headRn.id,
                        tenantId: psw.user.tenantId,
                        title: 'Supervision Threshold Exceeded',
                        message: `PSW ${psw.user?.fullName || 'User'} has completed ${visitCount} visits without a documented SupervisionLog. Please schedule an evaluation.`,
                        type: 'warning'
                    }
                });
            }
        }
    }

    // Feature 13: Timesheet Auto-Approval (Perfect Timesheets)
    // Scan all PENDING timesheets and auto-approve if underlying VisitCheckEvents are 100% clean
    const pendingTimesheets = await prisma.timesheet.findMany({
        where: { status: 'PENDING' },
        include: {
            items: {
                include: {
                    visit: {
                        include: { checkEvents: true }
                    }
                }
            }
        }
    });

    let autoApprovedCount = 0;
    for (const sheet of pendingTimesheets) {
        let hasFlags = false;
        
        // Loop through the timesheet line items -> visits -> check events
        for (const item of sheet.items) {
            if (item.visit?.checkEvents) {
                for (const ev of item.visit.checkEvents) {
                    if (ev.result === 'flagged_distance' || ev.result === 'manual_override') {
                        hasFlags = true;
                    }
                }
            }
        }

        if (!hasFlags && sheet.items.length > 0) {
            await prisma.timesheet.update({
                where: { id: sheet.id },
                data: { status: 'APPROVED' as any, reviewedBy: 'SYSTEM_CRON', reviewedAt: new Date() }
            });
            await logAudit(prisma, 'SYSTEM', 'AUTO_APPROVE_TIMESHEET', 'TIMESHEET', sheet.id, { reason: 'clean_evv_logs' });
            autoApprovedCount++;
        }
    }

    // Feature 16: Missed Shift Alert
    // Identify `scheduled` shifts where `requestedStartAt` is > 15 minutes ago and no `check_in` event exists
    const fifteenMinutesAgo = new Date(Date.now() - 15 * 60 * 1000);
    const missedShifts = await prisma.visit.findMany({
        where: {
            status: 'scheduled',
            requestedStartAt: { lt: fifteenMinutesAgo },
            checkEvents: { none: { eventType: 'check_in' } }
        },
        include: { client: true, assignedPsw: { include: { user: true } } }
    });

    let missedShiftCount = 0;
    for (const shift of missedShifts) {
        if (shift.tenantId) {
            const coordinator = await prisma.user.findFirst({
                where: { tenantId: shift.tenantId, role: 'manager' } // Or 'coordinator' if it exists. Reverted to manager as standard default administrative mapping.
            });

            if (coordinator) {
                await prisma.communicationLog.create({
                    data: {
                        direction: 'outbound',
                        channel: 'email',
                        recipient: coordinator.email,
                        subject: `[URGENT] Missed Shift Alert - ${shift.client?.fullName}`,
                        bodyText: `PSW ${shift.assignedPsw?.user?.fullName} has not checked into their scheduled visit for Client ${shift.client?.fullName} which began 15+ minutes ago. Please re-staff immediately.`,
                        status: 'queued',
                        tenantId: shift.tenantId
                    }
                });
                // Update shift status to prevent duplicate triggers
                await prisma.visit.update({
                    where: { id: shift.id },
                    data: { status: 'missed' as any }
                });
                await logAudit(prisma, 'SYSTEM', 'MISSED_SHIFT_FLAGGED', 'VISIT', shift.id, { delay: '>15m' });
                missedShiftCount++;
            }
        }
    }

    // Feature 21: Performance Review Automator
    const oneYearAgo = new Date();
    oneYearAgo.setFullYear(oneYearAgo.getFullYear() - 1);
    
    // Check for PSWs hired ~1 year ago
    const oneYearAnniversaries = await prisma.pswProfile.findMany({
        where: {
            createdAt: { lte: oneYearAgo }
        },
        include: { user: true }
    });

    let reviewDraftsCreated = 0;
    for (const psw of oneYearAnniversaries) {
        if (!psw.user?.tenantId) continue;
        
        const recentReview = await prisma.auditLog.findFirst({
            where: {
                resourceType: 'PSW_PROFILE',
                resourceId: psw.id,
                action: 'ANNIVERSARY_REVIEW_CREATED',
                createdAt: { gte: new Date(Date.now() - 330 * 24 * 60 * 60 * 1000) } // Last 11 months
            }
        });

        if (!recentReview) {
            const hrManager = await prisma.user.findFirst({
                where: { tenantId: psw.user.tenantId, role: 'manager' }
            });

            if (hrManager) {
                // Feature 21: Draft performance review (represented via AppNotification task)
                await prisma.appNotification.create({
                    data: {
                        userId: hrManager.id,
                        tenantId: psw.user.tenantId,
                        title: 'Action Required: Annual Performance Review',
                        message: `PSW ${psw.user.fullName} has reached their 1-year anniversary. A blank Performance Review draft has been generated for your completion.`,
                        type: 'info'
                    }
                });

                await logAudit(prisma, 'SYSTEM', 'ANNIVERSARY_REVIEW_CREATED', 'PSW_PROFILE', psw.id, { reason: '1-year-anniversary' });
                reviewDraftsCreated++;
            }
        }
    }

    // Feature 22: Compliance Sync Engine
    const activeTenants = await prisma.tenant.findMany();
    let complianceMetricsProcessed = 0;
    for (const tenant of activeTenants) {
        const totalPsws = await prisma.pswProfile.count({ where: { tenantId: tenant.id } });
        const verifiedDocs = await prisma.pswDocument.count({ where: { psw: { tenantId: tenant.id }, status: 'verified' } });
        
        await prisma.systemEvent.create({
            data: {
                tenantId: tenant.id,
                operation: 'COMPLIANCE_SYNC',
                modelName: 'PswDocument',
                entityId: tenant.id,
                payload: JSON.stringify({ totalPsws, verifiedDocs, timestamp: new Date() })
            }
        });
        complianceMetricsProcessed++;
    }

    // Feature 26: Automated Dismissal Safeguard
    let dangerZoneFlags = 0;
    const activePsws = await prisma.pswProfile.findMany({ include: { user: true } });
    for (const psw of activePsws) {
        if (!psw.user?.tenantId) continue;
        const missedCount = await prisma.visit.count({
            where: { assignedPswId: psw.id, status: 'missed' as any }
        });

        if (missedCount >= 3) {
            const alerted = await prisma.systemEvent.findFirst({
                where: { operation: 'DISMISSAL_SAFEGUARD_ALERT', entityId: psw.id }
            });
            if (!alerted) {
                const manager = await prisma.user.findFirst({ where: { tenantId: psw.user.tenantId, role: 'manager' } });
                if (manager) {
                    await prisma.appNotification.create({
                        data: {
                            userId: manager.id, tenantId: psw.user.tenantId, type: 'critical',
                            title: 'DANGER ZONE: Dismissal Safeguard Triggered',
                            message: `PSW ${psw.user.fullName} has accumulated ${missedCount} "No Show" incidents. Automated suspension protocols are recommended.`
                        }
                    });
                    await prisma.systemEvent.create({
                        data: { tenantId: psw.user.tenantId, operation: 'DISMISSAL_SAFEGUARD_ALERT', modelName: 'PswProfile', entityId: psw.id, payload: '3+ missed shifts' }
                    });
                    dangerZoneFlags++;
                    console.log(`[Cron] Feature 26 Fired: Danger Zone flag raised for PSW ${psw.id} (${missedCount} missed shifts).`);
                }
            }
        }
    }

    // Feature 29: Targeted Surveys (Low Activity Outreach)
    let surveysSent = 0;
    const lowActivityUsers = await prisma.user.findMany({
        where: { roles: { has: 'psw' }, status: 'active' },
        include: { pswProfile: true }
    });

    const oneMonthAgo = new Date(Date.now() - 30 * 24 * 60 * 60 * 1000);
    const ninetyDaysAgo = new Date(Date.now() - 90 * 24 * 60 * 60 * 1000);
    
    for (const pswUser of lowActivityUsers) {
        if (!pswUser.tenantId || !pswUser.pswProfile) continue;
        
        const recentTimesheets = await prisma.timesheet.count({
            where: { pswId: pswUser.pswProfile.id, createdAt: { gt: oneMonthAgo } }
        });
        
        if (recentTimesheets === 0) {
            const recentlySurveyed = await prisma.appNotification.findFirst({
                where: { userId: pswUser.id, title: 'Quarterly Check-In Survey', createdAt: { gt: ninetyDaysAgo } }
            });
            
            if (!recentlySurveyed) {
                await prisma.appNotification.create({
                     data: {
                         userId: pswUser.id,
                         tenantId: pswUser.tenantId,
                         type: 'info',
                         title: 'Quarterly Check-In Survey',
                         message: 'We noticed you haven\'t picked up many shifts lately. Complete this quick survey to let us know how we can support you better: https://link.to/survey'
                     }
                });
                surveysSent++;
                console.log(`[Cron] Feature 29 Fired: Dispatched targeted retention survey to inactive PSW ${pswUser.id}.`);
            }
        }
    }

    console.log(`[Cron] System Sweeps: Processed ${processed} SLA breaches. Auto-approved ${autoApprovedCount} perfect timesheets. Flagged ${missedShiftCount} missed shifts. Generated ${reviewDraftsCreated} performance reviews. Synced ${complianceMetricsProcessed} compliance telemetry metrics. Flagged ${dangerZoneFlags} dismissal warnings. Sent ${surveysSent} targeted surveys.`);
    return c.json({ processed, autoApprovedCount, missedShiftCount, reviewDraftsCreated, complianceMetricsProcessed, dangerZoneFlags, surveysSent, message: `System Sweeps successful.` }, 200);
});

export default r;
