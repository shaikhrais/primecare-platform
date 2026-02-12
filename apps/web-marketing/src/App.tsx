import React, { Suspense } from 'react';
import { HelmetProvider } from 'react-helmet-async';
import { useRoutes } from 'react-router-dom';
import { routes } from './routes';
import ScrollToTop from './components/layout/ScrollToTop';
import CookieConsent from './components/layout/CookieConsent';

function App() {
    const element = useRoutes(routes);
    return (
        <HelmetProvider>
            <ScrollToTop />
            <CookieConsent />
            <Suspense fallback={<div>Loading...</div>}>
                {element}
            </Suspense>
        </HelmetProvider>
    );
}

export default App;
