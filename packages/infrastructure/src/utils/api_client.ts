import { Context } from 'hono';

/**
 * PrimeCare Standardized API Client
 * 
 * Provides a shielded fetch wrapper that automatically injects mandatory headers
 * required for production stability and middleware resilience.
 */
export const apiClient = {
    /**
     * A shielded fetch wrapper that:
     * 1. Injects 'X-Requested-With: XMLHttpRequest' to bypass CSRF blocks on mutation routes.
     * 2. Propagates 'X-Request-ID' (Correlation ID) from the incoming Hono context.
     * 3. Ensures consistent header casing.
     * 
     * @param url The target URL or Request object.
     * @param init Request initialization options.
     * @param c Optional Hono Context for correlation ID propagation.
     */
    async fetch(url: string | URL | Request, init?: RequestInit, c?: Context): Promise<Response> {
        const headers = new Headers(init?.headers || {});

        // 1. Inject CSRF Bypass Header
        // Mandatory for all mutation routes in PrimeCare infrastructure to prevent 403 Forbidden errors.
        if (!headers.has('X-Requested-With')) {
            headers.set('X-Requested-With', 'XMLHttpRequest');
        }

        // 2. Propagate Correlation ID and Tenant ID
        if (c) {
            const reqId = (c.get as any)('requestId') || c.req.header('X-Request-ID') || c.req.header('X-Correlation-ID');
            if (reqId) {
                if (!headers.has('X-Request-ID')) headers.set('X-Request-ID', reqId);
                if (!headers.has('X-Correlation-ID')) headers.set('X-Correlation-ID', reqId);
            }

            const tenantId = (c.get as any)('tenantId') || c.req.header('X-Tenant-ID') || c.req.header('x-tenant-id');
            if (tenantId && !headers.has('X-Tenant-ID')) {
                headers.set('X-Tenant-ID', tenantId);
            }
        }

        // 3. Perform the fetch call
        try {
            return await fetch(url, { ...init, headers });
        } catch (error) {
            // R23: Standardized error logging for unshielded fetch failures
            console.error('[FETCH_ERROR] Shielded fetch failed:', {
                url: url.toString(),
                error: error instanceof Error ? error.message : String(error)
            });
            throw error;
        }
    }
};
