/**
 * Context & Provider Module Exports — Structure Tests
 *
 * Tests all shared/context modules for proper named exports
 * without rendering (avoids React 19 + renderHook issue).
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// AuthContext
// ═══════════════════════════════════════════════════════════════════════════

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

// ═══════════════════════════════════════════════════════════════════════════
// CommandPaletteContext
// ═══════════════════════════════════════════════════════════════════════════

describe('CommandPaletteContext', () => {
    it('exports CommandPaletteProvider', async () => {
        const mod: any = await import('@/shared/context/CommandPaletteContext');
        expect(mod.CommandPaletteProvider).toBeDefined();
    });

    it('exports useCommandPalette hook', async () => {
        const mod: any = await import('@/shared/context/CommandPaletteContext');
        expect(mod.useCommandPalette).toBeDefined();
        expect(typeof mod.useCommandPalette).toBe('function');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// useToast Hook (replaced NotificationContext)
// ═══════════════════════════════════════════════════════════════════════════

describe('useToast Hook', () => {
    it('exports useToast', async () => {
        const mod: any = await import('@/shared/hooks/useToast');
        expect(mod.useToast).toBeDefined();
        expect(typeof mod.useToast).toBe('function');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// OfflineSyncContext
// ═══════════════════════════════════════════════════════════════════════════

describe('OfflineSyncContext', () => {
    it('exports OfflineSyncProvider', async () => {
        const mod: any = await import('@/shared/context/OfflineSyncContext');
        expect(mod.OfflineSyncProvider).toBeDefined();
    });

    it('exports useOfflineSync hook', async () => {
        const mod: any = await import('@/shared/context/OfflineSyncContext');
        expect(mod.useOfflineSync).toBeDefined();
        expect(typeof mod.useOfflineSync).toBe('function');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// ThemeContext
// ═══════════════════════════════════════════════════════════════════════════

describe('ThemeContext', () => {
    it('exports ThemeProvider', async () => {
        const mod: any = await import('@/shared/context/ThemeContext');
        expect(mod.ThemeProvider).toBeDefined();
    });

    it('exports useTheme hook', async () => {
        const mod: any = await import('@/shared/context/ThemeContext');
        expect(mod.useTheme).toBeDefined();
        expect(typeof mod.useTheme).toBe('function');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// QueryProvider
// ═══════════════════════════════════════════════════════════════════════════

describe('QueryProvider', () => {
    it('exports QueryProvider component', async () => {
        const mod: any = await import('@/shared/context/QueryProvider');
        expect(mod.QueryProvider).toBeDefined();
    });

    it('exports queryClient', async () => {
        const mod: any = await import('@/shared/context/QueryProvider');
        expect(mod.queryClient).toBeDefined();
    });

    it('queryClient has defaultOptions', async () => {
        const mod: any = await import('@/shared/context/QueryProvider');
        const qc = mod.queryClient;
        expect(qc.getDefaultOptions()).toBeDefined();
    });

    it('has default export (QueryProvider)', async () => {
        const mod: any = await import('@/shared/context/QueryProvider');
        expect(mod.default).toBeDefined();
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// NotificationCenterContext
// ═══════════════════════════════════════════════════════════════════════════

describe('NotificationCenterContext (exports)', () => {
    it('exports NotificationCenterProvider', async () => {
        const mod: any = await import('@/shared/context/NotificationCenterContext');
        expect(mod.NotificationCenterProvider).toBeDefined();
    });

    it('exports useNotificationCenter hook', async () => {
        const mod: any = await import('@/shared/context/NotificationCenterContext');
        expect(mod.useNotificationCenter).toBeDefined();
        expect(typeof mod.useNotificationCenter).toBe('function');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Hooks Module Exports (static imports for untested hooks)
// ═══════════════════════════════════════════════════════════════════════════

describe('Hook Exports', () => {
    it('useAutoSaveForm exports', async () => {
        const mod: any = await import('@/shared/hooks/useAutoSaveForm');
        const exp = mod.useAutoSaveForm || mod.default;
        expect(exp).toBeDefined();
    });

    it('useDialog exports', async () => {
        const mod: any = await import('@/shared/hooks/useDialog');
        const exp = mod.useDialog || mod.default;
        expect(exp).toBeDefined();
    });

    it('useFormValidation exports', async () => {
        const mod: any = await import('@/shared/hooks/useFormValidation');
        const exp = mod.useFormValidation || mod.default;
        expect(exp).toBeDefined();
    });

    it('useMediaQuery exports', async () => {
        const mod: any = await import('@/shared/hooks/useMediaQuery');
        const exp = mod.useMediaQuery || mod.default;
        expect(exp).toBeDefined();
    });

    it('useRealtimeQuery exports', async () => {
        const mod: any = await import('@/shared/hooks/useRealtimeQuery');
        const exp = mod.useRealtimeQuery || mod.default;
        expect(exp).toBeDefined();
    });

    it('useRegistryQuery exports', async () => {
        const mod: any = await import('@/shared/hooks/useRegistryQuery');
        const exp = mod.useRegistryQuery || mod.default;
        expect(exp).toBeDefined();
    });

    it('useRouteTracker exports', async () => {
        const mod: any = await import('@/shared/hooks/useRouteTracker');
        const exp = mod.useRouteTracker || mod.default;
        expect(exp).toBeDefined();
    });

    it('useApiQuery exports', async () => {
        const mod: any = await import('@/shared/hooks/useApiQuery');
        const exp = mod.useApiQuery || mod.default;
        expect(exp).toBeDefined();
    });

    it('useForm exports', async () => {
        const mod: any = await import('@/shared/hooks/useForm');
        const exp = mod.useForm || mod.default;
        expect(exp).toBeDefined();
    });

    it('useWebVitals exports', async () => {
        const mod: any = await import('@/shared/hooks/useWebVitals');
        const exp = mod.useWebVitals || mod.default;
        expect(exp).toBeDefined();
    });

    it('useRealtimeSync exports', async () => {
        const mod: any = await import('@/shared/hooks/useRealtimeSync');
        const exp = mod.useRealtimeSync || mod.default;
        expect(exp).toBeDefined();
    });
});
