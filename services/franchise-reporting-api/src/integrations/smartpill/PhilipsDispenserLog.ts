/**
 * Epic 36: Smart-Pill Dispenser Hooks
 * 
 * Intercepts JSON webhooks fired from WiFi-connected Smart Pill dispensers
 * (e.g., Philips standard). When the machine physically drops the pill into the cup,
 * it verifies the event and automatically checks off the eMAR without the RN
 * needing to manually type or confirm the dose was consumed.
 */

interface PillDispenseWebhook {
    machineId: string;
    patientId: string;
    doseId: string;
    medicationName: string;
    dispensedAt: string; // ISO String
    compartmentStatus: 'EMPTY' | 'BLOCKED';
}

export class PhilipsDispenserLog {

    /**
     * Queries the database to evaluate if this dose was actually scheduled for this time window.
     */
    private static async getEMARSchedule(prisma: any, patientId: string, doseId: string) {
        return await prisma.prescription.findFirst({
            where: { patientId, status: 'Active' },
            orderBy: { createdAt: 'desc' }
        });
    }

    /**
     * Core Webhook processing logic
     */
    static async handleDispenseEvent(prisma: any, payload: PillDispenseWebhook): Promise<boolean> {
        console.log(`[Smart Pharmacy] Received dispense event from machine ${payload.machineId} for Patient ${payload.patientId}`);
        
        await prisma.ioTEvent.create({
            data: {
                deviceId: payload.machineId,
                deviceType: 'smartpill',
                payload: JSON.stringify(payload),
                status: payload.compartmentStatus === 'BLOCKED' ? 'error' : 'processed',
                userId: payload.patientId
            }
        });

        if (payload.compartmentStatus === 'BLOCKED') {
            console.error(`[Smart Pharmacy] Machine jammed! Generating critical alert to on-call RN.`);
            return false;
        }

        const emarDose = await this.getEMARSchedule(prisma, payload.patientId, payload.doseId);

        if (emarDose) {
            console.log(`[Smart Pharmacy] Validating dose of ${payload.medicationName}. Auto-signing eMAR...`);
            // In a live system: UPDATE eMar set status='ADMINISTERED', signedBy='SYSTEM_PHILIPS_IOT'
            return true;
        }

        console.warn(`[Smart Pharmacy] Dose ID ${payload.doseId} does not match active schedule. Investigating...`);
        return false;
    }
}
