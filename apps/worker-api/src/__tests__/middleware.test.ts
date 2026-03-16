/**
 * Middleware — Integration Tests
 *
 * Tests observability, security headers, and error handling middleware
 * using Hono test app with real middleware stacks.
 */
import { describe, it, expect, vi } from 'vitest';
import { Hono } from 'hono';
import { secureHeaders } from 'hono/secure-headers';
import { correlationId, requestLogger } from '../_shared/middleware/observability';

// ═════════════════════════════════════════════════════════════════════════════
// Correlation ID
// ═════════════════════════════════════════════════════════════════════════════

describe('Correlation ID Middleware', () => {
    function createApp() {
        const app = new Hono();
        app.use('*', correlationId());
        app.get('/test', (c) => c.json({ reqId: (c.get as any)('requestId') }));
        return app;
    }

    it('generates a UUID correlation ID when none provided', async () => {
        const app = createApp();
        const res = await app.request('/test');
        expect(res.status).toBe(200);
        const id = res.headers.get('X-Request-ID');
        expect(id).toBeDefined();
        expect(id).toMatch(/^[0-9a-f]{8}-[0-9a-f]{4}-/); // UUID format
    });

    it('echoes back client-provided X-Request-ID', async () => {
        const app = createApp();
        const clientId = 'my-custom-correlation-id';
        const res = await app.request('/test', {
            headers: { 'X-Request-ID': clientId },
        });
        expect(res.headers.get('X-Request-ID')).toBe(clientId);
        const body = await res.json() as Record<string, unknown>;
        expect(body.reqId).toBe(clientId);
    });
});

// ═════════════════════════════════════════════════════════════════════════════
// Request Logger
// ═════════════════════════════════════════════════════════════════════════════

describe('Request Logger Middleware', () => {
    it('logs structured JSON for each request', async () => {
        const logSpy = vi.spyOn(console, 'log').mockImplementation(() => {});

        const app = new Hono();
        app.use('*', correlationId());
        app.use('*', requestLogger());
        app.get('/test', (c) => c.json({ ok: true }));

        await app.request('/test');

        expect(logSpy).toHaveBeenCalled();
        const logCall = logSpy.mock.calls[0]![0];
        const parsed = JSON.parse(logCall);
        expect(parsed.level).toBe('info');
        expect(parsed.method).toBe('GET');
        expect(parsed.path).toBe('/test');
        expect(parsed.status).toBe(200);
        expect(parsed.ms).toBeGreaterThanOrEqual(0);

        logSpy.mockRestore();
    });

    it('logs at warn level for 4xx responses', async () => {
        const warnSpy = vi.spyOn(console, 'warn').mockImplementation(() => {});

        const app = new Hono();
        app.use('*', correlationId());
        app.use('*', requestLogger());
        app.get('/missing', (c) => c.json({ error: 'nope' }, 404));

        await app.request('/missing');

        expect(warnSpy).toHaveBeenCalled();
        const parsed = JSON.parse(warnSpy.mock.calls[0]![0]);
        expect(parsed.level).toBe('warn');
        expect(parsed.status).toBe(404);

        warnSpy.mockRestore();
    });

    it('logs at error level for 5xx responses', async () => {
        const errorSpy = vi.spyOn(console, 'error').mockImplementation(() => {});

        const app = new Hono();
        app.use('*', correlationId());
        app.use('*', requestLogger());
        app.get('/fail', (c) => c.json({ error: 'boom' }, 500));

        await app.request('/fail');

        expect(errorSpy).toHaveBeenCalled();
        const parsed = JSON.parse(errorSpy.mock.calls[0]![0]);
        expect(parsed.level).toBe('error');
        expect(parsed.status).toBe(500);

        errorSpy.mockRestore();
    });
});

// ═════════════════════════════════════════════════════════════════════════════
// Secure Headers
// ═════════════════════════════════════════════════════════════════════════════

describe('Secure Headers Middleware', () => {
    it('adds standard security headers', async () => {
        const app = new Hono();
        app.use('*', secureHeaders());
        app.get('/test', (c) => c.json({ ok: true }));

        const res = await app.request('/test');
        expect(res.status).toBe(200);

        // secureHeaders adds these standard headers
        expect(res.headers.get('X-Content-Type-Options')).toBe('nosniff');
        expect(res.headers.get('X-Frame-Options')).toBe('SAMEORIGIN');
    });
});

// ═════════════════════════════════════════════════════════════════════════════
// Error Handler (app.onError)
// ═════════════════════════════════════════════════════════════════════════════

describe('Error Handling', () => {
    it('returns 500 JSON for unhandled route errors', async () => {
        const errorSpy = vi.spyOn(console, 'error').mockImplementation(() => {});

        const app = new Hono();
        app.onError((err, c) => {
            return c.json({ status: 'error', message: 'Internal Server Error' }, 500);
        });
        app.get('/boom', () => { throw new Error('Unexpected error'); });

        const res = await app.request('/boom');
        expect(res.status).toBe(500);
        const body = await res.json() as Record<string, unknown>;
        expect(body.status).toBe('error');
        expect(body.message).toBe('Internal Server Error');

        errorSpy.mockRestore();
    });

    it('passes errors through the onError chain', async () => {
        const errorSpy = vi.spyOn(console, 'error').mockImplementation(() => {});
        let capturedError: Error | null = null;

        const app = new Hono();
        app.onError((err, c) => {
            capturedError = err;
            return c.json({ status: 'error' }, 500);
        });
        app.get('/boom', () => { throw new Error('Specific error message'); });

        await app.request('/boom');
        expect(capturedError).toBeDefined();
        expect(capturedError!.message).toBe('Specific error message');

        errorSpy.mockRestore();
    });
});

// ═════════════════════════════════════════════════════════════════════════════
// API Version Header
// ═════════════════════════════════════════════════════════════════════════════

describe('X-API-Version Header', () => {
    it('adds X-API-Version header to responses', async () => {
        const app = new Hono();
        app.use('*', async (c, next) => { await next(); c.header('X-API-Version', '1.0.0'); });
        app.get('/test', (c) => c.json({ ok: true }));

        const res = await app.request('/test');
        expect(res.headers.get('X-API-Version')).toBe('1.0.0');
    });
});
