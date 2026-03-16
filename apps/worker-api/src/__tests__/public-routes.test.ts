/**
 * Public Routes — Integration Tests
 *
 * Tests the actual HTTP behavior of public endpoints using Hono's test client.
 * These test the route handlers directly without needing a running server.
 */
import { describe, it, expect, vi, beforeEach } from 'vitest';
import { OpenAPIHono } from '@hono/zod-openapi';
import { registerPublicRoutes } from '../public-routes';

// Minimal app setup mirroring index.ts (public routes only)
function createTestApp() {
    const app = new OpenAPIHono();

    // Mock prisma on every request (like prismaMiddleware does)
    app.use('*', async (c, next) => {
        const mockPrisma = {
            $queryRaw: vi.fn().mockResolvedValue([{ 1: 1 }]),
            lead: { create: vi.fn().mockResolvedValue({ id: 'lead-1', name: 'Test', email: 'a@b.com', status: 'new' }) },
            registry: { findMany: vi.fn().mockResolvedValue([]) },
        };
        c.set('prisma' as any, mockPrisma);
        await next();
    });

    registerPublicRoutes(app as any);
    return app;
}

// ═════════════════════════════════════════════════════════════════════════════
// Health endpoint
// ═════════════════════════════════════════════════════════════════════════════

describe('GET /v1/health', () => {
    const app = createTestApp();

    it('returns 200 with status "ok" when DB is reachable', async () => {
        const res = await app.request('/v1/health');
        expect(res.status).toBe(200);
        const body = await res.json() as Record<string, any>;
        expect(body.status).toBe('ok');
        expect(body.db).toBe('connected');
        expect(body.version).toBe('1.0.0');
        expect(body.architecture).toBe('role-first-modular');
    });

    it('includes uptime fields', async () => {
        const res = await app.request('/v1/health');
        const body = await res.json() as Record<string, any>;
        expect(body.uptime).toBeDefined();
        expect(body.uptime.ms).toBeGreaterThanOrEqual(0);
        expect(body.uptime.human).toMatch(/\d+h \d+m/);
    });

    it('includes ISO timestamp', async () => {
        const res = await app.request('/v1/health');
        const body = await res.json() as Record<string, any>;
        expect(body.time).toMatch(/^\d{4}-\d{2}-\d{2}T/);
    });

    it('returns 503 when DB throws', async () => {
        const failApp = new OpenAPIHono();
        failApp.use('*', async (c, next) => {
            c.set('prisma' as any, {
                $queryRaw: vi.fn().mockRejectedValue(new Error('DB down')),
            });
            await next();
        });
        registerPublicRoutes(failApp as any);

        const res = await failApp.request('/v1/health');
        expect(res.status).toBe(503);
        const body = await res.json() as Record<string, any>;
        expect(body.status).toBe('degraded');
        expect(body.db).toBe('disconnected');
    });
});

// ═════════════════════════════════════════════════════════════════════════════
// Branding endpoint
// ═════════════════════════════════════════════════════════════════════════════

describe('GET /v1/public/branding', () => {
    const app = createTestApp();

    it('returns 400 without slug parameter', async () => {
        const res = await app.request('/v1/public/branding');
        expect(res.status).toBe(400);
        const body = await res.json() as Record<string, any>;
        expect(body.error).toBe('Slug required');
    });

    it('returns branding data for a given slug', async () => {
        const res = await app.request('/v1/public/branding?slug=primecare');
        expect(res.status).toBe(200);
        const body = await res.json() as Record<string, any>;
        expect(body.slug).toBe('primecare');
        expect(body.name).toBe('PrimeCare');
        expect(body.brandingConfig).toBeDefined();
        expect(body.brandingConfig.primaryColor).toBe('#0F172A');
    });
});

// ═════════════════════════════════════════════════════════════════════════════
// Telemetry endpoint
// ═════════════════════════════════════════════════════════════════════════════

describe('POST /v1/telemetry/errors', () => {
    const app = createTestApp();

    it('returns 204 with valid payload', async () => {
        const res = await app.request('/v1/telemetry/errors', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                type: 'UNCAUGHT_ERROR',
                url: 'http://localhost:5173/dashboard',
                error: { name: 'TypeError', message: 'Cannot read property x' },
            }),
        });
        expect(res.status).toBe(204);
    });

    it('returns 204 even with malformed payload', async () => {
        const res = await app.request('/v1/telemetry/errors', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: '{}',
        });
        expect(res.status).toBe(204);
    });
});

// ═════════════════════════════════════════════════════════════════════════════
// Favicon
// ═════════════════════════════════════════════════════════════════════════════

describe('GET /favicon.ico', () => {
    const app = createTestApp();

    it('returns 204 (no content)', async () => {
        const res = await app.request('/favicon.ico');
        expect(res.status).toBe(204);
    });
});
