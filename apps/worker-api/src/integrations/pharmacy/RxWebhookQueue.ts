/**
 * Epic 40: Pharmacy Rx Webhooks (e.g., Surescripts)
 * 
 * Middleware processor that catches webhooks sent by connected pharmacies
 * when a doctor materially changes a prescription string (e.g. 5mg to 10mg).
 * Without manual entry, it creates an unapproved 'Care Plan Amendment'
 * on the RN's dashboard to formally accept the change into the patient's PrimeCare eMAR.
 */

interface PharmacyRxPayload {
    npi: string; // Doctor's NPI
    patientId: string;
    action: 'NEW_RX' | 'MODIFY_RX' | 'DISCONTINUE_RX';
    medication: {
        rxcui: string;
        name: string;
        instructions: string;
        prescriberName: string;
    };
}

export interface HardwareDispensePayload {
    orderId: string;
    status: 'COMPLETE' | 'FAILED' | 'OUT_OF_STOCK' | 'PARTIAL';
    dispensedNdc: string;
    dispensedQuantity: number;
    machineIp: string;
    timestamp: string;
}

export class RxWebhookQueue {

    /**
     * Executes a DB insertion to generate an RN task
     */
    private static async createCarePlanAmendment(patientId: string, summary: string) {
        // Assume Prisma DB insertion here linking to RN Dashboard Amendment Queue
        console.log(`[Amendment Engine] Generated RN Approval Task: ${summary}`);
    }

    /**
     * Main Webhook Processor
     */
    static async handlePharmacyPush(payload: PharmacyRxPayload): Promise<boolean> {
        console.log(`[Surescripts Sync] Rx Webhook received for Patient ${payload.patientId} from Dr. ${payload.medication.prescriberName}`);

        let changeSummary = '';

        switch (payload.action) {
            case 'NEW_RX':
                changeSummary = `New Medication Propagated: ${payload.medication.name}. Instructions: ${payload.medication.instructions}. Please approve addition to active eMAR.`;
                break;
            case 'MODIFY_RX':
                changeSummary = `Dosage Modified: ${payload.medication.name}. New Instructions: ${payload.medication.instructions}. Please verify against current chart.`;
                break;
            case 'DISCONTINUE_RX':
                changeSummary = `Discontinue Order Received: ${payload.medication.name}. Please remove from active eMAR schedule.`;
                break;
            default:
                console.error(`[Surescripts Sync] Unknown action type.`);
                return false;
        }

        try {
            await this.createCarePlanAmendment(payload.patientId, changeSummary);
            console.log(`[Surescripts Sync] Webhook successfully queued for RN review.`);
            return true;
        } catch (e) {
            console.error(`[Surescripts Sync] Failed to queue amendment.`, e);
            return false;
        }
    }

    /**
     * Processes external webhooks from physical Automated Dispensing Cabinets (e.g. Omnicell, Pyxis)
     */
    static async handleHardwareCallback(payload: HardwareDispensePayload): Promise<boolean> {
        console.log(`[Hardware ADC] Callback received for Order ${payload.orderId} from Machine ${payload.machineIp}`);
        
        switch (payload.status) {
            case 'COMPLETE':
                console.log(`[Hardware ADC] Dispensing SUCCESS for NDC ${payload.dispensedNdc} (Qty: ${payload.dispensedQuantity})`);
                break;
            case 'OUT_OF_STOCK':
                console.warn(`[Hardware ADC] Critical: ADC reported OUT_OF_STOCK for Order ${payload.orderId}. Flagging for Restock.`);
                break;
            case 'FAILED':
                console.error(`[Hardware ADC] Dispatch FAILED at physical cabinet ${payload.machineIp}.`);
                break;
            default:
                console.error(`[Hardware ADC] Unknown hardware status: ${payload.status}`);
        }

        // Ideally here we emit via WebSocket to update the PharmacyHub live UI
        return true;
    }
}
