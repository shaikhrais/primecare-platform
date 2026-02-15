import React from 'react';
import { BrowserRouter } from 'react-router-dom';
import { AppRouter } from './app/router';
import { NotificationProvider } from '@/shared/context/NotificationContext';
import CookieConsent from '@/shared/components/ui/CookieConsent';
import { CommandPaletteWrapper } from '@/shared/components/CommandPaletteWrapper';

function App() {
  return (
    <NotificationProvider>
      <CookieConsent />
      <BrowserRouter>
        <CommandPaletteWrapper>
          <AppRouter />
        </CommandPaletteWrapper>
      </BrowserRouter>
    </NotificationProvider>
  );

}

export default App;
