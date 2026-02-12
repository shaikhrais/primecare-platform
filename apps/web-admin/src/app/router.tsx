import React from 'react';
import { Routes, Route, Navigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';

// Guards
import RequireRole from '@/shared/rbac/RequireRole';

// Route Groups
import AuthRoutes from './routes/auth';
import AdminRoutes from './routes/admin';

const { RouteRegistry } = AdminRegistry;

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

            {/* Role Specific Routes */}
            <Route
                path="/rn/*"
                element={
                    <RequireRole allowedRoles={['rn']}>
                        <AdminRoutes />
                    </RequireRole>
                }
            />

            <Route
                path="/psw/*"
                element={
                    <RequireRole allowedRoles={['psw']}>
                        <AdminRoutes />
                    </RequireRole>
                }
            />

            <Route
                path="/staff/*"
                element={
                    <RequireRole allowedRoles={['staff']}>
                        <AdminRoutes />
                    </RequireRole>
                }
            />

            <Route
                path="/client/*"
                element={
                    <RequireRole allowedRoles={['client']}>
                        <AdminRoutes />
                    </RequireRole>
                }
            />

            {/* Shared Dashboard redirect */}
            <Route path="/dashboard" element={<Navigate to="/app" replace />} />
            <Route path="/app/*" element={<AdminRoutes />} />

            {/* Fallback */}
            <Route path="/" element={<Navigate to={RouteRegistry.DASHBOARD} replace />} />
            <Route path="*" element={<Navigate to="/" replace />} />
        </Routes>
    );
};
