/**
 * Epic 5: Abandoned Inquiry Sweeper
 * 
 * Simulated backend worker. Scans the 'Inquiries' table every 30 minutes.
 * If a family started filling out the Cost of Care Calculator or Intake form
 * but dropped off (abandoned the funnel), this worker automatically fires
 * an SMS or Email sequence to recapture the lead.
 */

export class AbandonedInquirySweeper {

    /**
     * Mocks fetching stalled leads from the PostgreSQL Lead database
     */
    static async scanStalledFunnels(prisma: any) {
        console.log(`[Marketing Worker] Scanning Database for Abandoned Intake Forms (Older than 4 hours)...`);
        
        // Simulating DB latency
        await new Promise(res => setTimeout(res, 1200));

        const stalledLeads = [
            { id: 'lead_882', name: 'Martha Stewart', phone: '555-0102', funnelStage: 'CALCULATOR_STEP_1', lastActive: '5 hours ago' },
            { id: 'lead_901', name: 'James Wilson', email: 'j.wilson@example.com', funnelStage: 'INTAKE_MEDICAL_HISTORY', lastActive: '12 hours ago' },
            { id: 'lead_914', name: 'Sarah Connor', phone: '555-0199', funnelStage: 'PAYMENT_AUTH', lastActive: '2 days ago' }
        ];

        console.log(`[Marketing Worker] Found ${stalledLeads.length} stalled leads. Initiating win-back sequence...`);

        for (const lead of stalledLeads) {
            await this.dispatchRecaptureAlert(prisma, lead);
        }

        console.log(`[Marketing Worker] Abandoned funnel sweep complete.\n`);
    }

    private static async dispatchRecaptureAlert(prisma: any, lead: any) {
        // Sleep to mock network request to Twilio/Sendgrid
        await new Promise(res => setTimeout(res, 600));

        await prisma.communicationLog.create({
            data: {
                recipientId: lead.phone || lead.email || 'unknown',
                channel: lead.phone ? 'SMS' : 'EMAIL',
                status: 'processed',
                metadata: JSON.stringify({ type: 'abandoned_inquiry_recapture', leadId: lead.id })
            }
        });

        if (lead.phone) {
            console.log(`[Twilio Proxy] -> Sent SMS to ${lead.phone}: "Hi ${lead.name}, still looking for care options? Reply 'HELP' to speak with a PrimeCare coordinator."`);
        } else if (lead.email) {
            console.log(`[SendGrid Proxy] -> Sent Email to ${lead.email}: "PrimeCare - Complete your assessment to secure your preferred care schedule."`);
        }
    }
}
