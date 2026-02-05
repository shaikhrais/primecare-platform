import React, { createContext, useState, useEffect, useContext } from 'react';
import AsyncStorage from '@react-native-async-storage/async-storage';

// Live Cloudflare API
export const API_URL = 'https://primecare-api.itpro-mohammed.workers.dev';

interface AuthContextType {
    token: string | null;
    user: any | null;
    isLoading: boolean;
    login: (token: string, user: any) => Promise<void>;
    logout: () => Promise<void>;
}

const AuthContext = createContext<AuthContextType>({
    token: null,
    user: null,
    isLoading: true,
    login: async () => { },
    logout: async () => { },
});

export const AuthProvider = ({ children }: { children: React.ReactNode }) => {
    const [token, setToken] = useState<string | null>(null);
    const [user, setUser] = useState<any | null>(null);
    const [isLoading, setIsLoading] = useState(true);

    useEffect(() => {
        loadStorageData();
    }, []);

    const loadStorageData = async () => {
        try {
            const storedToken = await AsyncStorage.getItem('token');
            const storedUser = await AsyncStorage.getItem('user');

            if (storedToken) {
                setToken(storedToken);
                if (storedUser) setUser(JSON.parse(storedUser));
            }
        } catch (e) {
            console.error('Failed to load auth data', e);
        } finally {
            setIsLoading(false);
        }
    };

    const login = async (newToken: string, newUser: any) => {
        try {
            setToken(newToken);
            setUser(newUser);
            await AsyncStorage.setItem('token', newToken);
            await AsyncStorage.setItem('user', JSON.stringify(newUser));
        } catch (e) {
            console.error('Login error', e);
        }
    };

    const logout = async () => {
        try {
            setToken(null);
            setUser(null);
            await AsyncStorage.removeItem('token');
            await AsyncStorage.removeItem('user');
        } catch (e) {
            console.error('Logout error', e);
        }
    };

    return (
        <AuthContext.Provider value={{ token, user, isLoading, login, logout }}>
            {children}
        </AuthContext.Provider>
    );
};

export const useAuth = () => useContext(AuthContext);
