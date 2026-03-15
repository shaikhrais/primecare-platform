/**
 * Design System & Shared Component Structure Tests
 *
 * Validates that all design system components export correctly,
 * have expected interfaces, and the barrel export is complete.
 * Also covers ErrorBoundary, ToastContainer, and shared hooks.
 */
import { describe, it, expect } from 'vitest';

// ── Design System Exports ─────────────────────────────────────────────────

describe('Design System Barrel Export', () => {
    it('exports LoadingSkeleton', async () => {
        const mod = await import('@/shared/components/design-system');
        expect(mod.LoadingSkeleton).toBeDefined();
        expect(typeof mod.LoadingSkeleton).toBe('function');
    });

    it('exports StatusBadge', async () => {
        const mod = await import('@/shared/components/design-system');
        expect(mod.StatusBadge).toBeDefined();
        expect(typeof mod.StatusBadge).toBe('function');
    });

    it('exports DataCard', async () => {
        const mod = await import('@/shared/components/design-system');
        expect(mod.DataCard).toBeDefined();
        expect(typeof mod.DataCard).toBe('function');
    });
});

// ── LoadingSkeleton Module ────────────────────────────────────────────────

describe('LoadingSkeleton Module', () => {
    it('has named export', async () => {
        const { LoadingSkeleton } = await import('@/shared/components/design-system/LoadingSkeleton');
        expect(LoadingSkeleton).toBeDefined();
    });

    it('has default export', async () => {
        const mod = await import('@/shared/components/design-system/LoadingSkeleton');
        expect(mod.default).toBeDefined();
    });

    it('named and default exports are the same', async () => {
        const mod = await import('@/shared/components/design-system/LoadingSkeleton');
        expect(mod.LoadingSkeleton).toBe(mod.default);
    });
});

// ── StatusBadge Module ────────────────────────────────────────────────────

describe('StatusBadge Module', () => {
    it('has named export', async () => {
        const { StatusBadge } = await import('@/shared/components/design-system/StatusBadge');
        expect(StatusBadge).toBeDefined();
    });

    it('has default export', async () => {
        const mod = await import('@/shared/components/design-system/StatusBadge');
        expect(mod.default).toBeDefined();
    });

    it('named and default exports are the same', async () => {
        const mod = await import('@/shared/components/design-system/StatusBadge');
        expect(mod.StatusBadge).toBe(mod.default);
    });
});

// ── DataCard Module ───────────────────────────────────────────────────────

describe('DataCard Module', () => {
    it('has named export', async () => {
        const { DataCard } = await import('@/shared/components/design-system/DataCard');
        expect(DataCard).toBeDefined();
    });

    it('has default export', async () => {
        const mod = await import('@/shared/components/design-system/DataCard');
        expect(mod.default).toBeDefined();
    });

    it('named and default exports are the same', async () => {
        const mod = await import('@/shared/components/design-system/DataCard');
        expect(mod.DataCard).toBe(mod.default);
    });
});

// ── ErrorBoundary Module ──────────────────────────────────────────────────

describe('ErrorBoundary Module', () => {
    it('exports ErrorBoundary class', async () => {
        const { ErrorBoundary } = await import('@/shared/components/ErrorBoundary');
        expect(ErrorBoundary).toBeDefined();
        expect(typeof ErrorBoundary).toBe('function');
    });

    it('exports RouteErrorBoundary', async () => {
        const { RouteErrorBoundary } = await import('@/shared/components/ErrorBoundary');
        expect(RouteErrorBoundary).toBeDefined();
        expect(typeof RouteErrorBoundary).toBe('function');
    });

    it('has default export', async () => {
        const mod = await import('@/shared/components/ErrorBoundary');
        expect(mod.default).toBeDefined();
    });

    it('ErrorBoundary is a class component (has prototype.render)', async () => {
        const { ErrorBoundary } = await import('@/shared/components/ErrorBoundary');
        expect(ErrorBoundary.prototype.render).toBeDefined();
        expect(typeof ErrorBoundary.prototype.render).toBe('function');
    });

    it('ErrorBoundary has getDerivedStateFromError', async () => {
        const { ErrorBoundary } = await import('@/shared/components/ErrorBoundary');
        expect(ErrorBoundary.getDerivedStateFromError).toBeDefined();
    });

    it('getDerivedStateFromError returns error state', async () => {
        const { ErrorBoundary } = await import('@/shared/components/ErrorBoundary');
        const result = ErrorBoundary.getDerivedStateFromError(new Error('Test'));
        expect(result).toHaveProperty('hasError', true);
        expect(result).toHaveProperty('error');
    });
});

// ── ToastContainer Module ─────────────────────────────────────────────────

describe('ToastContainer Module', () => {
    it('exports ToastContainer', async () => {
        const { ToastContainer } = await import('@/shared/components/ToastContainer');
        expect(ToastContainer).toBeDefined();
        expect(typeof ToastContainer).toBe('function');
    });

    it('has default export', async () => {
        const mod = await import('@/shared/components/ToastContainer');
        expect(mod.default).toBeDefined();
    });
});

