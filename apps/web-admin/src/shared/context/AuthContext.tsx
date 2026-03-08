import React, { createContext, useContext, useState, useEffect } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';

const { RouteRegistry } = AdminRegistry;

interface User {
    id: string;
    email: string;
    roles: string[];
    activeRole: string;
    tenantId: string;
}

interface AuthContextType {
    user: User | null;
    loading: boolean;
    login: (user: User, token: string) => void;
    logout: () => void;
    refreshSession: () => Promise<void>;
    isOnline: boolean;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const AuthProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
    const [user, setUser] = useState<User | null>(null);
    const [loading, setLoading] = useState(true);
    const [isOnline, setIsOnline] = useState(navigator.onLine);

    // #7: Track online/offline status for graceful degradation
    useEffect(() => {
        const handleOnline = () => setIsOnline(true);
        const handleOffline = () => setIsOnline(false);
        window.addEventListener('online', handleOnline);
        window.addEventListener('offline', handleOffline);
        return () => {
            window.removeEventListener('online', handleOnline);
            window.removeEventListener('offline', handleOffline);
        };
    }, []);

    const refreshSession = async () => {
        try {
            const response = await apiClient.get('/v1/auth/whoami');

            if (response.ok) {
                const data = await response.json();
                const userData = data.user;
                // Preserve activeRole from localStorage if it exists
                const storedUser = localStorage.getItem('user');
                const activeRole = storedUser ? JSON.parse(storedUser).activeRole : userData.roles[0];

                const finalUser = { ...userData, activeRole };
                setUser(finalUser);
                // #5: Only store minimal UI state — NOT tokens
                localStorage.setItem('user', JSON.stringify({
                    id: finalUser.id,
                    email: finalUser.email,
                    roles: finalUser.roles,
                    activeRole: finalUser.activeRole,
                    tenantId: finalUser.tenantId,
                }));
            } else if (response.status === 401) {
                setUser(null);
                localStorage.removeItem('user');
            } else {
                // Server error (500 cold start) — use cached user, no retry
                const cachedUser = localStorage.getItem('user');
                if (cachedUser) {
                    setUser(JSON.parse(cachedUser));
                }
            }
        } catch (error) {
            // Network error — use cached user
            const cachedUser = localStorage.getItem('user');
            if (cachedUser) {
                setUser(JSON.parse(cachedUser));
            }
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        // #2: REMOVED URL token handling — tokens in URLs are a security risk
        // Auth is handled via HttpOnly cookies set by the backend
        refreshSession();
    }, []);

    const login = (userData: User, token?: string) => {
        setUser(userData);
        // #5: Store only safe UI fields
        localStorage.setItem('user', JSON.stringify({
            id: userData.id,
            email: userData.email,
            roles: userData.roles,
            activeRole: userData.activeRole,
            tenantId: userData.tenantId,
        }));
        // R12: Token is handled by HttpOnly cookies — no localStorage storage
        // if (token) localStorage.setItem('token', token); // REMOVED
    };

    const logout = async () => {
        try {
            await apiClient.post('/v1/auth/logout');
        } catch (e) {
            // Silent — logout should always complete client-side
        }
        setUser(null);
        localStorage.removeItem('user');
        window.location.href = RouteRegistry.LOGIN;
    };

    return (
        <AuthContext.Provider value={{ user, loading, login, logout, refreshSession, isOnline }}>
            {children}
        </AuthContext.Provider>
    );
};

export const useAuth = () => {
    const context = useContext(AuthContext);
    if (context === undefined) {
        throw new Error('useAuth must be used within an AuthProvider');
    }
    return context;
};
