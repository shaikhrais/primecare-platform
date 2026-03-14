import React from 'react';
import { BrowserRouter } from 'react-router-dom';
import { AppRouter } from './app/router';
import { NotificationProvider } from '@/shared/context/NotificationContext';
import { NotificationCenterProvider } from '@/shared/context/NotificationCenterContext';
import CookieConsent from '@/shared/components/ui/CookieConsent';
import { CommandPaletteWrapper } from '@/shared/components/CommandPaletteWrapper';
import { ErrorBoundary } from '@/shared/components/ErrorBoundary';
import { NetworkStatusBanner } from '@/shared/components/ui/NetworkStatusBanner';
import { OfflineSyncProvider } from '@/shared/context/OfflineSyncContext';
import { QueryProvider } from '@/shared/context/QueryProvider';

function App() {
  return (
    <ErrorBoundary>
      <QueryProvider>
        <NotificationProvider>
          <OfflineSyncProvider>
            <NotificationCenterProvider>
              <NetworkStatusBanner />
              <CookieConsent />
              <BrowserRouter>
                <CommandPaletteWrapper>
                  <AppRouter />
                </CommandPaletteWrapper>
              </BrowserRouter>
            </NotificationCenterProvider>
          </OfflineSyncProvider>
        </NotificationProvider>
      </QueryProvider>
    </ErrorBoundary>
  );

}

export default App;
