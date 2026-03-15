/**
 * Global Zustand Stores — Replace localStorage prop-drilling
 *
 * Stores:
 *   useAuthStore  — User, role, tenant, permissions
 *   useUIStore    — Theme, sidebar, toasts, notifications
 *
 * Usage:
 *   const { user, activeRole } = useAuthStore();
 *   const { theme, toggleDarkMode, addToast } = useUIStore();
 */
import { create } from 'zustand';
import { persist, devtools } from 'zustand/middleware';

// ── Auth Store ────────────────────────────────────────────────────────────

interface AuthUser {
    id: string;
    email: string;
    name: string;
    roles: string[];
    activeRole: string;
    tenantId: string;
    tenantName?: string;
    avatarUrl?: string;
}

interface AuthState {
    user: AuthUser | null;
    isAuthenticated: boolean;
    isLoading: boolean;

    // Actions
    setUser: (user: AuthUser) => void;
    switchRole: (role: string) => void;
    logout: () => void;
    setLoading: (loading: boolean) => void;
}

export const useAuthStore = create<AuthState>()(
    devtools(
        persist(
            (set) => ({
                user: null,
                isAuthenticated: false,
                isLoading: true,

                setUser: (user) => set({
                    user,
                    isAuthenticated: true,
                    isLoading: false,
                }, false, 'setUser'),

                switchRole: (role) => set((state) => ({
                    user: state.user ? { ...state.user, activeRole: role } : null,
                }), false, 'switchRole'),

                logout: () => {
                    localStorage.removeItem('user'); // Clear legacy storage
                    set({ user: null, isAuthenticated: false, isLoading: false }, false, 'logout');
                },

                setLoading: (loading) => set({ isLoading: loading }, false, 'setLoading'),
            }),
            {
                name: 'primecare-auth',
                // Only persist user data, not loading state
                partialize: (state) => ({ user: state.user, isAuthenticated: state.isAuthenticated }),
            }
        ),
        { name: 'AuthStore' }
    )
);

// ── UI Store ──────────────────────────────────────────────────────────────

type ThemeMode = 'light' | 'dark' | 'system';

interface Toast {
    id: string;
    type: 'success' | 'error' | 'warning' | 'info';
    title: string;
    message?: string;
    duration?: number;
}

interface UIState {
    // Theme
    theme: ThemeMode;
    setTheme: (theme: ThemeMode) => void;
    toggleDarkMode: () => void;

    // Sidebar
    sidebarCollapsed: boolean;
    toggleSidebar: () => void;
    setSidebarCollapsed: (collapsed: boolean) => void;

    // Toasts
    toasts: Toast[];
    addToast: (toast: Omit<Toast, 'id'>) => void;
    removeToast: (id: string) => void;
    clearToasts: () => void;

    // Notifications
    unreadCount: number;
    setUnreadCount: (count: number) => void;
    incrementUnread: () => void;
}

let toastCounter = 0;

export const useUIStore = create<UIState>()(
    devtools(
        persist(
            (set) => ({
                // Theme
                theme: 'light' as ThemeMode,
                setTheme: (theme) => set({ theme }, false, 'setTheme'),
                toggleDarkMode: () => set((state) => ({
                    theme: state.theme === 'dark' ? 'light' : 'dark',
                }), false, 'toggleDarkMode'),

                // Sidebar
                sidebarCollapsed: false,
                toggleSidebar: () => set((s) => ({ sidebarCollapsed: !s.sidebarCollapsed }), false, 'toggleSidebar'),
                setSidebarCollapsed: (collapsed) => set({ sidebarCollapsed: collapsed }, false, 'setSidebarCollapsed'),

                // Toasts (not persisted)
                toasts: [],
                addToast: (toast) => {
                    const id = `toast-${++toastCounter}`;
                    set((s) => ({
                        toasts: [...s.toasts, { ...toast, id }],
                    }), false, 'addToast');
                    // Auto-remove after duration
                    const duration = toast.duration ?? 5000;
                    if (duration > 0) {
                        setTimeout(() => {
                            set((s) => ({
                                toasts: s.toasts.filter((t) => t.id !== id),
                            }), false, 'autoRemoveToast');
                        }, duration);
                    }
                },
                removeToast: (id) => set((s) => ({
                    toasts: s.toasts.filter((t) => t.id !== id),
                }), false, 'removeToast'),
                clearToasts: () => set({ toasts: [] }, false, 'clearToasts'),

                // Notifications
                unreadCount: 0,
                setUnreadCount: (count) => set({ unreadCount: count }, false, 'setUnreadCount'),
                incrementUnread: () => set((s) => ({ unreadCount: s.unreadCount + 1 }), false, 'incrementUnread'),
            }),
            {
                name: 'primecare-ui',
                // Only persist theme and sidebar, not toasts
                partialize: (state) => ({ theme: state.theme, sidebarCollapsed: state.sidebarCollapsed }),
            }
        ),
        { name: 'UIStore' }
    )
);

// ── Convenience Selectors ─────────────────────────────────────────────────

/** Get current user's tenant ID (null-safe) */
export const useTenantId = () => useAuthStore((s) => s.user?.tenantId);
/** Get current active role */
export const useActiveRole = () => useAuthStore((s) => s.user?.activeRole);
/** Check if dark mode is active */
export const useIsDarkMode = () => useUIStore((s) => s.theme === 'dark' || (s.theme === 'system' && window.matchMedia('(prefers-color-scheme: dark)').matches));
