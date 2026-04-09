/**
 * Epic 24: Dynamic Surge Pricer
 * 
 * Background Cron Job that an Uber-style surge pricing model.
 * It queries the marketplace for open, unfilled shifts that are starting within
 * the next 2 hours. If staffing is critical, it automatically appends a +$5.00/hr
 * surge multiplier to incentivize off-duty workers to pick up the shift.
 */

interface OpenShift {
    id: string;
    startTime: string; // ISO string
    baseHourlyRate: number;
    currentSurgeBonus: number;
    isFilled: boolean;
}

export class DynamicSurgePricer {

    private static SURGE_INCREMENT = 5.00; // +$5.00 per hour
    private static MAX_SURGE = 25.00; // Cap at +$25.00/hr

    /**
     * Identifies critically unstaffed shifts.
     */
    static async executeSurgeCalculation(shifts: OpenShift[]): Promise<number> {
        let surgeCount = 0;
        const now = new Date().getTime();

        for (const shift of shifts) {
            if (shift.isFilled) continue;

            const shiftStart = new Date(shift.startTime).getTime();
            const timeDiffHours = (shiftStart - now) / (1000 * 60 * 60);

            // If the shift starts in less than 2 hours and isn't filled...
            if (timeDiffHours <= 2.0 && timeDiffHours > 0) {
                if (shift.currentSurgeBonus < this.MAX_SURGE) {
                    shift.currentSurgeBonus += this.SURGE_INCREMENT;
                    surgeCount++;
                    console.log(`[Surge Engine] Applying +$${this.SURGE_INCREMENT} to Shift ${shift.id}. New Bonus: $${shift.currentSurgeBonus}/hr`);
                    // In reality, this pushes a Push Notification to all idle PSWs nearby
                }
            }
        }

        return surgeCount;
    }
}
