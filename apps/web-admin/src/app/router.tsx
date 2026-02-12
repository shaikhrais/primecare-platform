import React from 'react';
import { Routes, Route, Navigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';

// Guards
import { RequireRole } from './guards/RequireRole';

// Layouts
import AdminLayout from '../shared/components/layout/AdminLayout';
import ManagerLayout from '../shared/components/layout/ManagerLayout';

// Shared/Auth Pages (to be moved eventually)
// import RnRoutes from './routes/rn';
// import ManagerRoutes from './routes/manager';
// import PswRoutes from './routes/psw';
// import ClientRoutes from './routes/client';
import AdminRoutes from './routes/admin';
// import StaffRoutes from './routes/staff';
import AuthRoutes from './routes/auth';
// import SharedRoutes from './routes/shared';

const { RouteRegistry } = AdminRegistry;

/**
 * Main Application Router
 * This is the entry point for all role-based routing.
 */
export const AppRouter: React.FC = () => {
    return (
        <Routes>
            {/* Auth Routes */}
            <Route path="/auth/*" element={<AuthRoutes />} />
            <Route path={RouteRegistry.LOGIN} element={<Navigate to="/auth/login" replace />} />
            <Route path={RouteRegistry.REGISTER} element={<Navigate to="/auth/register" replace />} />

            {/* Admin Routes */}
            <Route
                path="/admin/*"
                element={
                    <RequireRole allowedRoles={['admin']}>
                        <AdminRoutes />
                    </RequireRole>
                }
            />
            <Route path="/" element={<div>Root</div>} />
        </Routes>
    );
};

export default AppRouter;
