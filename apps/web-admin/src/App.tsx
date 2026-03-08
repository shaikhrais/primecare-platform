import React from 'react';
import { BrowserRouter } from 'react-router-dom';
import { AppRouter } from './app/router';
import { NotificationProvider } from '@/shared/context/NotificationContext';
import CookieConsent from '@/shared/components/ui/CookieConsent';
import { CommandPaletteWrapper } from '@/shared/components/CommandPaletteWrapper';
import { ErrorBoundary } from '@/shared/components/ErrorBoundary';

function App() {
  return (
    <ErrorBoundary>
      <NotificationProvider>
        <CookieConsent />
        <BrowserRouter>
          <CommandPaletteWrapper>
            <AppRouter />
          </CommandPaletteWrapper>
        </BrowserRouter>
      </NotificationProvider>
    </ErrorBoundary>
  );

}

export default App;
