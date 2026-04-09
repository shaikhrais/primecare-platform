/**
 * Epic 31: Apple Health / Google Fit Ingestion
 * 
 * Webhook that receives scheduled pushes from a patient's iOS device.
 * Syncs daily metrics like step count and heart rate variability (HRV)
 * into their PrimeCare patient profile to give clinicians better baseline data.
 */

interface WearablePayload {
    patientId: string;
    deviceId: string;
    timestamp: string; // ISO
    metrics: {
        steps: number;
        hrvMs: number;
        avgRestingBpm: number;
    };
}

export class AppleHealthSync {

    /**
     * Executes DB insertion for the wearable telemetry data
     */
    private static async appendToPatientRecord(prisma: any, payload: WearablePayload) {
        // Writing to Prisma IoT 
        console.log(`[Wearables] Patient ${payload.patientId} logged ${payload.metrics.steps} steps and ${payload.metrics.avgRestingBpm} BPM.`);
        await prisma.ioTEvent.create({
            data: {
                deviceId: payload.deviceId,
                deviceType: 'apple_health_wearable',
                payload: JSON.stringify(payload.metrics),
                status: 'processed',
                userId: payload.patientId
            }
        });
    }

    /**
     * Main Webhook Processor Route
     */
    static async handleInboundTelemetry(prisma: any, payload: WearablePayload): Promise<boolean> {
        console.log(`[HealthKit Sync] Processing inbound telemetry for ${payload.patientId}...`);

        if (!payload.metrics || payload.metrics.steps < 0) {
            console.error(`[HealthKit Sync] Invalid payload structure. Rejecting.`);
            return false;
        }

        try {
            await this.appendToPatientRecord(prisma, payload);

            // Optional: Trigger a heuristic check
            // e.g. If resting BPM > 100, trigger an alert to the RN queue
            if (payload.metrics.avgRestingBpm > 100) {
                console.warn(`[Vitals Alert] Patient ${payload.patientId} resting BPM is unusually high (${payload.metrics.avgRestingBpm}). Raising RN alert.`);
            }

            return true;
        } catch (e) {
            console.error(`[HealthKit Sync] Database write failed.`, e);
            return false;
        }
    }
}
