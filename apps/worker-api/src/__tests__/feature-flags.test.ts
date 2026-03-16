/**
 * Feature Flags — Behavioral Tests
 *
 * Tests actual source functions from feature-flags.ts:
 * - isFeatureEnabled (with mock Prisma)
 * - getAllFeatureFlags (with mock Prisma)
 * - requireFeature middleware (with mock Hono context)
 */
import { describe, it, expect, vi } from 'vitest';
import { isFeatureEnabled, getAllFeatureFlags, requireFeature } from '../_shared/utils/feature-flags';
import { createMockPrisma, createMockContext } from './helpers/test-utils';
import { buildTenantConfig } from './helpers/test-factories';

// ═══════════════════════════════════════════════════════════════════════════
// isFeatureEnabled
// ═══════════════════════════════════════════════════════════════════════════

describe('isFeatureEnabled (source)', () => {
    it('returns true for default-enabled feature with no overrides', async () => {
        const prisma = createMockPrisma({
            tenantConfig: { findFirst: vi.fn().mockResolvedValue(null) },
        });
        expect(await isFeatureEnabled(prisma, 'tenant-1', 'billing')).toBe(true);
    });

    it('returns false for default-disabled feature with no overrides', async () => {
        const prisma = createMockPrisma({
            tenantConfig: { findFirst: vi.fn().mockResolvedValue(null) },
        });
        expect(await isFeatureEnabled(prisma, 'tenant-1', 'api_webhooks')).toBe(false);
    });

    it('respects tenant override (enabled)', async () => {
        const config = buildTenantConfig({
            key: 'feature:api_webhooks',
            value: 'true',
        });
        const prisma = createMockPrisma({
            tenantConfig: { findFirst: vi.fn().mockResolvedValue(config) },
        });
        expect(await isFeatureEnabled(prisma, 'tenant-1', 'api_webhooks')).toBe(true);
    });

    it('respects tenant override (disabled)', async () => {
        const config = buildTenantConfig({
            key: 'feature:billing',
            value: 'false',
        });
        const prisma = createMockPrisma({
            tenantConfig: { findFirst: vi.fn().mockResolvedValue(config) },
        });
        expect(await isFeatureEnabled(prisma, 'tenant-1', 'billing')).toBe(false);
    });

    it('accepts "1" as truthy value', async () => {
        const config = buildTenantConfig({ value: '1' });
        const prisma = createMockPrisma({
            tenantConfig: { findFirst: vi.fn().mockResolvedValue(config) },
        });
        expect(await isFeatureEnabled(prisma, 'tenant-1', 'billing')).toBe(true);
    });

    it('defaults unknown features to true', async () => {
        const prisma = createMockPrisma({
            tenantConfig: { findFirst: vi.fn().mockResolvedValue(null) },
        });
        expect(await isFeatureEnabled(prisma, 'tenant-1', 'some_future_feature')).toBe(true);
    });

    it('gracefully handles missing TenantConfig table', async () => {
        // Simulate Prisma throwing because table doesn't exist
        const prisma = createMockPrisma({
            tenantConfig: {
                findFirst: vi.fn().mockRejectedValue(new Error('Table does not exist')),
            },
        });
        // Should fall through to defaults
        expect(await isFeatureEnabled(prisma, 'tenant-1', 'billing')).toBe(true);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// getAllFeatureFlags
// ═══════════════════════════════════════════════════════════════════════════

describe('getAllFeatureFlags (source)', () => {
    it('returns all defaults when no overrides', async () => {
        const prisma = createMockPrisma({
            tenantConfig: { findMany: vi.fn().mockResolvedValue([]) },
        });

        const flags = await getAllFeatureFlags(prisma, 'tenant-1');
        expect(flags.billing).toBe(true);
        expect(flags.api_webhooks).toBe(false);
        expect(flags.multi_currency).toBe(false);
        expect(flags.real_time_chat).toBe(true);
    });

    it('merges tenant overrides into defaults', async () => {
        const overrides = [
            buildTenantConfig({ key: 'feature:api_webhooks', value: 'true' }),
            buildTenantConfig({ key: 'feature:billing', value: 'false' }),
        ];
        const prisma = createMockPrisma({
            tenantConfig: { findMany: vi.fn().mockResolvedValue(overrides) },
        });

        const flags = await getAllFeatureFlags(prisma, 'tenant-1');
        expect(flags.api_webhooks).toBe(true);  // overridden
        expect(flags.billing).toBe(false);       // overridden
        expect(flags.real_time_chat).toBe(true); // default
    });

    it('gracefully handles missing TenantConfig table', async () => {
        const prisma = createMockPrisma({
            tenantConfig: {
                findMany: vi.fn().mockRejectedValue(new Error('Table does not exist')),
            },
        });

        const flags = await getAllFeatureFlags(prisma, 'tenant-1');
        expect(flags.billing).toBe(true); // defaults
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// requireFeature middleware
// ═══════════════════════════════════════════════════════════════════════════

describe('requireFeature middleware (source)', () => {
    it('calls next() when feature is enabled', async () => {
        const prisma = createMockPrisma({
            tenantConfig: { findFirst: vi.fn().mockResolvedValue(null) },
        });
        const ctx = createMockContext({
            tenantId: 'tenant-1',
            prisma,
        });
        const next = vi.fn();

        const middleware = requireFeature('billing');
        await middleware(ctx, next);

        expect(next).toHaveBeenCalled();
    });

    it('returns 403 when feature is disabled', async () => {
        const config = buildTenantConfig({ key: 'feature:api_webhooks', value: 'false' });
        const prisma = createMockPrisma({
            tenantConfig: { findFirst: vi.fn().mockResolvedValue(config) },
        });
        const ctx = createMockContext({
            tenantId: 'tenant-1',
            prisma,
        });
        const next = vi.fn();

        const middleware = requireFeature('api_webhooks');
        await middleware(ctx, next);

        expect(next).not.toHaveBeenCalled();
        expect(ctx.json).toHaveBeenCalledWith(
            expect.objectContaining({ error: 'Feature Not Available' }),
            403,
        );
    });

    it('returns 403 when no tenant context', async () => {
        const ctx = createMockContext({}); // no tenantId
        const next = vi.fn();

        const middleware = requireFeature('billing');
        await middleware(ctx, next);

        expect(next).not.toHaveBeenCalled();
        expect(ctx.json).toHaveBeenCalledWith(
            expect.objectContaining({ error: 'Tenant context required' }),
            403,
        );
    });

    it('extracts tenantId from jwtPayload when not directly set', async () => {
        const prisma = createMockPrisma({
            tenantConfig: { findFirst: vi.fn().mockResolvedValue(null) },
        });
        const ctx = createMockContext({
            jwtPayload: { tenantId: 'tenant-jwt' },
            prisma,
        });
        const next = vi.fn();

        const middleware = requireFeature('billing');
        await middleware(ctx, next);

        expect(next).toHaveBeenCalled();
    });
});
