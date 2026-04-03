import { PrismaClient } from '../../../../../../../generated/client/edge';

export class DailyEntryService {
    constructor(private prisma: any) { }

    async createEntry(userId: string, tenantId: string, data: any) {
        const entry = await this.prisma.dailyEntry.create({
            data: {
                ...data,
                staffId: userId,
                tenantId: tenantId,
                status: data.status as any,
            },
        });

        // Feature 1: Red-Flag Vitals Alert
        if (data.vitals && (data.vitals.systolic > 180 || data.vitals.diastolic > 120)) {
            await this.prisma.patientAlert.create({
                data: {
                    tenantId: tenantId,
                    patientId: data.clientId,
                    type: 'CLINICAL',
                    severity: 'CRITICAL',
                    message: `Hypertensive Crisis Alert: BP ${data.vitals.systolic}/${data.vitals.diastolic} recorded. Immediate RN triage required.`,
                    status: 'open'
                }
            });
            console.log(`[Worker] Feature 1 Fired: CRITICAL PatientAlert generated for BP ${data.vitals.systolic}/${data.vitals.diastolic}`);
        }

        // Feature 2: Mandatory RN Sign-Off Queue
        if (data.mood && data.mood < 3 && data.visitId) {
            // Locate an RN to assign the sign-off to (or Head Nurse)
            const headRn = await this.prisma.user.findFirst({
                where: { tenantId, role: 'rn' }
            });
            
            if (headRn) {
                // Ensure a daily audit signoff doesn't already exist for this visit to avoid Unique Constraint crash
                const existingSignoff = await this.prisma.dailyAuditSignOff.findUnique({
                    where: { visitId: data.visitId }
                });
                
                if (!existingSignoff) {
                    await this.prisma.dailyAuditSignOff.create({
                        data: {
                            rnId: headRn.id,
                            tenantId: tenantId,
                            visitId: data.visitId,
                            status: 'flagged',
                            clinicalComment: 'Auto-flagged due to low mood score (< 3).'
                        }
                    });
                    console.log(`[Worker] Feature 2 Fired: Mandatory DailyAuditSignOff cued for RN.`);
                }
            }
        }

        // Feature 7: Abnormal Behavior Triage
        if (data.notes && data.notes.toLowerCase().includes('aggression')) {
            const nextVisit = await this.prisma.visit.findFirst({
                where: { 
                    clientId: data.clientId,
                    tenantId: tenantId,
                    requestedStartAt: { gt: new Date() },
                    status: 'accepted'
                },
                orderBy: { requestedStartAt: 'asc' }
            });

            if (nextVisit && nextVisit.providerId) {
                await this.prisma.appNotification.create({
                    data: {
                        userId: nextVisit.providerId,
                        tenantId: tenantId,
                        title: 'Caution: Prior Behavioral Escalation',
                        message: `The previous caregiver noted 'aggression' for Client ID ${data.clientId}. Please proceed with caution during your upcoming visit.`,
                        type: 'warning'
                    }
                });
                console.log(`[Worker] Feature 7 Fired: Warning AppNotification sent to next PSW (${nextVisit.providerId}).`);
            }
        }

        return entry;
    }

    async getHistory(tenantId: string, clientId?: string) {
        const where: any = { tenantId };
        if (clientId) where.clientId = clientId;

        return await this.prisma.dailyEntry.findMany({
            where,
            take: 50,
            orderBy: { createdAt: 'desc' },
            include: {
                client: { select: { fullName: true } },
                staff: { select: { email: true } }
            }
        });
    }
}
