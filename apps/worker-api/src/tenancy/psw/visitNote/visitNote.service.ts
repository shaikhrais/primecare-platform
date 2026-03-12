import { PrismaClient } from '../../../../generated/client/edge';

export class VisitNoteService {
    constructor(private prisma: any) {}

    async createNote(pswId: string, tenantId: string, data: any) {
        let finalNoteText = data.noteText;

        // Feature 4: Wound Care Photo Upload integration
        if (data.photoUrl) {
            finalNoteText += `\n\n[Wound Care Evidence Attached]: ${data.photoUrl}`;
        }

        const note = await this.prisma.visitNote.create({
            data: {
                visitId: data.visitId,
                pswId: pswId,
                noteText: finalNoteText
            }
        });

        // Feature 5: Direct Care Plan Feedback routing
        if (finalNoteText.includes('#CarePlanUpdate')) {
            // Find the CarePlan associated with this client
            // Wait, note has `visitId`. We must look up the visit to find the clientId.
            const visit = await this.prisma.visit.findUnique({
                where: { id: data.visitId }
            });

            if (visit) {
                const carePlan = await this.prisma.carePlan.findFirst({
                    where: { clientId: visit.clientId, tenantId },
                    orderBy: { version: 'desc' }
                });

                if (carePlan && carePlan.authorId) {
                    await this.prisma.appNotification.create({
                        data: {
                            userId: carePlan.authorId,
                            tenantId: tenantId,
                            title: 'Care Plan Update Requested',
                            message: `A PSW tagged a Visit Note with #CarePlanUpdate for patient tracking. Please review Visit ID: ${data.visitId}`,
                            type: 'warning'
                        }
                    });
                    console.log(`[Worker] Feature 5 Fired: #CarePlanUpdate matched. RN notified.`);
                }
            }
        }

        return note;
    }
}
