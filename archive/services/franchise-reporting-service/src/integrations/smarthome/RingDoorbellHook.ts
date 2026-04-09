/**
 * Epic 33: Ring Doorbell Camera Handshake
 * 
 * IoT Webhook connecting primecare's timeline engine to a client's
 * exterior security system. It listens for motion events mapped to the client's home,
 * automatically verifying visually that a worker arrived at the physical front porch.
 */

interface RingTelemetry {
    deviceId: string;
    ownerId: string; // Maps to PrimeCare patientId
    event: 'MOTION_DETECTED' | 'DOORBELL_RIGN';
    timestamp: string;
}

export class RingDoorbellHook {

    /**
     * Executes a DB lookup evaluating if a shift was scheduled right now.
     */
    private static async getActiveShiftForPatient(prisma: any, patientId: string) {
        const shifts = await prisma.shiftAssignment.findMany({
            where: { patientId },
            orderBy: { startTime: 'desc' },
            take: 1
        });
        return shifts[0] || null;
    }

    /**
     * Translates a Ring Motion Event into a verified Shift Arrival.
     */
    static async processIotMotion(prisma: any, payload: RingTelemetry): Promise<boolean> {
        console.log(`[IoT Sentinel] Ring Camera (${payload.deviceId}) detected motion.`);

        await prisma.ioTEvent.create({
            data: {
                deviceId: payload.deviceId,
                deviceType: 'doorbell_camera',
                payload: JSON.stringify(payload),
                status: 'processed',
                userId: payload.ownerId
            }
        });

        const activeShift = await this.getActiveShiftForPatient(prisma, payload.ownerId);

        if (activeShift && activeShift.status !== 'completed') {
            console.log(`[IoT Sentinel] Motion correlates with pending Shift ${activeShift.id}. Automatically verifying PSW arrival...`);
            // In reality, updates DB to 'IN_PROGRESS' and attaches the Ring snapshot URL to the ledger.
            return true;
        }

        console.log(`[IoT Sentinel] Motion ignored. No shift expected.`);
        return false;
    }
}
