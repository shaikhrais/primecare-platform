// Governance - Category: service | Purpose: Rate Limiter Middleware for Cloudflare Workers Uses in-memory sliding window counters (per-isolate). Workers restart ...
/**
 * Rate Limiter Middleware for Cloudflare Workers
 *
 * Uses in-memory sliding window counters (per-isolate).
 * Workers restart frequently, so counters auto-reset — acceptable for DDoS mitigation.
 * For stricter limits, upgrade to Cloudflare KV or Durable Objects.
 *
 * Profiles:
 *   AUTH    — 10 req / 60s (login, register, password reset)
 *   STRICT  — 30 req / 60s (payments, API key management, admin mutations)
 *   DEFAULT — 120 req / 60s (general API calls)
 */
import { MiddlewareHandler } from 'hono';
import { Bindings, Variables } from '@primecare/contracts';

type RateLimitProfile = 'AUTH' | 'STRICT' | 'DEFAULT';

const LIMITS: Record<RateLimitProfile, { maxRequests: number; windowMs: number }> = {
    AUTH: { maxRequests: 10, windowMs: 60_000 },
    STRICT: { maxRequests: 30, windowMs: 60_000 },
    DEFAULT: { maxRequests: 120, windowMs: 60_000 },
};

// In-memory store — scoped to isolate lifetime
const requestCounts = new Map<string, { count: number; resetAt: number }>();

// Clean up expired entries periodically (every 100 calls)
let cleanupCounter = 0;
function maybeCleanup() {
    cleanupCounter++;
    if (cleanupCounter % 100 !== 0) return;
    const now = Date.now();
    for (const [key, entry] of requestCounts) {
        if (now > entry.resetAt) requestCounts.delete(key);
    }
}

function getClientKey(c: any): string {
    // Use CF-Connecting-IP (Cloudflare provides this), fallback to X-Forwarded-For
    const xForwarded = c.req.header('X-Forwarded-For');
    const ip = c.req.header('CF-Connecting-IP') || (typeof xForwarded === 'string' ? xForwarded.split(',')[0]?.trim() : 'unknown');
    const tenantId = c.req.header('X-Tenant-ID') || c.req.header('x-tenant-id') || '';
    return `${ip}:${tenantId}`;
}

function resolveProfile(path: string, method: string): RateLimitProfile {
    // AUTH endpoints
    if (path.startsWith('/v1/auth/')) return 'AUTH';

    // STRICT: sensitive mutations
    if (method !== 'GET' && (
        path.includes('/api-keys') ||
        path.includes('/payment') ||
        path.includes('/payout') ||
        path.includes('/invoice') ||
        path.includes('/webhook') ||
        path.includes('/security') ||
        path.includes('/cors-settings') ||
        path.includes('/promo')
    )) return 'STRICT';

    return 'DEFAULT';
}

export function rateLimiter(): MiddlewareHandler<{ Bindings: Bindings; Variables: Variables }> {
    return async (c, next) => {
        const path = c.req.path;
        const method = c.req.method;

        // Skip rate limiting for health checks and OPTIONS
        if (method === 'OPTIONS' || path === '/v1/health') {
            return await next();
        }

        const profile = resolveProfile(path, method);
        const { maxRequests, windowMs } = LIMITS[profile];
        const clientKey = `${getClientKey(c)}:${profile}`;
        const now = Date.now();

        maybeCleanup();

        const entry = requestCounts.get(clientKey);
        if (!entry || now > entry.resetAt) {
            // New window
            requestCounts.set(clientKey, { count: 1, resetAt: now + windowMs });
        } else {
            entry.count++;
            if (entry.count > maxRequests) {
                const retryAfter = Math.ceil((entry.resetAt - now) / 1000);
                c.header('Retry-After', String(retryAfter));
                c.header('X-RateLimit-Limit', String(maxRequests));
                c.header('X-RateLimit-Remaining', '0');
                c.header('X-RateLimit-Reset', String(Math.ceil(entry.resetAt / 1000)));

                console.warn(JSON.stringify({
                    level: 'warn',
                    type: 'RATE_LIMIT',
                    timestamp: new Date().toISOString(),
                    ip: c.req.header('CF-Connecting-IP') || 'unknown',
                    path,
                    method,
                    profile,
                    tenantId: c.req.header('X-Tenant-ID') || 'unknown',
                }));

                return c.json({
                    status: 'error',
                    message: 'Too many requests. Please try again later.',
                    retryAfter,
                }, 429);
            }
        }

        // Set rate limit headers on success
        const current = requestCounts.get(clientKey)!;
        c.header('X-RateLimit-Limit', String(maxRequests));
        c.header('X-RateLimit-Remaining', String(Math.max(0, maxRequests - current.count)));
        c.header('X-RateLimit-Reset', String(Math.ceil(current.resetAt / 1000)));

        await next();
    };
}
