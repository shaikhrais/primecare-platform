import React from 'react';
import { AppRouter } from './app/router';
import { AppProviders } from '@/shared/context/AppProviders';

function App() {
  return (
    <AppProviders>
      <AppRouter />
    </AppProviders>
  );

}

export default App;
