/**
 * AppProviders — Composite Provider Component
 *
 * Consolidates ALL application-level providers into a single wrapper to:
 *  1. Eliminate "provider hell" — single source of truth for composition
 *  2. Enforce correct dependency ordering
 *  3. Keep main.tsx and App.tsx clean
 *
 * Dependency order (outermost → innermost):
 *  ErrorBoundary → AuthProvider → ThemeProvider → QueryProvider →
 *  OfflineSyncProvider → NotificationCenterProvider →
 *  BrowserRouter → CommandPaletteWrapper
 *
 * AuthProvider is outermost because ThemeProvider uses useAuth()
 * (super_admin gets corporate branding, tenant slug drives theme fetch).
 *
 * NOTE: Toast notifications are now handled by Zustand's useUIStore
 * (via the useToast hook), so NotificationProvider has been removed.
 * NotificationCenterProvider remains for persistent server-side notifications.
 */
import React, { ReactNode } from 'react';
import { BrowserRouter } from 'react-router';
import { ErrorBoundary } from '../components/ErrorBoundary';
import { AuthProvider } from './AuthContext';
import { ThemeProvider } from './ThemeContext';
import { QueryProvider } from './QueryProvider';
import { OfflineSyncProvider } from './OfflineSyncContext';
import { NotificationCenterProvider } from './NotificationCenterContext';
import { CommandPaletteWrapper } from '../components/CommandPaletteWrapper';
import { NetworkStatusBanner } from '../components/ui/NetworkStatusBanner';
import CookieConsent from '../components/ui/CookieConsent';

interface AppProvidersProps {
    children: ReactNode;
}

export const AppProviders: React.FC<AppProvidersProps> = ({ children }) => (
    <ErrorBoundary>
        <AuthProvider>
            <ThemeProvider>
                <QueryProvider>
                    <OfflineSyncProvider>
                        <NotificationCenterProvider>
                            <NetworkStatusBanner />
                            <CookieConsent />
                            <BrowserRouter>
                                <CommandPaletteWrapper>
                                    {children}
                                </CommandPaletteWrapper>
                            </BrowserRouter>
                        </NotificationCenterProvider>
                    </OfflineSyncProvider>
                </QueryProvider>
            </ThemeProvider>
        </AuthProvider>
    </ErrorBoundary>
);

export default AppProviders;
