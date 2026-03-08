import { MiddlewareHandler } from 'hono';
import { Bindings, Variables } from '../../bindings';

/**
 * #6: Simple in-memory rate limiter for auth endpoints.
 * Uses a Map with IP-based keys. Resets on worker restart.
 * For production, consider Cloudflare Workers KV or Durable Objects.
 */
const rateLimitStore = new Map<string, { count: number; resetAt: number }>();

interface RateLimitOptions {
    windowMs?: number;      // Time window in ms (default: 60s)
    maxRequests?: number;   // Max requests per window (default: 10)
    keyPrefix?: string;     // Prefix for the rate limit key
}

export const rateLimit = (options: RateLimitOptions = {}): MiddlewareHandler<{ Bindings: Bindings; Variables: Variables }> => {
    const { windowMs = 60_000, maxRequests = 10, keyPrefix = 'rl' } = options;

    return async (c, next) => {
        const ip = c.req.header('CF-Connecting-IP') || c.req.header('X-Forwarded-For') || '127.0.0.1';
        const key = `${keyPrefix}:${ip}`;
        const now = Date.now();

        // Cleanup expired entries periodically
        if (rateLimitStore.size > 10000) {
            for (const [k, v] of rateLimitStore) {
                if (v.resetAt < now) rateLimitStore.delete(k);
            }
        }

        const entry = rateLimitStore.get(key);

        if (!entry || entry.resetAt < now) {
            rateLimitStore.set(key, { count: 1, resetAt: now + windowMs });
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
