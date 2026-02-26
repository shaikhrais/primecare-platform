import React from 'react';
import { BrowserRouter } from 'react-router-dom';
import { AppRouter } from './app/router';
import { SnackbarProvider } from 'notistack';
import FuseSettingsProvider from '@fuse/core/FuseSettings/FuseSettingsProvider';
import { AdapterDateFns } from '@mui/x-date-pickers/AdapterDateFns';
import { enUS } from 'date-fns/locale/en-US';
import { LocalizationProvider } from '@mui/x-date-pickers/LocalizationProvider';
import ErrorBoundary from '@fuse/utils/ErrorBoundary';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import MainThemeProvider from './contexts/MainThemeProvider';
import RootThemeProvider from './contexts/RootThemeProvider';
import { FuseDialogContextProvider } from '@fuse/core/FuseDialog/contexts/FuseDialogContext/FuseDialogContextProvider';
import { NavbarContextProvider } from './shared/theme-layouts/components/navbar/contexts/NavbarContext/NavbarContextProvider';
import { QuickPanelProvider } from './shared/theme-layouts/components/quickPanel/contexts/QuickPanelContext/QuickPanelContextProvider';
import { NavigationContextProvider } from './shared/theme-layouts/components/navigation/contexts/NavigationContextProvider';

const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      staleTime: 5 * 60 * 1000,
      retry: 1
    }
  }
});

function App() {
  return (
    <ErrorBoundary>
      <LocalizationProvider
        dateAdapter={AdapterDateFns}
        adapterLocale={enUS}
      >
        <QueryClientProvider client={queryClient}>
          <FuseSettingsProvider>
            <RootThemeProvider>
              <MainThemeProvider>
                <NavbarContextProvider>
                  <NavigationContextProvider>
                    <FuseDialogContextProvider>
                      <SnackbarProvider
                        maxSnack={5}
                        anchorOrigin={{
                          vertical: 'bottom',
                          horizontal: 'right'
                        }}
                      >
                        <QuickPanelProvider>
                          <BrowserRouter>
                            <AppRouter />
                          </BrowserRouter>
                        </QuickPanelProvider>
                      </SnackbarProvider>
                    </FuseDialogContextProvider>
                  </NavigationContextProvider>
                </NavbarContextProvider>
              </MainThemeProvider>
            </RootThemeProvider>
          </FuseSettingsProvider>
        </QueryClientProvider>
      </LocalizationProvider>
    </ErrorBoundary>
  );
}

export default App;

