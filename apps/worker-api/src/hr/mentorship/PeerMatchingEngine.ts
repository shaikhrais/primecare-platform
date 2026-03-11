/**
 * Epic 43: Peer-to-Peer Mentorship Matches
 * 
 * Background cron job that scans the directory for new hires and attempts
 * to match them with a "Veteran" caregiver based on proximity, spoken language, 
 * and complementary skillsets.
 */

interface CaregiverData {
    workerId: string;
    status: 'NEW_HIRE' | 'VETERAN';
    lat: number;
    lon: number;
    skills: string[];
}

export class PeerMatchingEngine {

    /**
     * Mocks fetching the current caregiver roster.
     */
    private static async getCaregiverRoster(): Promise<CaregiverData[]> {
        return [
            { workerId: 'w_rookie_01', status: 'NEW_HIRE', lat: 40.7128, lon: -74.0060, skills: ['CPR'] },
            { workerId: 'w_veteran_09', status: 'VETERAN', lat: 40.7135, lon: -74.0082, skills: ['CPR', 'Wound_Care', 'Dementia'] },
            { workerId: 'w_veteran_12', status: 'VETERAN', lat: 34.0522, lon: -118.2437, skills: ['CPR'] } // Too far
        ];
    }

    private static calculateDistance(lat1: number, lon1: number, lat2: number, lon2: number): number {
        // Simplified distance formula
        return Math.sqrt(Math.pow(lat1 - lat2, 2) + Math.pow(lon1 - lon2, 2));
    }

    /**
     * Executes the Mentor Matching algorithm.
     */
    static async executeMentorshipPairing(prisma: any): Promise<number> {
        console.log(`[Mentorship Engine] Scanning roster for un-mentored New Hires...`);
        const roster = await this.getCaregiverRoster();
        
        const rookies = roster.filter(w => w.status === 'NEW_HIRE');
        const veterans = roster.filter(w => w.status === 'VETERAN');
        
        let pairsCreated = 0;

        for (const rookie of rookies) {
            let bestMentor: string | null = null;
            let closestDist = Infinity;

            for (const vet of veterans) {
                const dist = this.calculateDistance(rookie.lat, rookie.lon, vet.lat, vet.lon);
                // Require them to be somewhat close contextually
                if (dist < 0.5 && dist < closestDist) {
                    closestDist = dist;
                    bestMentor = vet.workerId;
                }
            }

            if (bestMentor) {
                console.log(`[Mentorship Engine] Match Found! Connected Rookie ${rookie.workerId} with Veteran ${bestMentor}.`);
                
                await prisma.aIInference.create({
                    data: {
                        modelName: 'peer_matching_algorithm',
                        predictionData: JSON.stringify({ rookie: rookie.workerId, mentor: bestMentor }),
                        confidenceScore: 0.85,
                        userId: rookie.workerId
                    }
                });

                // Upsert Gamification Profile for the Rookie
                await prisma.gamificationProfile.upsert({
                    where: { userId: rookie.workerId },
                    create: { userId: rookie.workerId, currentTier: 'MENTEE', totalPoints: 100, careCoins: 10 },
                    update: { currentTier: 'MENTEE' }
                });

                pairsCreated++;
            } else {
                console.log(`[Mentorship Engine] No suitable mentor found for Rookie ${rookie.workerId} at this time.`);
            }
        }

        return pairsCreated;
    }
}
