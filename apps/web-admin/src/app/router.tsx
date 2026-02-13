import React from 'react';
import { Routes, Route, Navigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';

// Layouts
import AdminLayout from '@/shared/components/layout/AdminLayout';
import ManagerLayout from '@/shared/components/layout/ManagerLayout';

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
import SharedRoutes from './routes/shared';

const { RouteRegistry } = AdminRegistry;

export const AppRouter: React.FC = () => {
    return (
        <Routes>
            {/* Auth Routes */}
            <Route path="/*" element={<AuthRoutes />} />

            {/* Shared Routes */}
            <Route
                path="/*"
                element={
                    <AdminLayout>
                        <SharedRoutes />
                    </AdminLayout>
                }
            />

            {/* Admin/Operations Routes */}
            <Route
                path="/admin/*"
                element={
                    <RequireRole allowedRoles={['admin', 'staff']}>
                        <AdminLayout>
                            <AdminRoutes />
                        </AdminLayout>
                    </RequireRole>
                }
            />

            {/* Staff Specific Routes */}
            <Route
                path="/staff/*"
                element={
                    <RequireRole allowedRoles={['staff', 'admin']}>
                        <AdminLayout>
                            <StaffRoutes />
                        </AdminLayout>
                    </RequireRole>
                }
            />

            {/* PSW Routes */}
            <Route
                path="/psw/*"
                element={
                    <RequireRole allowedRoles={['psw']}>
                        <AdminLayout>
                            <PswRoutes />
                        </AdminLayout>
                    </RequireRole>
                }
            />

            {/* Client Routes */}
            <Route
                path="/client/*"
                element={
                    <RequireRole allowedRoles={['client']}>
                        <AdminLayout>
                            <ClientRoutes />
                        </AdminLayout>
                    </RequireRole>
                }
            />

            {/* Manager Routes */}
            <Route
                path="/manager/*"
                element={
                    <RequireRole allowedRoles={['manager']}>
                        <AdminLayout>
                            <ManagerRoutes />
                        </AdminLayout>
                    </RequireRole>
                }
            />

            {/* RN Routes */}
            <Route
                path="/rn/*"
                element={
                    <RequireRole allowedRoles={['rn']}>
                        <AdminLayout>
                            <RnRoutes />
                        </AdminLayout>
                    </RequireRole>
                }
            />

            {/* Fallback */}
            <Route path="/" element={<Navigate to="/admin/dashboard" replace />} />
            <Route path="*" element={<Navigate to="/" replace />} />
        </Routes>
    );
};
