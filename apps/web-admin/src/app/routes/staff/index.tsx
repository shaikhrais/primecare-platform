import React from 'react';
import { Route, Routes } from 'react-router-dom';

// Layouts
import AdminLayout from '../../../components/layout/AdminLayout';

// Pages
// Staff uses some shared pages but with staff access
import Dashboard from '../admin/pages/dashboard';
import Customers from '../admin/pages/customers';

/**
 * Staff Routes
 * Base path: /staff
 */
const StaffRoutes: React.FC = () => {
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
                path="customers"
                element={
                    <AdminLayout>
                        <Customers />
                    </AdminLayout>
                }
            />
        </Routes>
    );
};

export default StaffRoutes;
