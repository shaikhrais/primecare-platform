import React from 'react';
import { Routes, Route, Navigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';

// Guards
import { RequireRole } from './guards/RequireRole';

// Layouts
import AdminLayout from '../shared/components/layout/AdminLayout';
import ManagerLayout from '../shared/components/layout/ManagerLayout';

// Shared/Auth Pages (to be moved eventually)
import RnRoutes from './routes/rn';
import ManagerRoutes from './routes/manager';
import PswRoutes from './routes/psw';
import ClientRoutes from './routes/client';
import AdminRoutes from './routes/admin';
import StaffRoutes from './routes/staff';
import AuthRoutes from './routes/auth';
import SharedRoutes from './routes/shared';

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

            {/* Manager Routes */}
            <Route
                path="/manager/*"
                element={
                    <RequireRole allowedRoles={['manager', 'admin']}>
                        <ManagerRoutes />
                    </RequireRole>
                }
            />

            {/* RN Routes */}
            <Route
                path="/rn/*"
                element={
                    <RequireRole allowedRoles={['rn', 'admin']}>
                        <RnRoutes />
                    </RequireRole>
                }
            />

            {/* PSW Routes */}
            <Route
                path="/psw/*"
                element={
                    <RequireRole allowedRoles={['psw', 'admin']}>
                        <PswRoutes />
                    </RequireRole>
                }
            />

            {/* Client Routes */}
            <Route
                path="/client/*"
                element={
                    <RequireRole allowedRoles={['client', 'admin']}>
                        <ClientRoutes />
                    </RequireRole>
                }
            />

            {/* Staff Routes */}
            <Route
                path="/staff/*"
                element={
                    <RequireRole allowedRoles={['staff', 'admin']}>
                        <StaffRoutes />
                    </RequireRole>
                }
            />

            {/* Shared Routes */}
            <Route path="/app/*" element={<SharedRoutes />} />

            {/* Legacy/Common Mappings */}
            <Route path="/profile" element={<Navigate to="/app/profile" replace />} />
            <Route path="/support" element={<Navigate to="/app/support" replace />} />
            <Route path="/messaging" element={<Navigate to="/app/messaging" replace />} />

            {/* Fallback */}
            <Route path="/" element={<Navigate to="/admin/dashboard" replace />} />
        </Routes>
    );
};

export default AppRouter;
