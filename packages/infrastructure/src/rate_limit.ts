import { MiddlewareHandler } from 'hono';
import { Bindings, Variables } from '@primecare/contracts';

/**
 * R23 (L22): Distributed rate limiter using Cloudflare KV.
 * Falls back to in-memory Map for local development.
 * In production, rate limits survive worker restarts and work across isolates.
 */
const localRateLimitStore = new Map<string, { count: number; resetAt: number }>();

interface RateLimitOptions {
    windowMs?: number;      // Time window in ms (default: 60s)
    maxRequests?: number;   // Max requests per window (default: 10)
    keyPrefix?: string;     // Prefix for the rate limit key
}

export const rateLimit = (options: RateLimitOptions = {}): MiddlewareHandler<{ Bindings: Bindings; Variables: Variables }> => {
    const { windowMs = 60_000, maxRequests = 10, keyPrefix = 'rl' } = options;
    const windowSecs = Math.ceil(windowMs / 1000);

    return async (c, next) => {
        const ip = c.req.header('CF-Connecting-IP') || c.req.header('X-Forwarded-For') || '127.0.0.1';
        const key = `${keyPrefix}:${ip}`;
        const now = Date.now();
        const kv = (c.env as any)?.TOKEN_DENYLIST;

        if (kv) {
            // R23: Distributed KV-backed rate limiting
            const kvKey = `rl:${key}`;
            const existing = await kv.get(kvKey, 'json') as { count: number; resetAt: number } | null;

            if (!existing || existing.resetAt < now) {
                await kv.put(kvKey, JSON.stringify({ count: 1, resetAt: now + windowMs }), { expirationTtl: windowSecs + 10 });
                c.header('X-RateLimit-Limit', String(maxRequests));
                c.header('X-RateLimit-Remaining', String(maxRequests - 1));
                return await next();
            }

            if (existing.count >= maxRequests) {
                const retryAfter = Math.ceil((existing.resetAt - now) / 1000);
                c.header('Retry-After', String(retryAfter));
                c.header('X-RateLimit-Limit', String(maxRequests));
                c.header('X-RateLimit-Remaining', '0');
                return c.json({
                    error: 'Too Many Requests',
                    message: `Rate limit exceeded. Try again in ${retryAfter} seconds.`,
                    retryAfter,
                }, 429);
            }

            await kv.put(kvKey, JSON.stringify({ count: existing.count + 1, resetAt: existing.resetAt }), { expirationTtl: windowSecs + 10 });
            c.header('X-RateLimit-Limit', String(maxRequests));
            c.header('X-RateLimit-Remaining', String(maxRequests - existing.count - 1));
            return await next();
        }

        // Fallback: In-memory rate limiting (local dev / no KV binding)
        if (localRateLimitStore.size > 10000) {
            for (const [k, v] of localRateLimitStore) {
                if (v.resetAt < now) localRateLimitStore.delete(k);
            }
        }

        const entry = localRateLimitStore.get(key);

        if (!entry || entry.resetAt < now) {
            localRateLimitStore.set(key, { count: 1, resetAt: now + windowMs });
            c.header('X-RateLimit-Limit', String(maxRequests));
            c.header('X-RateLimit-Remaining', String(maxRequests - 1));
            return await next();
        }

        entry.count++;

        if (entry.count > maxRequests) {
            const retryAfter = Math.ceil((entry.resetAt - now) / 1000);
            c.header('Retry-After', String(retryAfter));
            c.header('X-RateLimit-Limit', String(maxRequests));
            c.header('X-RateLimit-Remaining', '0');
            return c.json({
                error: 'Too Many Requests',
                message: `Rate limit exceeded. Try again in ${retryAfter} seconds.`,
                retryAfter,
            }, 429);
        }

        c.header('X-RateLimit-Limit', String(maxRequests));
        c.header('X-RateLimit-Remaining', String(maxRequests - entry.count));
        return await next();
    };
};

/** Strict rate limit for login/register (5 attempts per minute) */
export const authRateLimit = rateLimit({ windowMs: 60_000, maxRequests: 5, keyPrefix: 'auth' });

/** Standard API rate limit (100 requests per minute) */
export const apiRateLimit = rateLimit({ windowMs: 60_000, maxRequests: 100, keyPrefix: 'api' });

/** Strict rate limit for password reset (3 attempts per 10 minutes) */
export const resetRateLimit = rateLimit({ windowMs: 600_000, maxRequests: 3, keyPrefix: 'reset' });
