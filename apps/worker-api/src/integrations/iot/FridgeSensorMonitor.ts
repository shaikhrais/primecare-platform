/**
 * Epic 38: IoT Refrigerator Sensors
 * 
 * Scheduled chronological worker scanning IoT door-sensor logs (e.g., SmartThings).
 * It calculates the frequency of 'door open' events for dementia patients.
 * If the fridge hasn't opened in 24 hours, it flags a potential nutrition crisis to dispatch.
 */

interface DoorEvent {
    patientId: string;
    sensorId: string;
    action: 'OPEN' | 'CLOSE';
    timestamp: number; // Unix Epoch
}

export class FridgeSensorMonitor {

    private static CRITICAL_THRESHOLD_HOURS = 24.0;

    /**
     * Mocks a DB aggregation fetching the latest door interaction
     */
    private static async getLastInteraction(patientId: string): Promise<DoorEvent | null> {
        // Return a mock event from 28 hours ago
        return {
            patientId,
            sensorId: 'sensor_fridge_01',
            action: 'CLOSE',
            timestamp: new Date().getTime() - (28 * 60 * 60 * 1000)
        };
    }

    /**
     * Executes the daily IoT scan loop
     */
    static async executeNutritionScan(patientQueue: string[]): Promise<number> {
        let crisisEventsDetected = 0;
        const now = new Date().getTime();

        console.log(`[IoT Sentinel] Scanning fridge sensor logs for ${patientQueue.length} monitored patients...`);

        for (const patientId of patientQueue) {
            const lastEvent = await this.getLastInteraction(patientId);

            if (!lastEvent) {
                console.warn(`[IoT Sentinel] Patient ${patientId} has no sensor data. Assuming offline.`);
                continue;
            }

            const hoursSinceInteraction = (now - lastEvent.timestamp) / (1000 * 60 * 60);

            if (hoursSinceInteraction >= this.CRITICAL_THRESHOLD_HOURS) {
                crisisEventsDetected++;
                console.warn(`[NUTRITION CRISIS] Patient ${patientId}'s fridge has not opened in ${hoursSinceInteraction.toFixed(1)} hours! Initiating RN welfare check.`);
                // In production, this escalates a High Priority Task to the RN/Coordinator Dashboard
            }
        }

        return crisisEventsDetected;
    }
}
