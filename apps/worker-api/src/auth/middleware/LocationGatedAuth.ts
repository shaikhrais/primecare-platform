/**
 * Epic 12: Location-Gated Authentication Middleware
 * 
 * Intercepts JWT requests for high-privilege roles (Admin, Finance).
 * Evaluates the requester's IP address against the configured agency HQ subnets.
 * If the request originates from outside the Geofence without an override token, it fails.
 */

interface AuthContext {
    userId: string;
    role: 'PSW' | 'RN' | 'COORDINATOR' | 'MANAGER' | 'ADMIN' | 'FINANCE';
    requestIp: string;
}

export class LocationGatedAuth {

 // an Environment Variable array of whitelisted CIDR blocks/IPs for the Agency HQ
    private static HQ_ALLOWED_IPS = ['192.168.1.50', '203.0.113.42', '10.0.0.0/24'];

    /**
     * Middleware check to enforce physical geographic security on sensitive roles.
     */
    static enforceLocationPolicy(context: AuthContext): boolean {
        // Field workers and coordinators are allowed to access via cellular networks globally
        if (['PSW', 'RN', 'COORDINATOR', 'MANAGER'].includes(context.role)) {
            return true;
        }

        // Admins and Finance manipulating payroll/PHI must be on-premise or VPN
        const isAuthorizedIp = this.HQ_ALLOWED_IPS.includes(context.requestIp);

        if (!isAuthorizedIp) {
            console.warn(`[SECURITY ALERT] Denied off-site ${context.role} access from unauthorized IP: ${context.requestIp}`);
            // In a real framework, this would throw a 403 Forbidden HTTP Exception
            return false; 
        }

        return true;
    }
}
