import React from 'react';
import { Route, Routes } from 'react-router-dom';

// Layouts
import AdminLayout from '../../../shared/components/layout/AdminLayout';

// Pages
import Dashboard from './pages/dashboard';
import Schedule from './pages/schedule';
import Availability from './pages/availability';
import Earnings from './pages/earnings';
import Expenses from './pages/expenses';
import ShiftConfirmation from './pages/shift-confirmation';

/**
 * PSW Routes
 * Base path: /psw
 */
const PswRoutes: React.FC = () => {
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
                path="schedule"
                element={
                    <AdminLayout>
                        <Schedule />
                    </AdminLayout>
                }
            />
            <Route
                path="availability"
                element={
                    <AdminLayout>
                        <Availability />
                    </AdminLayout>
                }
            />
            <Route
                path="earnings"
                element={
                    <AdminLayout>
                        <Earnings />
                    </AdminLayout>
                }
            />
            <Route
                path="expenses"
                element={
                    <AdminLayout>
                        <Expenses />
                    </AdminLayout>
                }
            />
            <Route
                path="shift-confirmation"
                element={
                    <AdminLayout>
                        <ShiftConfirmation />
                    </AdminLayout>
                }
            />
        </Routes>
    );
};

export default PswRoutes;
