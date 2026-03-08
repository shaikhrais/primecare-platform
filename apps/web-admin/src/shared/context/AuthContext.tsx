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
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const AuthProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
    const [user, setUser] = useState<User | null>(null);
    const [loading, setLoading] = useState(true);

    const refreshSession = async () => {
        try {
            const response = await apiClient.get('/v1/auth/whoami');

            if (response.ok) {
                const data = await response.json();
                const userData = data.user;
                // Preserve activeRole from localStorage if it exists, otherwise default
                const storedUser = localStorage.getItem('user');
                const activeRole = storedUser ? JSON.parse(storedUser).activeRole : userData.roles[0];

                const finalUser = { ...userData, activeRole };
                setUser(finalUser);
                localStorage.setItem('user', JSON.stringify(finalUser));
            } else if (response.status === 401) {
                // Only clear on explicit 401 (unauthorized) — NOT on 500 (cold start)
                setUser(null);
                localStorage.removeItem('user');
                localStorage.removeItem('token');
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
        const urlParams = new URLSearchParams(window.location.search);
        const urlToken = urlParams.get('token');

        if (urlToken) {
            console.log('Detected session token in URL, initializing...');
            localStorage.setItem('token', urlToken);
            // Clean up the URL without triggering a reload
            const newUrl = window.location.pathname;
            window.history.replaceState({}, '', newUrl);
        }

        refreshSession();
    }, []);

    const login = (userData: User, token?: string) => {
        setUser(userData);
        localStorage.setItem('user', JSON.stringify(userData));
        // We still accept token for legacy or immediate post-login redirection if needed,
        // but the backend has already set the HttpOnly cookie.
        if (token) {
            localStorage.setItem('token', token);
        }
    };

    const logout = async () => {
        try {
            await apiClient.post('/v1/auth/logout');
        } catch (e) {
            console.error('Logout failed', e);
        }
        setUser(null);
        localStorage.removeItem('user');
        localStorage.removeItem('token');
        window.location.href = RouteRegistry.LOGIN;
    };

    return (
        <AuthContext.Provider value={{ user, loading, login, logout, refreshSession }}>
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
