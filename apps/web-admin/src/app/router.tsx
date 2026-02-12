import React from 'react';
import { Routes, Route, Navigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';

// Guards
import RequireRole from '@/shared/rbac/RequireRole';

// Route Groups
import AuthRoutes from './routes/auth';
import AdminRoutes from './routes/admin';
import PswRoutes from './routes/psw';
import ClientRoutes from './routes/client';
import ManagerRoutes from './routes/manager';
import RnRoutes from './routes/rn';
import StaffRoutes from './routes/staff';

const { RouteRegistry } = AdminRegistry;

export const AppRouter: React.FC = () => {
    return (
        <Routes>
            {/* Auth Routes */}
            <Route path="/*" element={<AuthRoutes />} />

            {/* Admin/Operations Routes */}
            <Route
                path="/admin/*"
                element={
                    <RequireRole allowedRoles={['admin', 'staff']}>
                        <AdminRoutes />
                    </RequireRole>
                }
            />

            {/* Staff Specific Routes */}
            <Route
                path="/staff/*"
                element={
                    <RequireRole allowedRoles={['staff', 'admin']}>
                        <StaffRoutes />
                    </RequireRole>
                }
            />

            {/* PSW Routes */}
            <Route
                path="/psw/*"
                element={
                    <RequireRole allowedRoles={['psw']}>
                        <PswRoutes />
                    </RequireRole>
                }
            />

            {/* Client Routes */}
            <Route
                path="/client/*"
                element={
                    <RequireRole allowedRoles={['client']}>
                        <ClientRoutes />
                    </RequireRole>
                }
            />

            {/* Manager Routes */}
            <Route
                path="/manager/*"
                element={
                    <RequireRole allowedRoles={['manager']}>
                        <ManagerRoutes />
                    </RequireRole>
                }
            />

            {/* RN Routes */}
            <Route
                path="/rn/*"
                element={
                    <RequireRole allowedRoles={['rn']}>
                        <RnRoutes />
                    </RequireRole>
                }
            />

            {/* Fallback */}
            <Route path="/" element={<Navigate to="/admin/dashboard" replace />} />
            <Route path="*" element={<Navigate to="/" replace />} />
        </Routes>
    );
};