// ── Hooks Modules ─────────────────────────────────────────────────────────

describe('Shared Hooks Modules', () => {
    it('exports useApiQuery', async () => {
        const mod = await import('@/shared/hooks/useApiQuery');
        expect(mod.useApiQuery).toBeDefined();
        expect(mod.invalidateQuery).toBeDefined();
        expect(mod.clearQueryCache).toBeDefined();
    });

    it('exports useApiMutation', async () => {
        const mod = await import('@/shared/hooks/useApiMutation');
        expect(mod.useApiMutation).toBeDefined();
    });

    it('exports useRealtimeSync', async () => {
        const mod = await import('@/shared/hooks/useRealtimeSync');
        expect(mod.useRealtimeSync).toBeDefined();
        expect(typeof mod.useRealtimeSync).toBe('function');
    });

    it('exports useWebVitals', async () => {
        const mod = await import('@/shared/hooks/useWebVitals');
        expect(mod.useWebVitals).toBeDefined();
        expect(typeof mod.useWebVitals).toBe('function');
    });

    it('exports domain query hooks', async () => {
        const mod = await import('@/shared/hooks/useDomainQueries');
        expect(mod.useVisits).toBeDefined();
        expect(mod.useVisit).toBeDefined();
        expect(mod.useCreateVisit).toBeDefined();
        expect(mod.useUpdateVisit).toBeDefined();
        expect(mod.useUsers).toBeDefined();
        expect(mod.useUser).toBeDefined();
        expect(mod.useCreateUser).toBeDefined();
        expect(mod.useUpdateUser).toBeDefined();
        expect(mod.useIncidents).toBeDefined();
        expect(mod.useCreateIncident).toBeDefined();
        expect(mod.useServices).toBeDefined();
        expect(mod.useInvoices).toBeDefined();
        expect(mod.useLeads).toBeDefined();
        expect(mod.useCreateLead).toBeDefined();
        expect(mod.useDashboardStats).toBeDefined();
        expect(mod.useAuditLogs).toBeDefined();
        expect(mod.QueryKeys).toBeDefined();
    });
});

// ── Stores Module ─────────────────────────────────────────────────────────

describe('Stores Module', () => {
    it('exports useAuthStore', async () => {
        const mod = await import('@/shared/stores');
        expect(mod.useAuthStore).toBeDefined();
        expect(typeof mod.useAuthStore).toBe('function');
    });

    it('exports useUIStore', async () => {
        const mod = await import('@/shared/stores');
        expect(mod.useUIStore).toBeDefined();
        expect(typeof mod.useUIStore).toBe('function');
    });

    it('exports convenience selectors', async () => {
        const mod = await import('@/shared/stores');
        expect(mod.useTenantId).toBeDefined();
        expect(mod.useActiveRole).toBeDefined();
        expect(mod.useIsDarkMode).toBeDefined();
    });
});

// ── API Client Module ─────────────────────────────────────────────────────

describe('API Client Module', () => {
    it('exports apiClient with all HTTP methods', async () => {
        const { apiClient } = await import('@/shared/utils/apiClient');
        expect(apiClient.get).toBeDefined();
        expect(apiClient.post).toBeDefined();
        expect(apiClient.put).toBeDefined();
        expect(apiClient.patch).toBeDefined();
        expect(apiClient.delete).toBeDefined();
        expect(apiClient.request).toBeDefined();
    });

    it('exports ApiError class', async () => {
        const { ApiError } = await import('@/shared/utils/apiClient');
        expect(ApiError).toBeDefined();
        const err = new ApiError(404, 'Not found');
        expect(err.status).toBe(404);
        expect(err.message).toBe('Not found');
        expect(err.name).toBe('ApiError');
    });
});

// ── Typed API Client Module ───────────────────────────────────────────────

describe('Typed API Client Module', () => {
    it('exports useTypedQuery', async () => {
        const mod = await import('@/shared/api/typedClient');
        expect(mod.useTypedQuery).toBeDefined();
    });

    it('exports useTypedMutation', async () => {
        const mod = await import('@/shared/api/typedClient');
        expect(mod.useTypedMutation).toBeDefined();
    });

    it('exports typedApi with sub-modules', async () => {
        const { typedApi } = await import('@/shared/api/typedClient');
        expect(typedApi.auth).toBeDefined();
        expect(typedApi.auth.login).toBeDefined();
        expect(typedApi.auth.register).toBeDefined();
        expect(typedApi.admin).toBeDefined();
        expect(typedApi.admin.getUsers).toBeDefined();
        expect(typedApi.admin.getDashboardStats).toBeDefined();
        expect(typedApi.manager).toBeDefined();
        expect(typedApi.manager.getVisits).toBeDefined();
        expect(typedApi.manager.createVisit).toBeDefined();
        expect(typedApi.invalidate).toBeDefined();
    });
});
