import { useEffect } from 'react';
import { useLocation } from 'react-router-dom';
import { UsageTracker } from '@/shared/services/UsageTracker';

/**
 * Minimal route tracker hook — drop into any layout component.
 * Auto-tracks:
 *  - Every route navigation (via useLocation)
 *  - All click interactions (global listener)
 *  - All form submissions (global listener)
 *  - Scroll depth per route (global listener)
 *
 * Zero config, zero props. Just: useRouteTracker();
 */
export const useRouteTracker = () => {
    const location = useLocation();

    // Attach global listeners once
    useEffect(() => {
        UsageTracker.attachGlobalListeners();
    }, []);

    // Track route changes
    useEffect(() => {
        UsageTracker.trackRoute(location.pathname);
    }, [location.pathname]);
};
