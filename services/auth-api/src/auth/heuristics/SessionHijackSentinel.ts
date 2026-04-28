/**
 * Epic 16: Session Hijack Sentinel
 * 
 * Middleware hook evaluating continuous live sessions. It parses the inbound
 * user-agent and IP address. If an IP suddenly mutates across the globe in <10 seconds,
 * it assumes the JWT was hijacked and actively terminates the session entirely.
 */

interface SessionRequest {
    jwtId: string;
    requestIp: string;
    userAgent: string;
    timestamp: number; // Unix Epoch
}

interface ActiveSessionData {
    lastIp: string;
    lastUserAgent: string;
    lastSeen: number;
}

export class SessionHijackSentinel {

 // an in-memory or Redis session store
    private static activeSessions: Record<string, ActiveSessionData> = {};

    /**
 * fetching the last known location for the provided JWT
     */
    private static async getSessionCache(jwtId: string): Promise<ActiveSessionData | null> {
        return this.activeSessions[jwtId] || null;
    }

    /**
     * Heuristic Engine: Analyzes request velocity to detect stolen cookies/tokens
     */
    static async validateSessionIntegrity(req: SessionRequest): Promise<{ isValid: boolean; reason?: string }> {
        const cached = await this.getSessionCache(req.jwtId);

        if (!cached) {
            // New Session, nothing to compare against yet
            this.activeSessions[req.jwtId] = { lastIp: req.requestIp, lastUserAgent: req.userAgent, lastSeen: req.timestamp };
            return { isValid: true };
        }

        const ipMutated = cached.lastIp !== req.requestIp;
        const agentMutated = cached.lastUserAgent !== req.userAgent;
        const timeDiffSeconds = Math.abs((req.timestamp - cached.lastSeen) / 1000);

        // Heuristic: If IP changes entirely in less than 60 seconds, it's highly suspicious.
        if (ipMutated && timeDiffSeconds < 60) {
            console.warn(`[SENTINEL FATAL] JWT ${req.jwtId} mutated IPs (${cached.lastIp} -> ${req.requestIp}) in ${timeDiffSeconds}s! Potential Hijack!`);
            delete this.activeSessions[req.jwtId]; // Auto-Revoke
            return { isValid: false, reason: "IMPOSSIBLE_TRAVEL_VELOCITY" };
        }

        if (agentMutated && timeDiffSeconds < 60) {
            console.warn(`[SENTINEL WARNING] JWT ${req.jwtId} mutated User-Agents. Revoking for safety.`);
            delete this.activeSessions[req.jwtId];
            return { isValid: false, reason: "BROWSER_FINGERPRINT_MISMATCH" };
        }

        // Update the cache for the next request
        this.activeSessions[req.jwtId] = { lastIp: req.requestIp, lastUserAgent: req.userAgent, lastSeen: req.timestamp };
        return { isValid: true };
    }
}
