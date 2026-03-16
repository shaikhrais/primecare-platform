/**
 * AppProviders — Composite Provider Component
 *
 * Consolidates all application-level providers into a single wrapper to:
 *  1. Eliminate "provider hell" — now 5 providers deep (was 6)
 *  2. Enforce correct dependency ordering
 *  3. Provide a single source of truth for provider composition
 *
 * Dependency order (outermost → innermost):
 *  ErrorBoundary → QueryProvider → OfflineSyncProvider →
 *  NotificationCenterProvider → BrowserRouter → CommandPaletteWrapper
 *
 * NOTE: Toast notifications are now handled by Zustand's useUIStore
 * (via the useToast hook), so NotificationProvider has been removed.
 * NotificationCenterProvider remains for persistent server-side notifications.
 */
import React, { ReactNode } from 'react';
import { BrowserRouter } from 'react-router-dom';
import { ErrorBoundary } from '../components/ErrorBoundary';
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
    </ErrorBoundary>
);

export default AppProviders;
