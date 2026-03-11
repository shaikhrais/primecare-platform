/**
 * Epic 29: Fraudulent Overtime Detection 
 * 
 * Background scanner that analyzes submitted timesheets for temporal overlap.
 * Prevents a worker from accidentally or maliciously submitting two timesheets
 * that claim they were working in two different places at the exact same time.
 */

interface TimesheetEntry {
    id: string;
    workerId: string;
    startTime: number; // Unix Epoch
    endTime: number;   // Unix Epoch
    status: 'APPROVED' | 'PENDING' | 'DISPUTED';
}

export class OvertimeSentinel {

    /**
     * Mocks a DB aggregation fetching all timesheets for a worker in a specific week
     */
    private static async getWorkerTimesheetsForWeek(workerId: string): Promise<TimesheetEntry[]> {
        return [
            { id: 'sheet_1', workerId, startTime: 1710162000, endTime: 1710176400, status: 'APPROVED' }, // 9AM - 1PM
            { id: 'sheet_2', workerId, startTime: 1710172800, endTime: 1710187200, status: 'PENDING' }  // 12PM - 4PM (OVERLAP DETECTED)
        ];
    }

    /**
     * Executes the Overlap analysis sweep.
     */
    static async scanForTemporalFraud(workerId: string): Promise<boolean> {
        console.log(`[Fraud Sentinel] Scanning submitted timesheets for worker ${workerId}...`);

        const sheets = await this.getWorkerTimesheetsForWeek(workerId);
        
        // Sort chronologically by start time
        sheets.sort((a, b) => a.startTime - b.startTime);

        let overlapFound = false;

        for (let i = 0; i < sheets.length - 1; i++) {
            const current = sheets[i];
            const next = sheets[i + 1];

            // If the next shift started *before* the current shift ended, we have an impossible overlap.
            if (next.startTime < current.endTime) {
                overlapFound = true;
                console.warn(`[FRAUD ALERT] Impossible Overlap Detected for worker ${workerId}!`);
                console.warn(`   -> Shift ${current.id} ends at ${new Date(current.endTime * 1000).toISOString()}`);
                console.warn(`   -> Shift ${next.id} starts at ${new Date(next.startTime * 1000).toISOString()}`);
                
                // In production: Mark both as DISPUTED, suspend instant payout, notify HR.
            }
        }

        if (!overlapFound) {
            console.log(`[Fraud Sentinel] Timesheet timeline for ${workerId} is clean.`);
        }

        return overlapFound;
    }
}
