/**
 * Shared Utils & Context Tests
 *
 * Tests: device utils, env validation, API client, contexts,
 * and all remaining untested shared modules.
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// Device Utils
// ═══════════════════════════════════════════════════════════════════════════

describe('Device Utils', () => {
    it('exports getDeviceId', async () => {
        const mod: any = await import('@/shared/utils/device');
        expect(mod.getDeviceId).toBeDefined();
        expect(typeof mod.getDeviceId).toBe('function');
    });

    it('exports getDeviceMetadata', async () => {
        const mod: any = await import('@/shared/utils/device');
        expect(mod.getDeviceMetadata).toBeDefined();
        expect(typeof mod.getDeviceMetadata).toBe('function');
    });

    it('getDeviceId returns string', async () => {
        const { getDeviceId } = await import('@/shared/utils/device');
        const id = getDeviceId();
        expect(typeof id).toBe('string');
        expect(id.length).toBeGreaterThan(0);
    });

    it('getDeviceId returns consistent value', async () => {
        const { getDeviceId } = await import('@/shared/utils/device');
        const id1 = getDeviceId();
        const id2 = getDeviceId();
        expect(id1).toBe(id2);
    });

    it('getDeviceMetadata returns object with id, name, type', async () => {
        const { getDeviceMetadata } = await import('@/shared/utils/device');
        const meta = getDeviceMetadata();
        expect(meta.id).toBeDefined();
        expect(meta.name).toBeDefined();
        expect(meta.type).toBeDefined();
    });

    it('getDeviceMetadata type is Desktop, Mobile, or Tablet', async () => {
        const { getDeviceMetadata } = await import('@/shared/utils/device');
        const meta = getDeviceMetadata();
        expect(['Desktop', 'Mobile', 'Tablet']).toContain(meta.type);
    });

    it('getDeviceMetadata name includes browser and platform', async () => {
        const { getDeviceMetadata } = await import('@/shared/utils/device');
        const meta = getDeviceMetadata();
        expect(meta.name).toContain(' on ');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Env Utils
// ═══════════════════════════════════════════════════════════════════════════

describe('Env Utils', () => {
    it('exports validateEnvironment', async () => {
        const mod: any = await import('@/shared/utils/env');
        expect(mod.validateEnvironment).toBeDefined();
        expect(typeof mod.validateEnvironment).toBe('function');
    });

    it('validateEnvironment does not throw', async () => {
        const { validateEnvironment } = await import('@/shared/utils/env');
        expect(() => validateEnvironment()).not.toThrow();
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// API Client
// ═══════════════════════════════════════════════════════════════════════════

describe('API Client', () => {
    it('exports apiClient', async () => {
        const mod: any = await import('@/shared/utils/apiClient');
        expect(mod.apiClient).toBeDefined();
    });

    it('apiClient has all HTTP methods', async () => {
        const { apiClient } = await import('@/shared/utils/apiClient');
        expect(apiClient.get).toBeDefined();
        expect(apiClient.post).toBeDefined();
        expect(apiClient.put).toBeDefined();
        expect(apiClient.patch).toBeDefined();
        expect(apiClient.delete).toBeDefined();
    });

    it('exports ApiError', async () => {
        const { ApiError } = await import('@/shared/utils/apiClient');
        expect(ApiError).toBeDefined();
    });

    it('ApiError has correct properties', async () => {
        const { ApiError } = await import('@/shared/utils/apiClient');
        const err = new ApiError(422, 'Validation failed', { field: 'email' });
        expect(err.status).toBe(422);
        expect(err.message).toBe('Validation failed');
        expect(err.name).toBe('ApiError');
        expect(err instanceof Error).toBe(true);
    });

    it('ApiError without body', async () => {
        const { ApiError } = await import('@/shared/utils/apiClient');
        const err = new ApiError(500, 'Server error');
        expect(err.status).toBe(500);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Context Modules
// ═══════════════════════════════════════════════════════════════════════════

describe('Context Modules', () => {
    describe('AuthContext', () => {
        it('exports AuthProvider', async () => {
            const mod: any = await import('@/shared/context/AuthContext');
            expect(mod.AuthProvider).toBeDefined();
        });

        it('exports useAuth hook', async () => {
            const mod: any = await import('@/shared/context/AuthContext');
            expect(mod.useAuth).toBeDefined();
            expect(typeof mod.useAuth).toBe('function');
        });
    });

    describe('ThemeContext', () => {
        it('exports ThemeProvider', async () => {
            const mod: any = await import('@/shared/context/ThemeContext');
            expect(mod.ThemeProvider).toBeDefined();
        });

        it('exports useTheme hook', async () => {
            const mod: any = await import('@/shared/context/ThemeContext');
            expect(mod.useTheme).toBeDefined();
        });
    });

    describe('NotificationContext', () => {
        it('exports NotificationProvider', async () => {
            const mod: any = await import('@/shared/context/NotificationContext');
            expect(mod.NotificationProvider).toBeDefined();
        });
    });

    describe('NotificationCenterContext', () => {
        it('exports NotificationCenterProvider', async () => {
            const mod: any = await import('@/shared/context/NotificationCenterContext');
            expect(mod.NotificationCenterProvider).toBeDefined();
        });

        it('exports useNotificationCenter', async () => {
            const mod: any = await import('@/shared/context/NotificationCenterContext');
            expect(mod.useNotificationCenter).toBeDefined();
        });
    });

    describe('CommandPaletteContext', () => {
        it('exports CommandPaletteProvider', async () => {
            const mod: any = await import('@/shared/context/CommandPaletteContext');
            expect(mod.CommandPaletteProvider).toBeDefined();
        });
    });

    describe('OfflineSyncContext', () => {
        it('exports OfflineSyncProvider', async () => {
            const mod: any = await import('@/shared/context/OfflineSyncContext');
            expect(mod.OfflineSyncProvider).toBeDefined();
        });
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Shared Hooks Modules
// ═══════════════════════════════════════════════════════════════════════════

describe('Additional Hooks', () => {
    it('exports useAutoSaveForm', async () => {
        const mod: any = await import('@/shared/hooks/useAutoSaveForm');
        expect(mod.useAutoSaveForm).toBeDefined();
    });

    it('exports useForm', async () => {
        const mod: any = await import('@/shared/hooks/useForm');
        expect(mod.default || mod.useForm).toBeDefined();
    });

    it('exports useRouteTracker', async () => {
        const mod: any = await import('@/shared/hooks/useRouteTracker');
        expect(mod.default || mod.useRouteTracker).toBeDefined();
    });

    it('exports useRealtimeQuery', async () => {
        const mod: any = await import('@/shared/hooks/useRealtimeQuery');
        expect(mod.default || mod.useRealtimeQuery).toBeDefined();
    });

    it('exports useRegistryQuery', async () => {
        const mod: any = await import('@/shared/hooks/useRegistryQuery');
        expect(mod.default || mod.useRegistryQuery).toBeDefined();
    });

    it('exports useMediaQuery', async () => {
        const mod: any = await import('@/shared/hooks/useMediaQuery');
        expect(mod.default || mod.useMediaQuery).toBeDefined();
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Shared Components Modules
// ═══════════════════════════════════════════════════════════════════════════

describe('SharedComponents', () => {
    it('exports SmartBreadcrumbs', async () => {
        const mod: any = await import('@/shared/components/SmartBreadcrumbs');
        expect(mod.default || mod.SmartBreadcrumbs).toBeDefined();
    });

    it('exports QuickActions', async () => {
        const mod: any = await import('@/shared/components/QuickActions');
        expect(mod.default || mod.QuickActions).toBeDefined();
    });

    it('exports CommandPalette', async () => {
        const mod: any = await import('@/shared/components/CommandPalette');
        expect(mod.default || mod.CommandPalette).toBeDefined();
    });

    it('exports CommandPaletteWrapper', async () => {
        const mod: any = await import('@/shared/components/CommandPaletteWrapper');
        expect(mod.default || mod.CommandPaletteWrapper).toBeDefined();
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Typed API Client
// ═══════════════════════════════════════════════════════════════════════════

describe('Typed API Client Extended', () => {
    it('typedApi.auth has login and register', async () => {
        const { typedApi } = await import('@/shared/api/typedClient');
        expect(typedApi.auth.login).toBeDefined();
        expect(typedApi.auth.register).toBeDefined();
    });

    it('typedApi.admin has comprehensive methods', async () => {
        const { typedApi } = await import('@/shared/api/typedClient');
        expect(typedApi.admin.getUsers).toBeDefined();
        expect(typedApi.admin.getDashboardStats).toBeDefined();
    });

    it('typedApi.manager has visit management', async () => {
        const { typedApi } = await import('@/shared/api/typedClient');
        expect(typedApi.manager.getVisits).toBeDefined();
        expect(typedApi.manager.createVisit).toBeDefined();
    });

    it('typedApi.invalidate cache function', async () => {
        const { typedApi } = await import('@/shared/api/typedClient');
        expect(typedApi.invalidate).toBeDefined();
        expect(typeof typedApi.invalidate).toBe('function');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// RBAC RequireRole Component
// ═══════════════════════════════════════════════════════════════════════════

describe('RequireRole', () => {
    it('exports RequireRole component', async () => {
        const mod: any = await import('@/shared/rbac/RequireRole');
        expect(mod.default || mod.RequireRole).toBeDefined();
    });
});
