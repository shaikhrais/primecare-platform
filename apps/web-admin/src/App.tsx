import React from 'react';
import { BrowserRouter } from 'react-router-dom';
import { AppRouter } from './app/router';
import { NotificationProvider } from '@/shared/context/NotificationContext';
import CookieConsent from '@/shared/components/ui/CookieConsent';
import { CommandPaletteWrapper } from '@/shared/components/CommandPaletteWrapper';
import { ErrorBoundary } from '@/shared/components/ErrorBoundary';
import { NetworkStatusBanner } from '@/shared/components/ui/NetworkStatusBanner';
import { OfflineSyncProvider } from '@/shared/context/OfflineSyncContext';

function App() {
  return (
    <ErrorBoundary>
      <OfflineSyncProvider>
        <NotificationProvider>
          <NetworkStatusBanner />
          <CookieConsent />
          <BrowserRouter>
            <CommandPaletteWrapper>
              <AppRouter />
            </CommandPaletteWrapper>
          </BrowserRouter>
        </NotificationProvider>
      </OfflineSyncProvider>
    </ErrorBoundary>
  );

}

export default App;
