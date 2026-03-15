/**
 * Hooks Deep — Structural + Export tests for remaining hooks
 *
 * Tests useApiQuery, useRealtimeSync, useRealtimeQuery, useWebVitals,
 * useDomainQueries, useDialog, useMediaQuery (standalone), and cache helpers.
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// useApiQuery
// ═══════════════════════════════════════════════════════════════════════════

describe('useApiQuery module', () => {
    it('exports useApiQuery function', async () => {
        const { useApiQuery } = await import('@/shared/hooks/useApiQuery');
        expect(typeof useApiQuery).toBe('function');
    });

    it('exports invalidateQuery function', async () => {
        const { invalidateQuery } = await import('@/shared/hooks/useApiQuery');
        expect(typeof invalidateQuery).toBe('function');
    });

    it('exports clearQueryCache function', async () => {
        const { clearQueryCache } = await import('@/shared/hooks/useApiQuery');
        expect(typeof clearQueryCache).toBe('function');
    });

    it('invalidateQuery accepts key', async () => {
        const { invalidateQuery } = await import('@/shared/hooks/useApiQuery');
        expect(() => invalidateQuery('/v1/test')).not.toThrow();
    });

    it('clearQueryCache does not throw', async () => {
        const { clearQueryCache } = await import('@/shared/hooks/useApiQuery');
        expect(() => clearQueryCache()).not.toThrow();
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// useRealtimeSync
// ═══════════════════════════════════════════════════════════════════════════

describe('useRealtimeSync module', () => {
    it('exports useRealtimeSync function', async () => {
        const { useRealtimeSync } = await import('@/shared/hooks/useRealtimeSync');
        expect(typeof useRealtimeSync).toBe('function');
    });

    it('has default export', async () => {
        const mod = await import('@/shared/hooks/useRealtimeSync');
        expect(mod.default).toBeDefined();
    });

    it('default export is same as named export', async () => {
        const mod = await import('@/shared/hooks/useRealtimeSync');
        expect(mod.default).toBe(mod.useRealtimeSync);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// useWebVitals
// ═══════════════════════════════════════════════════════════════════════════

describe('useWebVitals module', () => {
    it('exports useWebVitals function', async () => {
        const { useWebVitals } = await import('@/shared/hooks/useWebVitals');
        expect(typeof useWebVitals).toBe('function');
    });

    it('has default export', async () => {
        const mod = await import('@/shared/hooks/useWebVitals');
        expect(mod.default).toBeDefined();
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// useRealtimeQuery
// ═══════════════════════════════════════════════════════════════════════════

describe('useRealtimeQuery module', () => {
    it('exports useRealtimeQuery function', async () => {
        const { useRealtimeQuery } = await import('@/shared/hooks/useRealtimeQuery');
        expect(typeof useRealtimeQuery).toBe('function');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// useDialog
// ═══════════════════════════════════════════════════════════════════════════

describe('useDialog module', () => {
    it('exports useDialog', async () => {
        const mod = await import('@/shared/hooks/useDialog');
        expect(mod.useDialog || mod.default).toBeDefined();
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// useMediaQuery (standalone)
// ═══════════════════════════════════════════════════════════════════════════

describe('useMediaQuery standalone module', () => {
    it('exports useMediaQuery', async () => {
        const mod = await import('@/shared/hooks/useMediaQuery');
        expect(mod.useMediaQuery || mod.default).toBeDefined();
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// useDomainQueries
// ═══════════════════════════════════════════════════════════════════════════

describe('useDomainQueries module', () => {
    it('exports at least one query hook', async () => {
        const mod = await import('@/shared/hooks/useDomainQueries');
        const exports = Object.keys(mod);
        expect(exports.length).toBeGreaterThanOrEqual(1);
    });

    it('all exports are defined', async () => {
        const mod = await import('@/shared/hooks/useDomainQueries');
        for (const [key, val] of Object.entries(mod)) {
            if (key !== 'default') {
                expect(val).toBeDefined();
            }
        }
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// apiClient exports
// ═══════════════════════════════════════════════════════════════════════════

describe('apiClient module exports', () => {
    it('exports apiClient object', async () => {
        const { apiClient } = await import('@/shared/utils/apiClient');
        expect(apiClient).toBeDefined();
    });

    it('apiClient has get method', async () => {
        const { apiClient } = await import('@/shared/utils/apiClient');
        expect(typeof apiClient.get).toBe('function');
    });

    it('apiClient has post method', async () => {
        const { apiClient } = await import('@/shared/utils/apiClient');
        expect(typeof apiClient.post).toBe('function');
    });

    it('apiClient has put method', async () => {
        const { apiClient } = await import('@/shared/utils/apiClient');
        expect(typeof apiClient.put).toBe('function');
    });

    it('apiClient has patch method', async () => {
        const { apiClient } = await import('@/shared/utils/apiClient');
        expect(typeof apiClient.patch).toBe('function');
    });

    it('apiClient has delete method', async () => {
        const { apiClient } = await import('@/shared/utils/apiClient');
        expect(typeof apiClient.delete).toBe('function');
    });

    it('exports ApiError class', async () => {
        const { ApiError } = await import('@/shared/utils/apiClient');
        expect(ApiError).toBeDefined();
    });

    it('ApiError has status property', async () => {
        const { ApiError } = await import('@/shared/utils/apiClient');
        const err = new ApiError(404, 'Not Found');
        expect(err.status).toBe(404);
        expect(err.message).toBe('Not Found');
    });

    it('ApiError extends Error', async () => {
        const { ApiError } = await import('@/shared/utils/apiClient');
        const err = new ApiError(500, 'Server Error');
        expect(err).toBeInstanceOf(Error);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// device.ts exports
// ═══════════════════════════════════════════════════════════════════════════

describe('device module', () => {
    it('exports getDeviceId', async () => {
        const { getDeviceId } = await import('@/shared/utils/device');
        expect(typeof getDeviceId).toBe('function');
    });

    it('getDeviceId returns string', async () => {
        const { getDeviceId } = await import('@/shared/utils/device');
        expect(typeof getDeviceId()).toBe('string');
    });

    it('getDeviceId is stable', async () => {
        const { getDeviceId } = await import('@/shared/utils/device');
        expect(getDeviceId()).toBe(getDeviceId());
    });

    it('exports getDeviceMetadata', async () => {
        const { getDeviceMetadata } = await import('@/shared/utils/device');
        expect(typeof getDeviceMetadata).toBe('function');
    });

    it('getDeviceMetadata returns object with id', async () => {
        const { getDeviceMetadata } = await import('@/shared/utils/device');
        const meta = getDeviceMetadata();
        expect(meta.id).toBeDefined();
        expect(meta.name).toBeDefined();
        expect(meta.type).toBeDefined();
    });

    it('getDeviceMetadata type is Desktop/Mobile/Tablet', async () => {
        const { getDeviceMetadata } = await import('@/shared/utils/device');
        expect(['Desktop', 'Mobile', 'Tablet']).toContain(getDeviceMetadata().type);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// env.ts exports
// ═══════════════════════════════════════════════════════════════════════════

describe('env module', () => {
    it('exports validateEnvironment', async () => {
        const { validateEnvironment } = await import('@/shared/utils/env');
        expect(typeof validateEnvironment).toBe('function');
    });

    it('validateEnvironment does not throw', async () => {
        const { validateEnvironment } = await import('@/shared/utils/env');
        expect(() => validateEnvironment()).not.toThrow();
    });
});
