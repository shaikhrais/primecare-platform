import React from 'react';
import { Route, Routes } from 'react-router-dom';

// Layouts
import AdminLayout from '../../shared/components/layout/AdminLayout';

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
            <Route
                path="dashboard"
                element={
                    <AdminLayout>
                        <Dashboard />
                    </AdminLayout>
                }
            />
            <Route
                path="bookings"
                element={
                    <AdminLayout>
                        <Bookings />
                    </AdminLayout>
                }
            />
            <Route
                path="billing"
                element={
                    <AdminLayout>
                        <Billing />
                    </AdminLayout>
                }
            />
            <Route
                path="feedback"
                element={
                    <AdminLayout>
                        <Feedback />
                    </AdminLayout>
                }
            />
            <Route
                path="request-booking"
                element={
                    <AdminLayout>
                        <RequestBooking />
                    </AdminLayout>
                }
            />
        </Routes>
    );
};

export default ClientRoutes;
