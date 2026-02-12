import React from 'react';
import { Route, Routes } from 'react-router-dom';

// Layouts
import AdminLayout from '@/shared/components/layout/AdminLayout';

// Pages
import Dashboard from './pages/dashboard';
import Users from './pages/dashboard-2';
// ...

const AdminRoutes: React.FC = () => {
    return (
        <Routes>
            <Route path="users" element={<AdminLayout><Users /></AdminLayout>} />
        </Routes>
    );
};

export default AdminRoutes;
