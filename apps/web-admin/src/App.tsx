import React from 'react';
import { BrowserRouter } from 'react-router-dom';
import { AppRouter } from './app/router';
import { NotificationProvider } from '@/shared/context/NotificationContext';
import CookieConsent from '@/shared/components/ui/CookieConsent';

function App() {
  return (
    <NotificationProvider>
      <CookieConsent />
      <BrowserRouter>
        <AppRouter />
      </BrowserRouter>
    </NotificationProvider>
  );
}

export default App;
