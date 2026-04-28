import type { PrismaClient } from '@primecare/database';

export class DispatchAutopilot {
    private db: PrismaClient;
    
    constructor(db: PrismaClient) {
        this.db = db;
    }

    /**
     * Booted constantly by Cloudflare CRON Triggers. Requires Zero Human Intervention.
     */
    async runAutonomousCycle(tenantId: string) {
        console.log(`[AUTOPILOT] Waking up for Tenant: ${tenantId}...`);
        
        // 1. Check Gross Margin / Budget Freeze status mathematically
        const config = await this.db.ecosystemAutopilotConfig.findUnique({
            where: { tenantId }
        });

        if (!config || !config.isActive) return { status: 'disabled' };

        console.log(`[AUTOPILOT] Native Budget Limit: $${config.maxDailySurgeBudget.toString()}. Current Spend: $${config.currentDailySurgeSpend.toString()}`);

        if (Number(config.currentDailySurgeSpend) >= Number(config.maxDailySurgeBudget)) {
            console.log(`[AUTOPILOT] CRITICAL: Daily Surge Budget Exhausted. Margin Freeze Applied Globally.`);
            // Pause all auto-surging to protect EBITDA instantly.
            return { status: 'frozen_budget_exceeded' };
        }

        // 2. Scan the Prisma Graph for unassigned shifts bleeding close to their start time
        const fourHoursFromNow = new Date(Date.now() + 4 * 60 * 60 * 1000);
        const unassignedVisits = await this.db.visit.findMany({
            where: {
                tenantId,
                status: 'requested',
                assignedProviderId: null,
                requestedStartAt: { lte: fourHoursFromNow }
            }
        });

        console.log(`[AUTOPILOT] Detected ${unassignedVisits.length} critical unstaffed physical visits.`);

        let surgeSpendAttempted = 0;

        for (const visit of unassignedVisits) {
            // Calculate absolute mathematical urgency
            const hoursUntilStart = (visit.requestedStartAt.getTime() - Date.now()) / (1000 * 60 * 60);
            
            let applyMultiplier = 1.0;
            if (hoursUntilStart <= 2) {
                applyMultiplier = 1.5; // Massive emergency 
            } else if (hoursUntilStart <= 4) {
                applyMultiplier = 1.25; // Warning tier
            }

            // Apply systemic overrides automatically if unstaffed
            if (applyMultiplier > 1.0 && visit.isSurgeActive !== true) {
                const estimatedSurgeCost = 45.00 * (applyMultiplier - 1.0); // Rough dummy estimation for demo execution

                if (Number(config.currentDailySurgeSpend) + surgeSpendAttempted + estimatedSurgeCost <= Number(config.maxDailySurgeBudget)) {
                    // Execute Autonomous Surge onto the Database natively
                    await this.db.visit.update({
                        where: { id: visit.id },
                        data: {
                            isSurgeActive: true,
                            surgeMultiplier: applyMultiplier,
                            priority: 'critical'
                        }
                    });

                    surgeSpendAttempted += estimatedSurgeCost;
                    console.log(`[AUTOPILOT] -> Surge Applied physically to Visit ${visit.id} (+${applyMultiplier}x)`);
                }
            }
        }

        // 3. Sync the global config spend up to avoid race condition bankruptcies
        if (surgeSpendAttempted > 0) {
            await this.db.ecosystemAutopilotConfig.update({
                where: { id: config.id },
                data: { currentDailySurgeSpend: Number(config.currentDailySurgeSpend) + surgeSpendAttempted }
            });
        }

        return { 
            status: 'success', 
            shiftsEvaluated: unassignedVisits.length,
            surgeSpend: surgeSpendAttempted
        };
    }
}
