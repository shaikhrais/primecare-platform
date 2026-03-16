import { useEffect, useRef } from 'react';

/**
 * useCachePrewarm — Proactively warms the API cache after login
 *
 * When a user logs in, this hook prefetches their most critical data
 * endpoints in the background so they're available offline immediately.
 * This is the key to making "offline-first" feel instant.
 *
 * Works with the service worker's stale-while-revalidate strategy:
 * the SW caches the responses, so if the user goes offline later,
 * they still have fresh data.
 *
 * Usage:
 *   useCachePrewarm(isAuthenticated, userRole);
 */
export function useCachePrewarm(isAuthenticated: boolean, userRole?: string) {
    const warmed = useRef(false);

    useEffect(() => {
        if (!isAuthenticated || warmed.current) return;
        warmed.current = true;

        // Wait a beat after login to not compete with initial page load
        const timer = setTimeout(() => {
            warmCache(userRole);
        }, 3000);

        return () => clearTimeout(timer);
    }, [isAuthenticated, userRole]);
}

async function warmCache(role?: string) {
    // Base endpoints every user needs
    const baseEndpoints = [
        '/api/v1/auth/me',
        '/api/v1/system/feature-flags',
    ];

    // Role-specific endpoints
    const roleEndpoints: Record<string, string[]> = {
        admin: [
            '/api/v1/admin/dashboard',
            '/api/v1/admin/tenants',
            '/api/v1/manager/analytics',
        ],
        manager: [
            '/api/v1/manager/schedule',
            '/api/v1/manager/staff',
            '/api/v1/manager/analytics',
            '/api/v1/manager/schedule/logistics-board',
        ],
        coordinator: [
            '/api/v1/manager/schedule',
            '/api/v1/manager/staff',
        ],
        psw: [
            '/api/v1/staff/schedule',
            '/api/v1/staff/visits',
            '/api/v1/staff/profile',
        ],
        rn: [
            '/api/v1/staff/schedule',
            '/api/v1/staff/visits',
            '/api/v1/staff/profile',
        ],
        finance: [
            '/api/v1/billing/invoices',
            '/api/v1/manager/analytics',
        ],
        client: [
            '/api/v1/client/family',
            '/api/v1/client/care-plan',
        ],
    };

    const endpoints = [
        ...baseEndpoints,
        ...(role && roleEndpoints[role] ? roleEndpoints[role] : []),
    ];

    console.log(`[CachePrewarm] Warming ${endpoints.length} endpoints for role: ${role || 'unknown'}`);

    // Fire all requests in parallel — the SW will cache the responses
    const results = await Promise.allSettled(
        endpoints.map((url) =>
            fetch(url, { credentials: 'include' })
                .then((res) => ({ url, ok: res.ok, status: res.status }))
        ),
    );

    const cached = results.filter((r) => r.status === 'fulfilled' && (r.value as any).ok).length;
    console.log(`[CachePrewarm] Warmed ${cached}/${endpoints.length} endpoints`);

    // Also proactively cache the SPA shell
    if ('caches' in window) {
        try {
            const cache = await caches.open('pc-v3-static');
            const shellResponse = await fetch('/', { credentials: 'include' });
            if (shellResponse.ok) {
                await cache.put('/', shellResponse);
                console.log('[CachePrewarm] SPA shell cached');
            }
        } catch { /* non-critical */ }
    }
}
