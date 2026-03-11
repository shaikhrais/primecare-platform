/**
 * Epic 2: Automated Lead Scoring Engine
 * 
 * Backend worker. Evaluates incoming leads based on acuity keywords
 * and zip code routing, generating a 'Priority Score' (0-100) to ensure
 * sales reps call the most profitable clients first.
 */

export class LeadScoringEngine {

    private static HIGH_VALUE_KEYWORDS = ['dementia', '24/7', 'hospice', 'alzheimers', 'bedbound', 'hoyer'];
    private static LOW_VALUE_KEYWORDS = ['companionship', 'groceries', 'driving', 'weekend', 'once a week'];

    static async evaluateNewLead(leadNote: string, zipCode: string): Promise<number> {
        let score = 50; // Base score
        const lowerNote = leadNote.toLowerCase();

        // 1. Keyword analysis (Acuity = Higher Profit / Stickiness)
        for (const word of this.HIGH_VALUE_KEYWORDS) {
            if (lowerNote.includes(word)) {
                score += 15;
            }
        }

        for (const word of this.LOW_VALUE_KEYWORDS) {
            if (lowerNote.includes(word)) {
                score -= 10;
            }
        }

        // 2. Geographic Desirability
        // Some zip codes are clustered with existing clients, making dispatching cheaper
        if (['10021', '10028', '90210'].includes(zipCode)) {
            score += 20; // Prime territory cluster
        } else if (['00000'].includes(zipCode)) {
            score -= 20; // Too remote / rural
        }

        // Cap score bounds
        return Math.max(0, Math.min(100, score));
    }

    /**
     * Executes a batch processing job of fresh inbound web leads
     */
    static async processNightlyBatch(prisma: any) {
        console.log(`[Sales Alg] Ingesting 3 new inbound leads...`);
        const inboundQueue = await prisma.user.findMany({
            where: { role: 'CLIENT' },
            take: 3
        });

        for (const lead of inboundQueue) {
            const zipCode = lead.postalCode || '00000';
            const note = lead.bio || 'Needs general assistance';
            const priority = await this.evaluateNewLead(note, zipCode);
            
            await prisma.aIInference.create({
                data: {
                    modelName: 'lead_priority_scoring',
                    predictionData: JSON.stringify({ leadId: lead.id, note }),
                    confidenceScore: priority / 100,
                    userId: 'system'
                }
            });

            let tag = 'STANDARD';
            if (priority >= 80) tag = '🔥 HOT LEAD (CALL IMMEDIATELY)';
            if (priority <= 40) tag = '❄️ COLD LEAD (PUT ON DRIP EMAIL)';

            console.log(`- Lead ${lead.id} | Score: [${priority}/100] | Action: ${tag}`);
        }
        console.log(`[Sales Alg] Lead queue prioritized for morning dispatch.\n`);
    }
}
