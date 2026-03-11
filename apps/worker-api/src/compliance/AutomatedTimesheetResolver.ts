/**
 * Epic 8: Automated Timesheet Dispute Resolution
 * 
 * Scheduled worker that scans Timesheets that are marked as "DISPUTED" or "MISSING_CLOCK_OUT".
 * It queries the device Geofence database corresponding to the worker and client home.
 * If the geofence logs prove the worker left the premise at the scheduled time, it auto-resolves.
 */

interface GeofenceLog {
    workerId: string;
    clientId: string;
    event: 'ENTER_ZONE' | 'EXIT_ZONE';
    timestamp: string;
}

interface Timesheet {
    id: string;
    workerId: string;
    status: 'PENDING' | 'DISPUTED' | 'MISSING_CLOCK_OUT' | 'APPROVED';
    scheduledEnd: string;
}

export class AutomatedTimesheetResolver {

    /**
     * Mocks a database lookup isolating when a device broke the 200m geofence radius.
     */
    private static async fetchExitGeofenceLogs(workerId: string, _date: string): Promise<GeofenceLog[]> {
        return [
            { workerId, clientId: 'client_77', event: 'ENTER_ZONE', timestamp: '2026-03-10T09:00:00Z' },
            { workerId, clientId: 'client_77', event: 'EXIT_ZONE', timestamp: '2026-03-10T17:05:00Z' } // Worker forgot to hit stop on app, but phone left premise.
        ];
    }

    /**
     * Scans and resolves orphaned timesheets.
     */
    static async executeReconciliationSweep(orphanedShifts: Timesheet[]): Promise<number> {
        let resolvedCount = 0;

        for (const sheet of orphanedShifts) {
            console.log(`[Forensics Worker] Analyzing orphaned sheet ${sheet.id} for Worker ${sheet.workerId}...`);

            const logs = await this.fetchExitGeofenceLogs(sheet.workerId, sheet.scheduledEnd);
            const exitEvent = logs.find(l => l.event === 'EXIT_ZONE');

            if (exitEvent) {
                const exitTime = new Date(exitEvent.timestamp).getTime();
                const scheduledTime = new Date(sheet.scheduledEnd).getTime();

                // If GPS exit was within 15 mins of scheduled end time, auto-approve the gap.
                const diffMinutes = Math.abs((exitTime - scheduledTime) / (1000 * 60));

                if (diffMinutes <= 15) {
                    console.log(`[Auto-Resolve] Sheet ${sheet.id} approved by AI. Geofence corroborated exit at ${exitEvent.timestamp}`);
                    sheet.status = 'APPROVED'; // In reality, update DB status + append Forensics Audit Trail
                    resolvedCount++;
                } else {
                    console.warn(`[Auto-Resolve] GPS validation failed. Handing sheet ${sheet.id} to manual Manager review.`);
                }
            }
        }

        return resolvedCount;
    }
}
