import React from 'react';
import { Route, Routes } from 'react-router-dom';

// Pages
import Dashboard from './pages/dashboard';
import Bookings from './pages/bookings';
import Billing from './pages/billing';
import Feedback from './pages/feedback';
import RequestBooking from './pages/request-booking';

/**
 * Client Routes
 * Base path: /client
 */
// Layouts
import ClientLayout from '../../../shared/components/layout/ClientLayout';
import { NotificationCenterProvider } from '@/shared/context/NotificationCenterContext';
import { CommandPaletteWrapper } from '@/shared/components/CommandPaletteWrapper';

/**
 * Client Routes
 * Base path: /client
 */
const ClientRoutes: React.FC = () => {
    return (
        <CommandPaletteWrapper>
            <Routes>
                <Route element={<ClientLayout />}>
                    <Route path="dashboard" element={<Dashboard />} />
                    <Route path="bookings" element={<Bookings />} />
                    <Route path="billing" element={<Billing />} />
                    <Route path="feedback" element={<Feedback />} />
                    <Route path="request-booking" element={<RequestBooking />} />
                </Route>
            </Routes>
        </CommandPaletteWrapper>
    );
};

export default ClientRoutes;
