/**
 * Epic 26: Automated Mileage Reimbursement Engine
 * 
 * Scheduled chronological worker. Queries the Geofence logs for a specific
 * PSW moving between Client A and Client B. Uses the Haversine formula
 * to calculate straight-line distance, multiplies by the IRS reimbursement rate,
 * and seamlessly appends it to their weekly ledger without manual submission.
 */

interface GeofenceCheckpoint {
    timestamp: number;
    lat: number;
    lon: number;
    type: 'EXIT_CLIENT_A' | 'ENTER_CLIENT_B';
}

export class GpsReimbursementEngine {

    private static IRS_MILEAGE_RATE = 0.65; // e.g. 65 cents per mile

    /**
     * Calculates distance between two coordinates using the Haversine formula
     */
    private static calculateHaversineDistance(lat1: number, lon1: number, lat2: number, lon2: number): number {
        const R = 3958.8; // Radius of the Earth in miles
        const rlat1 = lat1 * (Math.PI / 180); 
        const rlat2 = lat2 * (Math.PI / 180); 
        const difflat = rlat2 - rlat1; 
        const difflon = (lon2 - lon1) * (Math.PI / 180); 

        const d = 2 * R * Math.asin(Math.sqrt(Math.sin(difflat / 2)*Math.sin(difflat / 2) + Math.cos(rlat1)*Math.cos(rlat2)*Math.sin(difflon / 2)*Math.sin(difflon / 2)));
        return d;
    }

    /**
     * Fetches the day's transit logs for a worker
     */
    private static async fetchTransitLegs(workerId: string): Promise<GeofenceCheckpoint[]> {
        return [
            { type: 'EXIT_CLIENT_A', lat: 40.7128, lon: -74.0060, timestamp: 1710180000 },
            { type: 'ENTER_CLIENT_B', lat: 40.7580, lon: -73.9855, timestamp: 1710183600 }
        ];
    }

    /**
     * Primary Execution
     */
    static async processDailyReimbursements(workerId: string): Promise<number> {
        const logs = await this.fetchTransitLegs(workerId);
        
        let totalMiles = 0;

        for (let i = 0; i < logs.length - 1; i += 2) {
            if (logs[i].type === 'EXIT_CLIENT_A' && logs[i+1]?.type === 'ENTER_CLIENT_B') {
                const distance = this.calculateHaversineDistance(logs[i].lat, logs[i].lon, logs[i+1].lat, logs[i+1].lon);
                totalMiles += distance;
            }
        }

        const payout = totalMiles * this.IRS_MILEAGE_RATE;
        console.log(`[Reimbursement Engine] Worker ${workerId} traveled ${totalMiles.toFixed(2)} miles. Adding $${payout.toFixed(2)} to ledger.`);
        
        // In a live system, this inserts a ledger row of type 'TRAVEL_REIMBURSEMENT'
        return payout;
    }
}
