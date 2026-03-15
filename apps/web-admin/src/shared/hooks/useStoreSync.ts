/**
 * useStoreSync — Bridge between AuthContext and Zustand stores
 *
 * Listens to AuthContext changes and syncs them to useAuthStore,
 * enabling gradual migration from Context API → Zustand.
 * Mount once at the AppLayout level.
 */
import { useEffect } from 'react';
import { useAuth } from '@/shared/context/AuthContext';
import { useAuthStore, useUIStore } from '@/shared/stores';

export function useStoreSync() {
    const { user, loading, isOnline } = useAuth();

    useEffect(() => {
        if (loading) {
            useAuthStore.getState().setLoading(true);
            return;
        }

        if (user) {
            useAuthStore.getState().setUser({
                id: user.id,
                email: user.email,
                name: (user as any).name || user.email.split('@')[0],
                roles: user.roles,
                activeRole: user.activeRole,
                tenantId: user.tenantId,
                tenantName: (user as any).tenantName,
                avatarUrl: (user as any).avatarUrl,
            });
        } else {
            useAuthStore.getState().logout();
        }
    }, [user, loading]);

    // Sync dark mode class to document
    const theme = useUIStore((s) => s.theme);
    useEffect(() => {
        const isDark = theme === 'dark' || (theme === 'system' && window.matchMedia('(prefers-color-scheme: dark)').matches);
        document.documentElement.setAttribute('data-theme', isDark ? 'dark' : 'light');
    }, [theme]);
}
