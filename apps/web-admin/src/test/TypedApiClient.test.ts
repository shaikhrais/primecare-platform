/**
 * Typed API Client Structure Tests
 *
 * Tests the typed API client layer: contracts re-exports, typed query/mutation
 * options, typedApi namespace (auth, admin, manager), and module structure.
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// Module Structure
// ═══════════════════════════════════════════════════════════════════════════

describe('Typed Client Module', () => {
    it('exports useTypedQuery', async () => {
        const mod = await import('@/shared/api/typedClient');
        expect(mod.useTypedQuery).toBeDefined();
        expect(typeof mod.useTypedQuery).toBe('function');
    });

    it('exports useTypedMutation', async () => {
        const mod = await import('@/shared/api/typedClient');
        expect(mod.useTypedMutation).toBeDefined();
        expect(typeof mod.useTypedMutation).toBe('function');
    });

    it('exports typedApi namespace', async () => {
        const mod = await import('@/shared/api/typedClient');
        expect(mod.typedApi).toBeDefined();
        expect(typeof mod.typedApi).toBe('object');
    });

    it('has default export', async () => {
        const mod = await import('@/shared/api/typedClient');
        expect(mod.default).toBeDefined();
        expect(mod.default).toBe(mod.typedApi);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// typedApi Namespace — Auth
// ═══════════════════════════════════════════════════════════════════════════

describe('typedApi.auth', () => {
    it('has login method', async () => {
        const { typedApi } = await import('@/shared/api/typedClient');
        expect(typedApi.auth).toBeDefined();
        expect(typeof typedApi.auth.login).toBe('function');
    });

    it('has register method', async () => {
        const { typedApi } = await import('@/shared/api/typedClient');
        expect(typeof typedApi.auth.register).toBe('function');
    });

    it('has forgotPassword method', async () => {
        const { typedApi } = await import('@/shared/api/typedClient');
        expect(typeof typedApi.auth.forgotPassword).toBe('function');
    });

    it('has businessOnboard method', async () => {
        const { typedApi } = await import('@/shared/api/typedClient');
        expect(typeof typedApi.auth.businessOnboard).toBe('function');
    });

    it('auth has exactly 4 methods', async () => {
        const { typedApi } = await import('@/shared/api/typedClient');
        const methods = Object.keys(typedApi.auth);
        expect(methods).toHaveLength(4);
        expect(methods).toContain('login');
        expect(methods).toContain('register');
        expect(methods).toContain('forgotPassword');
        expect(methods).toContain('businessOnboard');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// typedApi Namespace — Admin
// ═══════════════════════════════════════════════════════════════════════════

describe('typedApi.admin', () => {
    it('has admin namespace', async () => {
        const { typedApi } = await import('@/shared/api/typedClient');
        expect(typedApi.admin).toBeDefined();
    });

    it('has getUsers method', async () => {
        const { typedApi } = await import('@/shared/api/typedClient');
        expect(typeof typedApi.admin.getUsers).toBe('function');
    });

    it('has getUser method', async () => {
        const { typedApi } = await import('@/shared/api/typedClient');
        expect(typeof typedApi.admin.getUser).toBe('function');
    });

    it('has createUser method', async () => {
        const { typedApi } = await import('@/shared/api/typedClient');
        expect(typeof typedApi.admin.createUser).toBe('function');
    });

    it('has updateUser method', async () => {
        const { typedApi } = await import('@/shared/api/typedClient');
        expect(typeof typedApi.admin.updateUser).toBe('function');
    });

    it('has getDashboardStats method', async () => {
        const { typedApi } = await import('@/shared/api/typedClient');
        expect(typeof typedApi.admin.getDashboardStats).toBe('function');
    });

    it('admin has exactly 5 methods', async () => {
        const { typedApi } = await import('@/shared/api/typedClient');
        expect(Object.keys(typedApi.admin)).toHaveLength(5);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// typedApi Namespace — Manager
// ═══════════════════════════════════════════════════════════════════════════

describe('typedApi.manager', () => {
    it('has manager namespace', async () => {
        const { typedApi } = await import('@/shared/api/typedClient');
        expect(typedApi.manager).toBeDefined();
    });

    it('has getVisits method', async () => {
        const { typedApi } = await import('@/shared/api/typedClient');
        expect(typeof typedApi.manager.getVisits).toBe('function');
    });

    it('has createVisit method', async () => {
        const { typedApi } = await import('@/shared/api/typedClient');
        expect(typeof typedApi.manager.createVisit).toBe('function');
    });

    it('has updateVisit method', async () => {
        const { typedApi } = await import('@/shared/api/typedClient');
        expect(typeof typedApi.manager.updateVisit).toBe('function');
    });

    it('has getIncidents method', async () => {
        const { typedApi } = await import('@/shared/api/typedClient');
        expect(typeof typedApi.manager.getIncidents).toBe('function');
    });

    it('has createIncident method', async () => {
        const { typedApi } = await import('@/shared/api/typedClient');
        expect(typeof typedApi.manager.createIncident).toBe('function');
    });

    it('manager has exactly 5 methods', async () => {
        const { typedApi } = await import('@/shared/api/typedClient');
        expect(Object.keys(typedApi.manager)).toHaveLength(5);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// typedApi — Helpers
// ═══════════════════════════════════════════════════════════════════════════

describe('typedApi helpers', () => {
    it('has invalidate helper', async () => {
        const { typedApi } = await import('@/shared/api/typedClient');
        expect(typedApi.invalidate).toBeDefined();
        expect(typeof typedApi.invalidate).toBe('function');
    });

    it('top-level has auth, admin, manager, invalidate', async () => {
        const { typedApi } = await import('@/shared/api/typedClient');
        expect(Object.keys(typedApi)).toEqual(
            expect.arrayContaining(['auth', 'admin', 'manager', 'invalidate'])
        );
    });
});
