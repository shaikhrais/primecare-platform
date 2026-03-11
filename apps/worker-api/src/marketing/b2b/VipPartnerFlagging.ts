import { randomUUID } from 'crypto';

/**
 * Epic 15: VIP Partner Flagging
 * 
 * Simulated backend middleware. Intercepts incoming B2B referrals and 
 * checks the NPI/Hospital ID against a "Tier 1" partners list.
 * If a Whale account sends a referral, it triggers a PagerDuty alert
 * to the Clinical Director to ensure white-glove onboarding.
 */

interface ReferralPayload {
    id: string;
    patientName: string;
    referringFacilityId: string;
    npi: string;
    notes: string;
}

export class VipPartnerInterceptor {

    // Mocked "Whale" accounts that generate > $500k/yr in revenue
    private static VIP_FACILITIES = ['FAC_ST_JUDE_01', 'FAC_MAYO_CLINIC_HQ'];
    private static VIP_PHYSICIANS = ['NPI_882910', 'NPI_112233']; // Top referrers

    static async processIncomingReferral(prisma: any, payload: ReferralPayload) {
        console.log(`[Referral Intake] Processing facesheet for patient: ${payload.patientName}...`);
        
        let isVip = false;
        let vipReason = '';

        if (this.VIP_FACILITIES.includes(payload.referringFacilityId)) {
            isVip = true;
            vipReason = `Originates from Tier 1 Corporate Network (${payload.referringFacilityId})`;
        } else if (this.VIP_PHYSICIANS.includes(payload.npi)) {
            isVip = true;
            vipReason = `Referred by Top 1% Physician (NPI: ${payload.npi})`;
        }

        if (isVip) {
            console.log(`\n🚨 [VIP PROTOCOL ENGAGED] 🚨`);
            console.log(`- Reason: ${vipReason}`);
            console.log(`- Action: Bypassing standard intake queue.`);
            console.log(`- Action: Dispatching PagerDuty alert to Director of Clinical Operations.`);
            
            await prisma.aIInference.create({
                data: {
                    modelName: 'vip_referral_flag',
                    predictionData: JSON.stringify({ facility: payload.referringFacilityId, npi: payload.npi, reason: vipReason }),
                    confidenceScore: 1.0,
                    userId: 'system'
                }
            });

            await this.dispatchVipAlert(payload);
        } else {
            console.log(`[Referral Intake] Standard routing. Added to General Triage Queue.\n`);
        }
    }

    private static async dispatchVipAlert(payload: ReferralPayload) {
        // Simulate network API call to PagerDuty/Slack
        await new Promise(res => setTimeout(res, 600));
        console.log(`[Slack Integration] -> Sent to #clinical-leadership: "⚠️ VIP Intake: Please prioritize review for ${payload.patientName}."\n`);
    }

    /**
     * Helper to mock data for terminal demonstrations
     */
    static runMockHandoff(prisma: any) {
        console.log("--- Executing Standard Handoff ---");
        this.processIncomingReferral(prisma, {
            id: randomUUID(),
            patientName: 'John Doe',
            referringFacilityId: 'FAC_RURAL_CLINIC',
            npi: 'NPI_999888',
            notes: 'Standard PT/OT requirement.'
        });

        console.log("--- Executing VIP Handoff ---");
        this.processIncomingReferral(prisma, {
            id: randomUUID(),
            patientName: 'Jane Smith (VIP)',
            referringFacilityId: 'FAC_ST_JUDE_01',
            npi: 'NPI_882910',
            notes: 'High acuity 24/7 care. Immediate staffing needed.'
        });
    }
}
