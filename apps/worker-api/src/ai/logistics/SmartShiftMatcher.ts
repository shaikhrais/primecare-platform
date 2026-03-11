/**
 * Epic 2: AI-Driven Shift Matching
 * 
 * Replaces manual assignment. Takes an open shift (lat/lon, required skills),
 * queries the active PSW pool, and runs a heuristic weighting algorithm 
 * combining distance, rating, and explicit skill matches to stack-rank the optimal workers.
 */

interface GeoPoint {
    lat: number;
    lon: number;
}

interface OpenShift {
    id: string;
    location: GeoPoint;
    requiredSkills: string[];
}

interface ActivePSW {
    id: string;
    name: string;
    currentLocation: GeoPoint;
    complianceRating: number; // 0.0 to 1.0
    skills: string[];
}

export class SmartShiftMatcher {

    /**
     * Haversine formula to calculate mock geographic distance in km.
     */
    private static calculateDistance(p1: GeoPoint, p2: GeoPoint): number {
        const R = 6371; // Earth radius km
        const dLat = (p2.lat - p1.lat) * Math.PI / 180;
        const dLon = (p2.lon - p1.lon) * Math.PI / 180;
        const a = Math.sin(dLat/2) * Math.sin(dLat/2) +
                  Math.cos(p1.lat * Math.PI / 180) * Math.cos(p2.lat * Math.PI / 180) *
                  Math.sin(dLon/2) * Math.sin(dLon/2);
        const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
        return R * c;
    }

    /**
     * Mocks fetching the active worker pool from Redis/PostgreSQL.
     */
    static async fetchAvailableWorkers(): Promise<ActivePSW[]> {
        return [
            { id: 'psw_1', name: 'Alice', currentLocation: { lat: 43.65, lon: -79.38 }, complianceRating: 0.95, skills: ['WOUND_CARE', 'DEMENTIA'] },
            { id: 'psw_2', name: 'Bob', currentLocation: { lat: 43.70, lon: -79.40 }, complianceRating: 0.70, skills: ['DEMENTIA'] },
            { id: 'psw_3', name: 'Charlie', currentLocation: { lat: 43.62, lon: -79.35 }, complianceRating: 0.99, skills: ['WOUND_CARE', 'PALLIATIVE'] }
        ];
    }

    /**
     * Pipeline evaluating all active workers against the target shift parameters.
     */
    static async generateOptimalMatches(shift: OpenShift, limit: number = 3): Promise<Array<{ worker: ActivePSW, matchScore: number }>> {
        console.log(`[AI Worker] Generating Smart Match array for Shift ${shift.id}`);
        const workers = await this.fetchAvailableWorkers();

        const scoredPool = workers.map(worker => {
            // 1. Distance Heuristic (Closer = Higher Score)
            const distanceKm = this.calculateDistance(shift.location, worker.currentLocation);
            const distanceScore = Math.max(0, 1 - (distanceKm / 50)); // Normalize: drops to 0 at 50km

            // 2. Skill Overlap Heuristic
            const matchedSkills = shift.requiredSkills.filter(s => worker.skills.includes(s)).length;
            const skillScore = shift.requiredSkills.length > 0 ? (matchedSkills / shift.requiredSkills.length) : 1;

            // 3. Aggregate Final Weighting
            // Weights: Skill (50%), Distance (30%), Rating (20%)
            const finalScore = (skillScore * 0.5) + (distanceScore * 0.3) + (worker.complianceRating * 0.2);

            return { worker, matchScore: finalScore };
        });

        // Sort descending by highest match
        const rankedPool = scoredPool.sort((a, b) => b.matchScore - a.matchScore);
        
        return rankedPool.slice(0, limit);
    }
}
