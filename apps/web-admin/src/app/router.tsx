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
            <Route path="/*" element={<AuthRoutes />} />

            {/* Admin Routes */}
            <Route
                path="/admin/*"
                element={
                    <RequireRole allowedRoles={['admin']}>
                        <AdminRoutes />
                    </RequireRole>
                }
            />

            {/* Fallback */}
            <Route path="/" element={<Navigate to="/admin/dashboard" replace />} />
            <Route path="*" element={<Navigate to="/" replace />} />
        </Routes>
    );
};
