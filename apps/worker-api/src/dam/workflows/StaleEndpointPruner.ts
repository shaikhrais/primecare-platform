/**
 * Epic 29: Stale Endpoint Pruner
 * 
 * Backend worker that runs nightly to improve platform security.
 * It sweeps the API registry looking for routes or webhooks that haven't been
 * triggered in over 180 days. Instead of letting them sit as potential 
 * attack vectors, it automatically disables them and alerts the engineering team.
 */

interface EndpointRecord {
    id: string;
    path: string;
    lastCalledAt: Date;
    isActive: boolean;
}

export class StaleEndpointPruner {

    // Database registry
    private static registry: EndpointRecord[] = [
        { id: '1', path: '/api/v1/integrations/legacy-soap-sync', lastCalledAt: new Date('2024-05-12'), isActive: true },
        { id: '2', path: '/api/v1/auth/login', lastCalledAt: new Date(), isActive: true }
    ];

    /**
     * Executes the nightly sweep
     */
    static async sweepStaleRoutes(): Promise<number> {
        console.log(`[API Governance] Starting nightly endpoint activity scanner...`);
        
        const now = new Date();
        const expirationThreshold = new Date();
        expirationThreshold.setDate(now.getDate() - 180); // 6 Months

        let disabledCount = 0;

        for (const endpoint of this.registry) {
            if (endpoint.isActive && endpoint.lastCalledAt < expirationThreshold) {
                console.warn(`[API Governance] DANGER: Endpoint ${endpoint.path} has not been called since ${endpoint.lastCalledAt.toISOString()}.`);
                console.warn(`[API Governance] ACTION: Automatically disabling route to reduce attack surface.`);
                
                endpoint.isActive = false;
                disabledCount++;
            }
        }

        console.log(`[API Governance] Sweep complete. ${disabledCount} stale endpoints were successfully disabled.`);
        return disabledCount;
    }
}
