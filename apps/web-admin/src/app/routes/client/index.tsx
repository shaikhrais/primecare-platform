import React from 'react';
import { Route, Routes } from 'react-router-dom';

// Layouts
import AdminLayout from '../../../shared/components/layout/AdminLayout';

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
const ClientRoutes: React.FC = () => {
    return (
        <Routes>
            <Route path="dashboard" element={<Dashboard />} />
            <Route path="bookings" element={<Bookings />} />
            <Route path="billing" element={<Billing />} />
            <Route path="feedback" element={<Feedback />} />
            <Route path="request-booking" element={<RequestBooking />} />
        </Routes>
    );
};

export default ClientRoutes;
