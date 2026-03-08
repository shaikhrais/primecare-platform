import React, { createContext, useContext, useState, useEffect } from 'react';
import { apiClient } from '@/shared/utils/apiClient';
import { useAuth } from '@/shared/context/AuthContext';

interface BrandingConfig {
    primaryColor: string;
    accentColor: string;
    logoUrl?: string;
    name?: string;
    tagline?: string;
    isPlatform?: boolean;
    needsSetup?: boolean;
}

const DEFAULT_PRIMECARE_BRAND: BrandingConfig = {
    primaryColor: '#0F172A',
    accentColor: '#3B82F6',
    logoUrl: '/primecare-logo-white.svg',
    name: 'PrimeCare',
    tagline: 'Compassionate Home Healthcare',
    isPlatform: true,
    needsSetup: true,
};

const CORPORATE_BRANDING: BrandingConfig = {
    primaryColor: '#0F172A', // Slate 900
    accentColor: '#3B82F6',  // Blue 500
    logoUrl: '/primecare-logo-white.svg',
    name: 'PrimeCare Corporate',
    isPlatform: true
};

interface ThemeContextType {
    branding: BrandingConfig | null;
    loading: boolean;
}

const ThemeContext = createContext<ThemeContextType | undefined>(undefined);

export const ThemeProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
    const { user } = useAuth();
    const [branding, setBranding] = useState<BrandingConfig | null>(null);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchBranding = async () => {
            // Priority 1: If user is super_admin, use Corporate Branding
            if (user?.roles?.includes('super_admin')) {
                setBranding(CORPORATE_BRANDING);
                setLoading(false);
                return;
            }

            try {
                const pathParts = window.location.pathname.split('/');
                const slugFromPath = pathParts[1] && pathParts[1] !== 'login' ? pathParts[1] : null;
                const hostParts = window.location.hostname.split('.');
                const slugFromHost = hostParts.length > 2 ? hostParts[0] : null;
                const querySlug = slugFromHost || slugFromPath;

                if (querySlug) {
                    const response = await apiClient.get(`/v1/public/branding?slug=${querySlug}`);
                    if (response.ok) {
                        const data = await response.json();
                        if (data.brandingConfig) {
                            setBranding({
                                ...data.brandingConfig,
                                needsSetup: data._needsSetup || false,
                            });
                        } else {
                            setBranding(DEFAULT_PRIMECARE_BRAND);
                        }
                    } else {
                        // API error — use default PrimeCare brand, retry in background
                        setBranding(DEFAULT_PRIMECARE_BRAND);
                        setTimeout(async () => {
                            try {
                                const retry = await apiClient.get(`/v1/public/branding?slug=${querySlug}`);
                                if (retry.ok) {
                                    const data = await retry.json();
                                    if (data.brandingConfig) {
                                        setBranding({ ...data.brandingConfig, needsSetup: data._needsSetup || false });
                                    }
                                }
                            } catch { /* silent retry */ }
                        }, 2000);
                    }
                } else {
                    // No slug — use default PrimeCare brand
                    setBranding(DEFAULT_PRIMECARE_BRAND);
                }
            } catch (error) {
                console.error('Failed to fetch branding', error);
                setBranding(DEFAULT_PRIMECARE_BRAND);
            } finally {
                setLoading(false);
            }
        };

        fetchBranding();
    }, [user, window.location.pathname]);

    useEffect(() => {
        if (branding) {
            document.documentElement.style.setProperty('--pc-brand-primary', branding.primaryColor);
            document.documentElement.style.setProperty('--pc-brand-accent', branding.accentColor);
        } else {
            document.documentElement.style.setProperty('--pc-brand-primary', '#2563EB');
            document.documentElement.style.setProperty('--pc-brand-accent', '#10B981');
        }
    }, [branding]);

    return (
        <ThemeContext.Provider value={{ branding, loading }}>
            {children}
        </ThemeContext.Provider>
    );
};

export const useTheme = () => {
    const context = useContext(ThemeContext);
    if (context === undefined) {
        throw new Error('useTheme must be used within a ThemeProvider');
    }
    return context;
};
