/**
 * Zustand Store Tests
 * Tests useAuthStore and useUIStore behavior
 */
import { describe, it, expect, beforeEach } from 'vitest';
import { useAuthStore, useUIStore } from '@/shared/stores';

// Reset stores before each test
beforeEach(() => {
    useAuthStore.setState({ user: null, isAuthenticated: false, isLoading: true });
    useUIStore.setState({ theme: 'light', sidebarCollapsed: false, toasts: [], unreadCount: 0 });
});

// ── useAuthStore ──────────────────────────────────────────────────────────

describe('useAuthStore', () => {
    const mockUser = {
        id: 'user-1',
        email: 'admin@primecare.ca',
        name: 'Admin User',
        roles: ['admin', 'manager'],
        activeRole: 'admin',
        tenantId: 'tenant-1',
        tenantName: 'PrimeCare HQ',
    };

    it('starts with null user and unauthenticated', () => {
        const state = useAuthStore.getState();
        expect(state.user).toBeNull();
        expect(state.isAuthenticated).toBe(false);
        expect(state.isLoading).toBe(true);
    });

    it('setUser sets user and authenticates', () => {
        useAuthStore.getState().setUser(mockUser);
        const state = useAuthStore.getState();
        expect(state.user).toEqual(mockUser);
        expect(state.isAuthenticated).toBe(true);
        expect(state.isLoading).toBe(false);
    });

    it('switchRole changes active role', () => {
        useAuthStore.getState().setUser(mockUser);
        useAuthStore.getState().switchRole('manager');
        expect(useAuthStore.getState().user?.activeRole).toBe('manager');
    });

    it('switchRole does nothing when no user', () => {
        useAuthStore.getState().switchRole('manager');
        expect(useAuthStore.getState().user).toBeNull();
    });

    it('logout clears user and sets unauthenticated', () => {
        useAuthStore.getState().setUser(mockUser);
        useAuthStore.getState().logout();
        const state = useAuthStore.getState();
        expect(state.user).toBeNull();
        expect(state.isAuthenticated).toBe(false);
        expect(state.isLoading).toBe(false);
    });

    it('setLoading updates loading state', () => {
        useAuthStore.getState().setLoading(false);
        expect(useAuthStore.getState().isLoading).toBe(false);
        useAuthStore.getState().setLoading(true);
        expect(useAuthStore.getState().isLoading).toBe(true);
    });

    it('preserves other user fields when switching roles', () => {
        useAuthStore.getState().setUser(mockUser);
        useAuthStore.getState().switchRole('manager');
        const user = useAuthStore.getState().user!;
        expect(user.email).toBe('admin@primecare.ca');
        expect(user.tenantId).toBe('tenant-1');
        expect(user.roles).toEqual(['admin', 'manager']);
    });
});

// ── useUIStore ────────────────────────────────────────────────────────────

describe('useUIStore', () => {
    describe('Theme', () => {
        it('starts with light theme', () => {
            expect(useUIStore.getState().theme).toBe('light');
        });

        it('setTheme changes theme', () => {
            useUIStore.getState().setTheme('dark');
            expect(useUIStore.getState().theme).toBe('dark');
        });

        it('setTheme supports system mode', () => {
            useUIStore.getState().setTheme('system');
            expect(useUIStore.getState().theme).toBe('system');
        });

        it('toggleDarkMode switches between light and dark', () => {
            useUIStore.getState().toggleDarkMode();
            expect(useUIStore.getState().theme).toBe('dark');
            useUIStore.getState().toggleDarkMode();
            expect(useUIStore.getState().theme).toBe('light');
        });
    });

    describe('Sidebar', () => {
        it('starts expanded', () => {
            expect(useUIStore.getState().sidebarCollapsed).toBe(false);
        });

        it('toggleSidebar collapses/expands', () => {
            useUIStore.getState().toggleSidebar();
            expect(useUIStore.getState().sidebarCollapsed).toBe(true);
            useUIStore.getState().toggleSidebar();
            expect(useUIStore.getState().sidebarCollapsed).toBe(false);
        });

        it('setSidebarCollapsed sets directly', () => {
            useUIStore.getState().setSidebarCollapsed(true);
            expect(useUIStore.getState().sidebarCollapsed).toBe(true);
        });
    });

    describe('Toasts', () => {
        it('starts with empty toasts', () => {
            expect(useUIStore.getState().toasts).toEqual([]);
        });

        it('addToast adds a toast with auto-generated id', () => {
            useUIStore.getState().addToast({ type: 'success', title: 'Saved!', duration: 0 });
            const toasts = useUIStore.getState().toasts;
            expect(toasts).toHaveLength(1);
            expect(toasts[0].title).toBe('Saved!');
            expect(toasts[0].type).toBe('success');
            expect(toasts[0].id).toMatch(/^toast-/);
        });

        it('addToast supports all types', () => {
            const types = ['success', 'error', 'warning', 'info'] as const;
            types.forEach(type => {
                useUIStore.getState().addToast({ type, title: `${type} toast`, duration: 0 });
            });
            expect(useUIStore.getState().toasts).toHaveLength(4);
        });

        it('addToast includes optional message', () => {
            useUIStore.getState().addToast({ type: 'info', title: 'Update', message: 'Details here', duration: 0 });
            expect(useUIStore.getState().toasts[0].message).toBe('Details here');
        });

        it('removeToast removes specific toast', () => {
            useUIStore.getState().addToast({ type: 'success', title: 'Toast 1', duration: 0 });
            useUIStore.getState().addToast({ type: 'error', title: 'Toast 2', duration: 0 });
            const toasts = useUIStore.getState().toasts;
            useUIStore.getState().removeToast(toasts[0].id);
            expect(useUIStore.getState().toasts).toHaveLength(1);
            expect(useUIStore.getState().toasts[0].title).toBe('Toast 2');
        });

        it('clearToasts removes all toasts', () => {
            useUIStore.getState().addToast({ type: 'success', title: 'A', duration: 0 });
            useUIStore.getState().addToast({ type: 'error', title: 'B', duration: 0 });
            useUIStore.getState().clearToasts();
            expect(useUIStore.getState().toasts).toEqual([]);
        });
    });

    describe('Notifications', () => {
        it('starts with zero unread', () => {
            expect(useUIStore.getState().unreadCount).toBe(0);
        });

        it('setUnreadCount sets count', () => {
            useUIStore.getState().setUnreadCount(42);
            expect(useUIStore.getState().unreadCount).toBe(42);
        });

        it('incrementUnread increments by 1', () => {
            useUIStore.getState().setUnreadCount(5);
            useUIStore.getState().incrementUnread();
            expect(useUIStore.getState().unreadCount).toBe(6);
        });

        it('incrementUnread works from zero', () => {
            useUIStore.getState().incrementUnread();
            useUIStore.getState().incrementUnread();
            useUIStore.getState().incrementUnread();
            expect(useUIStore.getState().unreadCount).toBe(3);
        });
    });
});
