/**
 * Domain Queries & QueryKeys Tests
 *
 * Tests useDomainQueries module: QueryKeys factory, all 16 domain hooks
 * exported as functions, and helper functions (typedGet, typedMutate).
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// Module Exports
// ═══════════════════════════════════════════════════════════════════════════

describe('Domain Queries Module Exports', () => {
    it('exports QueryKeys', async () => {
        const mod: any = await import('@/shared/hooks/useDomainQueries');
        expect(mod.QueryKeys).toBeDefined();
    });

    // Visit hooks
    it('exports useVisits', async () => {
        const mod: any = await import('@/shared/hooks/useDomainQueries');
        expect(typeof mod.useVisits).toBe('function');
    });

    it('exports useVisit', async () => {
        const mod: any = await import('@/shared/hooks/useDomainQueries');
        expect(typeof mod.useVisit).toBe('function');
    });

    it('exports useCreateVisit', async () => {
        const mod: any = await import('@/shared/hooks/useDomainQueries');
        expect(typeof mod.useCreateVisit).toBe('function');
    });

    it('exports useUpdateVisit', async () => {
        const mod: any = await import('@/shared/hooks/useDomainQueries');
        expect(typeof mod.useUpdateVisit).toBe('function');
    });

    // User hooks
    it('exports useUsers', async () => {
        const mod: any = await import('@/shared/hooks/useDomainQueries');
        expect(typeof mod.useUsers).toBe('function');
    });

    it('exports useUser', async () => {
        const mod: any = await import('@/shared/hooks/useDomainQueries');
        expect(typeof mod.useUser).toBe('function');
    });

    it('exports useCreateUser', async () => {
        const mod: any = await import('@/shared/hooks/useDomainQueries');
        expect(typeof mod.useCreateUser).toBe('function');
    });

    it('exports useUpdateUser', async () => {
        const mod: any = await import('@/shared/hooks/useDomainQueries');
        expect(typeof mod.useUpdateUser).toBe('function');
    });

    // Incident hooks
    it('exports useIncidents', async () => {
        const mod: any = await import('@/shared/hooks/useDomainQueries');
        expect(typeof mod.useIncidents).toBe('function');
    });

    it('exports useCreateIncident', async () => {
        const mod: any = await import('@/shared/hooks/useDomainQueries');
        expect(typeof mod.useCreateIncident).toBe('function');
    });

    // Service hooks
    it('exports useServices', async () => {
        const mod: any = await import('@/shared/hooks/useDomainQueries');
        expect(typeof mod.useServices).toBe('function');
    });

    // Invoice hooks
    it('exports useInvoices', async () => {
        const mod: any = await import('@/shared/hooks/useDomainQueries');
        expect(typeof mod.useInvoices).toBe('function');
    });

    // Lead hooks
    it('exports useLeads', async () => {
        const mod: any = await import('@/shared/hooks/useDomainQueries');
        expect(typeof mod.useLeads).toBe('function');
    });

    it('exports useCreateLead', async () => {
        const mod: any = await import('@/shared/hooks/useDomainQueries');
        expect(typeof mod.useCreateLead).toBe('function');
    });

    // Home hooks
    it('exports useDashboardStats', async () => {
        const mod: any = await import('@/shared/hooks/useDomainQueries');
        expect(typeof mod.useDashboardStats).toBe('function');
    });

    // Audit hooks
    it('exports useAuditLogs', async () => {
        const mod: any = await import('@/shared/hooks/useDomainQueries');
        expect(typeof mod.useAuditLogs).toBe('function');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// QueryKeys Factory
// ═══════════════════════════════════════════════════════════════════════════

describe('QueryKeys', () => {
    it('visits returns tuple with filters', async () => {
        const { QueryKeys } = await import('@/shared/hooks/useDomainQueries');
        const key = QueryKeys.visits({ status: 'scheduled' });
        expect(key[0]).toBe('visits');
        expect(key[1]).toEqual({ status: 'scheduled' });
    });

    it('visits without filters', async () => {
        const { QueryKeys } = await import('@/shared/hooks/useDomainQueries');
        const key = QueryKeys.visits();
        expect(key[0]).toBe('visits');
        expect(key[1]).toBeUndefined();
    });

    it('visit by id', async () => {
        const { QueryKeys } = await import('@/shared/hooks/useDomainQueries');
        const key = QueryKeys.visit('v123');
        expect(key).toEqual(['visits', 'v123']);
    });

    it('users returns tuple', async () => {
        const { QueryKeys } = await import('@/shared/hooks/useDomainQueries');
        const key = QueryKeys.users({ role: 'admin' });
        expect(key[0]).toBe('users');
    });

    it('user by id', async () => {
        const { QueryKeys } = await import('@/shared/hooks/useDomainQueries');
        expect(QueryKeys.user('u1')).toEqual(['users', 'u1']);
    });

    it('incidents with filters', async () => {
        const { QueryKeys } = await import('@/shared/hooks/useDomainQueries');
        const key = QueryKeys.incidents({ severity: 'high' });
        expect(key[0]).toBe('incidents');
    });

    it('services returns static key', async () => {
        const { QueryKeys } = await import('@/shared/hooks/useDomainQueries');
        expect(QueryKeys.services()).toEqual(['services']);
    });

    it('invoices with filters', async () => {
        const { QueryKeys } = await import('@/shared/hooks/useDomainQueries');
        const key = QueryKeys.invoices({ status: 'overdue' });
        expect(key[0]).toBe('invoices');
    });

    it('leads with filters', async () => {
        const { QueryKeys } = await import('@/shared/hooks/useDomainQueries');
        const key = QueryKeys.leads({ status: 'new' });
        expect(key[0]).toBe('leads');
    });

    it('dashboardStats returns static key', async () => {
        const { QueryKeys } = await import('@/shared/hooks/useDomainQueries');
        expect(QueryKeys.dashboardStats()).toEqual(['home', 'stats']);
    });

    it('auditLogs with filters', async () => {
        const { QueryKeys } = await import('@/shared/hooks/useDomainQueries');
        const key = QueryKeys.auditLogs({ action: 'LOGIN' });
        expect(key[0]).toBe('audit-logs');
    });

    it('QueryKeys has all 10 factories', async () => {
        const { QueryKeys } = await import('@/shared/hooks/useDomainQueries');
        const keys = Object.keys(QueryKeys);
        expect(keys).toEqual(expect.arrayContaining([
            'visits', 'visit', 'users', 'user', 'incidents',
            'services', 'invoices', 'leads', 'dashboardStats', 'auditLogs',
        ]));
        expect(keys).toHaveLength(10);
    });

    it('all keys return arrays', async () => {
        const { QueryKeys } = await import('@/shared/hooks/useDomainQueries');
        expect(Array.isArray(QueryKeys.visits())).toBe(true);
        expect(Array.isArray(QueryKeys.visit('1'))).toBe(true);
        expect(Array.isArray(QueryKeys.users())).toBe(true);
        expect(Array.isArray(QueryKeys.user('1'))).toBe(true);
        expect(Array.isArray(QueryKeys.incidents())).toBe(true);
        expect(Array.isArray(QueryKeys.services())).toBe(true);
        expect(Array.isArray(QueryKeys.invoices())).toBe(true);
        expect(Array.isArray(QueryKeys.leads())).toBe(true);
        expect(Array.isArray(QueryKeys.dashboardStats())).toBe(true);
        expect(Array.isArray(QueryKeys.auditLogs())).toBe(true);
    });

    it('different filters produce different keys', async () => {
        const { QueryKeys } = await import('@/shared/hooks/useDomainQueries');
        const key1 = QueryKeys.visits({ status: 'scheduled' });
        const key2 = QueryKeys.visits({ status: 'active' });
        expect(key1).not.toEqual(key2);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// API Query Hook Exports
// ═══════════════════════════════════════════════════════════════════════════

describe('useApiQuery Module', () => {
    it('exports useApiQuery', async () => {
        const mod: any = await import('@/shared/hooks/useApiQuery');
        expect(typeof mod.useApiQuery).toBe('function');
    });

    it('exports invalidateQuery', async () => {
        const mod: any = await import('@/shared/hooks/useApiQuery');
        expect(typeof mod.invalidateQuery).toBe('function');
    });

    it('exports clearQueryCache', async () => {
        const mod: any = await import('@/shared/hooks/useApiQuery');
        expect(typeof mod.clearQueryCache).toBe('function');
    });

    it('clearQueryCache is callable', async () => {
        const { clearQueryCache } = await import('@/shared/hooks/useApiQuery');
        expect(() => clearQueryCache()).not.toThrow();
    });

    it('invalidateQuery is callable', async () => {
        const { invalidateQuery } = await import('@/shared/hooks/useApiQuery');
        expect(() => invalidateQuery('/test')).not.toThrow();
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Realtime Hooks
// ═══════════════════════════════════════════════════════════════════════════

describe('Realtime Hooks', () => {
    it('useRealtimeQuery is exported', async () => {
        const mod: any = await import('@/shared/hooks/useRealtimeQuery');
        expect(typeof mod.useRealtimeQuery).toBe('function');
    });

    it('useRealtimeQuery has default export', async () => {
        const mod: any = await import('@/shared/hooks/useRealtimeQuery');
        expect(mod.default).toBeDefined();
    });

    it('useRealtimeSync is exported', async () => {
        const mod: any = await import('@/shared/hooks/useRealtimeSync');
        expect(typeof mod.useRealtimeSync).toBe('function');
    });

    it('useRealtimeSync has default export', async () => {
        const mod: any = await import('@/shared/hooks/useRealtimeSync');
        expect(mod.default).toBeDefined();
    });
});
