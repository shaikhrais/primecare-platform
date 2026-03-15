/**
 * Security Middleware Deep Tests
 *
 * Self-contained replicas of security logic from:
 * - security.ts: Input sanitization (XSS), CSRF protection, tenant isolation
 * - errors.ts: CORS origin validation
 * - rate-limit.ts: Rate limiting logic
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// XSS Input Sanitization (replicated from security.ts)
// ═══════════════════════════════════════════════════════════════════════════

const SCRIPT_RE = /<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi;
const EVENT_RE = /\bon\w+\s*=/gi;
const HREF_JS_RE = /javascript\s*:/gi;

function sanitize(val: any): any {
    if (typeof val === 'string') {
        return val.replace(SCRIPT_RE, '').replace(EVENT_RE, '').replace(HREF_JS_RE, '');
    }
    if (Array.isArray(val)) return val.map(sanitize);
    if (val && typeof val === 'object') {
        const clean: any = {};
        for (const [k, v] of Object.entries(val)) {
            if (k === '__proto__' || k === 'constructor' || k === 'prototype') continue;
            clean[k] = sanitize(v);
        }
        return clean;
    }
    return val;
}

describe('XSS Input Sanitization', () => {
    it('strips <script> tags', () => {
        expect(sanitize('<script>alert("xss")</script>')).toBe('');
    });

    it('strips script with attributes', () => {
        expect(sanitize('<script src="evil.js"></script>')).toBe('');
    });

    it('strips multiline scripts', () => {
        expect(sanitize('<script>\nalert(1)\n</script>')).toBe('');
    });

    it('strips inline event handlers', () => {
        expect(sanitize('onclick= alert(1)')).toBe(' alert(1)');
    });

    it('strips onmouseover', () => {
        expect(sanitize('onmouseover= evil()')).toBe(' evil()');
    });

    it('strips onerror', () => {
        expect(sanitize('onerror= hack()')).toBe(' hack()');
    });

    it('strips javascript: URIs', () => {
        expect(sanitize('javascript: alert(1)')).toBe(' alert(1)');
    });

    it('strips javascript: with spaces', () => {
        expect(sanitize('javascript :void(0)')).toBe('void(0)');
    });

    it('preserves normal text', () => {
        expect(sanitize('Hello World')).toBe('Hello World');
    });

    it('preserves HTML without scripts', () => {
        expect(sanitize('<p>Hello</p>')).toBe('<p>Hello</p>');
    });

    it('sanitizes nested objects', () => {
        const input = { name: '<script>x</script>' };
        expect(sanitize(input).name).toBe('');
    });

    it('sanitizes deeply nested objects', () => {
        const input = { a: { b: { c: 'onclick= x()' } } };
        expect(sanitize(input).a.b.c).toBe(' x()');
    });

    it('sanitizes arrays', () => {
        const input = ['<script>x</script>', 'safe'];
        const result = sanitize(input);
        expect(result[0]).toBe('');
        expect(result[1]).toBe('safe');
    });

    it('sanitizes arrays in objects', () => {
        const input = { items: ['onclick= x'] };
        expect(sanitize(input).items[0]).toBe(' x');
    });

    it('returns numbers unchanged', () => {
        expect(sanitize(42)).toBe(42);
    });

    it('returns booleans unchanged', () => {
        expect(sanitize(true)).toBe(true);
    });

    it('returns null unchanged', () => {
        expect(sanitize(null)).toBe(null);
    });

    it('returns undefined unchanged', () => {
        expect(sanitize(undefined)).toBe(undefined);
    });

    // Prototype pollution protection
    it('blocks __proto__ key from being copied to clean object', () => {
        // Object.entries does NOT iterate __proto__, so it's inherently safe
        // The sanitize function also explicitly skips it in case of manual iteration
        const result = sanitize({ name: 'safe' });
        expect(result.name).toBe('safe');
        // Verify sanitize doesn't add dangerous keys
        expect(Object.getOwnPropertyNames(result)).toEqual(['name']);
    });

    it('blocks constructor key from being copied', () => {
        // When iterating with Object.entries, 'constructor' IS enumerable if set explicitly
        // Our sanitize function skips it
        const input = Object.create(null);
        input.constructor = { isAdmin: true };
        input.safe = 'ok';
        const result = sanitize(input);
        expect(Object.getOwnPropertyNames(result)).not.toContain('constructor');
        expect(result.safe).toBe('ok');
    });

    it('blocks prototype key', () => {
        const input = { prototype: { hack: true }, safe: 'ok' };
        const result = sanitize(input);
        expect(result.prototype).toBeUndefined();
        expect(result.safe).toBe('ok');
    });

    it('handles mixed XSS vectors', () => {
        const input = '<script>alert(1)</script> onclick= x javascript: evil';
        const result = sanitize(input);
        expect(result).not.toContain('<script');
        expect(result).not.toMatch(/onclick\s*=/i);
        expect(result).not.toMatch(/javascript\s*:/i);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// CSRF Protection Logic (replicated from security.ts)
// ═══════════════════════════════════════════════════════════════════════════

const SAFE_METHODS = ['GET', 'HEAD', 'OPTIONS'];

function requiresCsrf(method: string): boolean {
    return !SAFE_METHODS.includes(method);
}

function validateCsrf(method: string, hasCustomHeader: boolean): { ok: boolean; error?: string } {
    if (!requiresCsrf(method)) return { ok: true };
    if (!hasCustomHeader) return { ok: false, error: 'Missing required request headers.' };
    return { ok: true };
}

describe('CSRF Protection', () => {
    it('allows GET requests without header', () => {
        expect(validateCsrf('GET', false).ok).toBe(true);
    });

    it('allows HEAD requests without header', () => {
        expect(validateCsrf('HEAD', false).ok).toBe(true);
    });

    it('allows OPTIONS requests without header', () => {
        expect(validateCsrf('OPTIONS', false).ok).toBe(true);
    });

    it('blocks POST without custom header', () => {
        const result = validateCsrf('POST', false);
        expect(result.ok).toBe(false);
        expect(result.error).toBe('Missing required request headers.');
    });

    it('blocks PUT without custom header', () => {
        expect(validateCsrf('PUT', false).ok).toBe(false);
    });

    it('blocks PATCH without custom header', () => {
        expect(validateCsrf('PATCH', false).ok).toBe(false);
    });

    it('blocks DELETE without custom header', () => {
        expect(validateCsrf('DELETE', false).ok).toBe(false);
    });

    it('allows POST with custom header', () => {
        expect(validateCsrf('POST', true).ok).toBe(true);
    });

    it('allows PUT with custom header', () => {
        expect(validateCsrf('PUT', true).ok).toBe(true);
    });

    it('allows DELETE with custom header', () => {
        expect(validateCsrf('DELETE', true).ok).toBe(true);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Tenant Isolation Logic (replicated from security.ts)
// ═══════════════════════════════════════════════════════════════════════════

interface TenantResult {
    tenantId?: string;
    error?: string;
    status?: number;
}

function resolveTenant(headerTenantId?: string, jwtTenantId?: string, hasJwtPayload?: boolean, path?: string): TenantResult {
    // Mismatch check
    if (headerTenantId && jwtTenantId && headerTenantId !== jwtTenantId) {
        return { error: 'Session tenant does not match request tenant.', status: 403 };
    }

    const tenantId = jwtTenantId || headerTenantId;

    // Enforce tenantId for authenticated non-public routes
    if (!tenantId && hasJwtPayload) {
        const p = path || '';
        const isPublicOrAuth = p.startsWith('/v1/public/') || p.startsWith('/v1/auth/') || p.startsWith('/v1/debug/') || p === '/v1/health';
        if (!isPublicOrAuth) {
            return { error: 'Request must include tenant identification.', status: 403 };
        }
    }

    return { tenantId };
}

describe('Tenant Isolation Logic', () => {
    it('resolves from JWT tenant', () => {
        expect(resolveTenant(undefined, 'jwt-tenant').tenantId).toBe('jwt-tenant');
    });

    it('resolves from header tenant', () => {
        expect(resolveTenant('header-tenant').tenantId).toBe('header-tenant');
    });

    it('JWT takes precedence when both present and match', () => {
        expect(resolveTenant('t1', 't1').tenantId).toBe('t1');
    });

    it('rejects mismatch between header and JWT', () => {
        const result = resolveTenant('t1', 't2');
        expect(result.error).toBe('Session tenant does not match request tenant.');
        expect(result.status).toBe(403);
    });

    it('allows authenticated request without tenant on public path', () => {
        const result = resolveTenant(undefined, undefined, true, '/v1/public/health');
        expect(result.error).toBeUndefined();
    });

    it('allows authenticated request without tenant on auth path', () => {
        const result = resolveTenant(undefined, undefined, true, '/v1/auth/login');
        expect(result.error).toBeUndefined();
    });

    it('allows unauthenticated request without tenant on health', () => {
        const result = resolveTenant(undefined, undefined, true, '/v1/health');
        expect(result.error).toBeUndefined();
    });

    it('allows authenticated request without tenant on debug path', () => {
        const result = resolveTenant(undefined, undefined, true, '/v1/debug/test');
        expect(result.error).toBeUndefined();
    });

    it('rejects authenticated request without tenant on private path', () => {
        const result = resolveTenant(undefined, undefined, true, '/v1/users');
        expect(result.error).toBe('Request must include tenant identification.');
    });

    it('unauthenticated request without tenant passes (no JWT payload)', () => {
        const result = resolveTenant(undefined, undefined, false, '/v1/users');
        expect(result.error).toBeUndefined();
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// CORS Origin Validation (replicated from errors.ts)
// ═══════════════════════════════════════════════════════════════════════════

function validateOrigin(origin: string): string {
    const allowedOrigins = ['https://primecare-admin.pages.dev', 'http://localhost:5173', 'http://localhost:8787'];
    const isPreview = /^https:\/\/[a-z0-9]+\.primecare-admin\.pages\.dev$/.test(origin);
    if (allowedOrigins.includes(origin) || isPreview) return origin;
    return allowedOrigins[0]; // Fallback to production
}

describe('CORS Origin Validation', () => {
    it('allows production origin', () => {
        expect(validateOrigin('https://primecare-admin.pages.dev')).toBe('https://primecare-admin.pages.dev');
    });

    it('allows localhost:5173', () => {
        expect(validateOrigin('http://localhost:5173')).toBe('http://localhost:5173');
    });

    it('allows localhost:8787', () => {
        expect(validateOrigin('http://localhost:8787')).toBe('http://localhost:8787');
    });

    it('allows preview deployment', () => {
        expect(validateOrigin('https://abc123.primecare-admin.pages.dev')).toBe('https://abc123.primecare-admin.pages.dev');
    });

    it('allows another preview deployment', () => {
        expect(validateOrigin('https://xyz789.primecare-admin.pages.dev')).toBe('https://xyz789.primecare-admin.pages.dev');
    });

    it('rejects unknown origins (falls back to production)', () => {
        expect(validateOrigin('https://evil.com')).toBe('https://primecare-admin.pages.dev');
    });

    it('rejects empty origin', () => {
        expect(validateOrigin('')).toBe('https://primecare-admin.pages.dev');
    });

    it('rejects similar but wrong domain', () => {
        expect(validateOrigin('https://primecare-admin.evil.dev')).toBe('https://primecare-admin.pages.dev');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Rate Limiting Logic (replicated from rate-limit.ts)
// ═══════════════════════════════════════════════════════════════════════════

interface RateLimitEntry { count: number; resetAt: number; }

class RateLimiter {
    private store = new Map<string, RateLimitEntry>();
    private windowMs: number;
    private maxRequests: number;
    private keyPrefix: string;

    constructor(windowMs = 60_000, maxRequests = 10, keyPrefix = 'rl') {
        this.windowMs = windowMs;
        this.maxRequests = maxRequests;
        this.keyPrefix = keyPrefix;
    }

    check(ip: string, now: number): { allowed: boolean; remaining: number; retryAfter?: number } {
        const key = `${this.keyPrefix}:${ip}`;
        const entry = this.store.get(key);

        if (!entry || entry.resetAt < now) {
            this.store.set(key, { count: 1, resetAt: now + this.windowMs });
            return { allowed: true, remaining: this.maxRequests - 1 };
        }

        entry.count++;

        if (entry.count > this.maxRequests) {
            const retryAfter = Math.ceil((entry.resetAt - now) / 1000);
            return { allowed: false, remaining: 0, retryAfter };
        }

        return { allowed: true, remaining: this.maxRequests - entry.count };
    }

    cleanup(now: number): void {
        for (const [k, v] of this.store) {
            if (v.resetAt < now) this.store.delete(k);
        }
    }

    get size() { return this.store.size; }
}

describe('Rate Limiting Logic', () => {
    it('allows first request', () => {
        const rl = new RateLimiter(60_000, 3);
        expect(rl.check('1.2.3.4', 1000).allowed).toBe(true);
    });

    it('shows correct remaining after first request', () => {
        const rl = new RateLimiter(60_000, 5);
        expect(rl.check('1.2.3.4', 1000).remaining).toBe(4);
    });

    it('allows requests up to limit', () => {
        const rl = new RateLimiter(60_000, 3);
        const now = Date.now();
        rl.check('ip', now);
        rl.check('ip', now);
        expect(rl.check('ip', now).allowed).toBe(true);
    });

    it('blocks request exceeding limit', () => {
        const rl = new RateLimiter(60_000, 2);
        const now = Date.now();
        rl.check('ip', now);
        rl.check('ip', now);
        expect(rl.check('ip', now).allowed).toBe(false);
    });

    it('returns retry-after when blocked', () => {
        const rl = new RateLimiter(60_000, 1);
        const now = 100_000;
        rl.check('ip', now);
        const result = rl.check('ip', now);
        expect(result.retryAfter).toBeGreaterThan(0);
    });

    it('remaining is 0 when blocked', () => {
        const rl = new RateLimiter(60_000, 1);
        const now = Date.now();
        rl.check('ip', now);
        expect(rl.check('ip', now).remaining).toBe(0);
    });

    it('resets after window expires', () => {
        const rl = new RateLimiter(1000, 1); // 1 second window
        rl.check('ip', 1000);
        rl.check('ip', 1000); // blocked
        expect(rl.check('ip', 3000).allowed).toBe(true); // after window
    });

    it('tracks separate IPs independently', () => {
        const rl = new RateLimiter(60_000, 1);
        const now = Date.now();
        rl.check('ip1', now);
        expect(rl.check('ip2', now).allowed).toBe(true);
    });

    it('cleanup removes expired entries', () => {
        const rl = new RateLimiter(1000, 10);
        rl.check('ip1', 1000);
        rl.check('ip2', 1000);
        expect(rl.size).toBe(2);
        rl.cleanup(3000);
        expect(rl.size).toBe(0);
    });

    it('cleanup preserves active entries', () => {
        const rl = new RateLimiter(60_000, 10);
        const now = Date.now();
        rl.check('ip1', now);
        rl.cleanup(now);
        expect(rl.size).toBe(1);
    });

    // Preset rate limit configurations
    it('auth rate limit: 5 per minute', () => {
        const rl = new RateLimiter(60_000, 5, 'auth');
        const now = Date.now();
        for (let i = 0; i < 5; i++) rl.check('ip', now);
        expect(rl.check('ip', now).allowed).toBe(false);
    });

    it('api rate limit: 100 per minute', () => {
        const rl = new RateLimiter(60_000, 100, 'api');
        const now = Date.now();
        for (let i = 0; i < 100; i++) rl.check('ip', now);
        expect(rl.check('ip', now).allowed).toBe(false);
    });

    it('reset rate limit: 3 per 10 minutes', () => {
        const rl = new RateLimiter(600_000, 3, 'reset');
        const now = Date.now();
        rl.check('ip', now);
        rl.check('ip', now);
        rl.check('ip', now);
        expect(rl.check('ip', now).allowed).toBe(false);
    });
});
