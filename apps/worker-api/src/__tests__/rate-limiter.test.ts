/**
 * Rate Limiter — Integration Tests
 *
 * Tests the rate limiter middleware's profile resolution and enforcement
 * using the actual source functions and a Hono test app.
 */
import { describe, it, expect, beforeEach } from 'vitest';
import { Hono } from 'hono';
import { rateLimiter } from '../_shared/middleware/rate-limiter';

// Helper — create a minimal app with rate limiter + echo handler
function createRateLimitApp() {
    const app = new Hono();
    app.use('*', rateLimiter());
    app.all('*', (c) => c.json({ path: c.req.path, method: c.req.method }));
    return app;
}

// ═════════════════════════════════════════════════════════════════════════════
// Profile resolution
// ═════════════════════════════════════════════════════════════════════════════

describe('Rate Limiter — Profile Resolution', () => {
    const app = createRateLimitApp();

    it('skips rate limiting for health checks', async () => {
        const res = await app.request('/v1/health');
        expect(res.status).toBe(200);
        // Health check has no rate-limit headers
        expect(res.headers.get('X-RateLimit-Limit')).toBeNull();
    });

    it('skips rate limiting for OPTIONS requests', async () => {
        const res = await app.request('/v1/auth/login', { method: 'OPTIONS' });
        expect(res.status).toBe(200);
        expect(res.headers.get('X-RateLimit-Limit')).toBeNull();
    });

    it('applies AUTH profile (10 req) on /v1/auth/ paths', async () => {
        const res = await app.request('/v1/auth/login', {
            method: 'POST',
            headers: { 'CF-Connecting-IP': '10.0.0.1' },
        });
        expect(res.status).toBe(200);
        expect(res.headers.get('X-RateLimit-Limit')).toBe('10');
    });

    it('applies STRICT profile (30 req) on sensitive POST paths', async () => {
        const res = await app.request('/v1/admin/payment', {
            method: 'POST',
            headers: { 'CF-Connecting-IP': '10.0.0.2' },
        });
        expect(res.status).toBe(200);
        expect(res.headers.get('X-RateLimit-Limit')).toBe('30');
    });

    it('applies DEFAULT profile (120 req) on general GET paths', async () => {
        const res = await app.request('/v1/admin/users', {
            method: 'GET',
            headers: { 'CF-Connecting-IP': '10.0.0.3' },
        });
        expect(res.status).toBe(200);
        expect(res.headers.get('X-RateLimit-Limit')).toBe('120');
    });
});

// ═════════════════════════════════════════════════════════════════════════════
// Rate limit enforcement
// ═════════════════════════════════════════════════════════════════════════════

describe('Rate Limiter — Enforcement', () => {
    it('returns 429 after exceeding AUTH limit (10 req)', async () => {
        const app = createRateLimitApp();
        const ip = `enforcement-auth-${Date.now()}`;

        // Make 10 successful requests
        for (let i = 0; i < 10; i++) {
            const res = await app.request('/v1/auth/register', {
                method: 'POST',
                headers: { 'CF-Connecting-IP': ip },
            });
            expect(res.status).toBe(200);
        }

        // 11th should be rate limited
        const res = await app.request('/v1/auth/register', {
            method: 'POST',
            headers: { 'CF-Connecting-IP': ip },
        });
        expect(res.status).toBe(429);
        const body = await res.json() as Record<string, any>;
        expect(body.message).toContain('Too many requests');
        expect(res.headers.get('Retry-After')).toBeDefined();
        expect(res.headers.get('X-RateLimit-Remaining')).toBe('0');
    });

    it('tracks remaining requests in headers', async () => {
        const app = createRateLimitApp();
        const ip = `tracking-${Date.now()}`;

        const res1 = await app.request('/v1/auth/login', {
            method: 'POST',
            headers: { 'CF-Connecting-IP': ip },
        });
        expect(res1.headers.get('X-RateLimit-Remaining')).toBe('9');

        const res2 = await app.request('/v1/auth/login', {
            method: 'POST',
            headers: { 'CF-Connecting-IP': ip },
        });
        expect(res2.headers.get('X-RateLimit-Remaining')).toBe('8');
    });

    it('isolates rate limits per IP', async () => {
        const app = createRateLimitApp();

        const res1 = await app.request('/v1/auth/login', {
            method: 'POST',
            headers: { 'CF-Connecting-IP': `ip-a-${Date.now()}` },
        });
        expect(res1.headers.get('X-RateLimit-Remaining')).toBe('9');

        const res2 = await app.request('/v1/auth/login', {
            method: 'POST',
            headers: { 'CF-Connecting-IP': `ip-b-${Date.now()}` },
        });
        // Different IP should have full quota
        expect(res2.headers.get('X-RateLimit-Remaining')).toBe('9');
    });
});
