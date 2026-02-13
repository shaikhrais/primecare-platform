import React from 'react';
import { Routes, Route, Navigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';

// Layouts
import AdminLayout from '@/shared/components/layout/AdminLayout';
import ManagerLayout from '@/shared/components/layout/ManagerLayout';

// Guards
import RequireRole from '@/shared/rbac/RequireRole';

// Pages
import Profile from './routes/shared/pages/profile';
import SupportHub from './routes/shared/pages/support-hub';
import SupportTicket from './routes/shared/pages/support-ticket';
import Messaging from './routes/shared/pages/messaging';
import VisitCompletion from './routes/shared/pages/visit-completion';
import VisitDetails from './routes/shared/pages/visit-details';

// Auth Pages
import Login from './routes/auth/pages/login';
import Register from './routes/auth/pages/register';
import ForgotPassword from './routes/auth/pages/forgot-password';
import ResetPassword from './routes/auth/pages/reset-password';

import AdminRoutes from './routes/admin';
import PswRoutes from './routes/psw';
import ClientRoutes from './routes/client';
import ManagerRoutes from './routes/manager';
import RnRoutes from './routes/rn';
import StaffRoutes from './routes/staff';
import SharedRoutes from './routes/shared';

// Error Pages
import NotFound from './routes/shared/pages/error/NotFound';

const { RouteRegistry } = AdminRegistry;

import { useAuth } from '@/shared/context/AuthContext';

// Simple Error Boundary Component
class ErrorBoundary extends React.Component<{ children: React.ReactNode }, { hasError: boolean }> {
    constructor(props: { children: React.ReactNode }) {
        super(props);
        this.state = { hasError: false };
    }

    static getDerivedStateFromError() {
        return { hasError: true };
    }

    componentDidCatch(error: any, errorInfo: any) {
        console.error("Global Error Boundary caught an error:", error, errorInfo);
    }

    render() {
        if (this.state.hasError) {
            return (
                <div style={{ padding: '2rem', textAlign: 'center' }}>
                    <h1>Something went wrong.</h1>
                    <button onClick={() => window.location.href = '/'}>Go Home</button>
                </div>
            );
        }
        return this.props.children;
    }
}

const ShiftsRedirect: React.FC = () => {
    const { user, loading } = useAuth();
    if (loading) return null;
    if (!user) return <Navigate to={RouteRegistry.LOGIN} replace />;

    const role = user.activeRole || (user.roles && user.roles[0]) || 'client';
    if (role === 'psw') return <Navigate to="/psw/schedule" replace />;
    return <Navigate to={RouteRegistry.SCHEDULE} replace />;
};

export const AppRouter: React.FC = () => {
    return (
        <ErrorBoundary>
            <Routes>
                {/* Auth Routes - No Layout */}
                <Route path="/login" element={<Login />} />
                <Route path="/register" element={<Register />} />
                <Route path="/forgot-password" element={<ForgotPassword />} />
                <Route path="/reset-password" element={<ResetPassword />} />

                {/* Redirects */}
                <Route path="/shifts" element={<ShiftsRedirect />} />

                {/* Role Specific Routes with Layout */}
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

                {/* Shared Protected Pages (Flat structure for cleaner URLs) */}
                <Route path="/profile" element={<AdminLayout><Profile /></AdminLayout>} />
                <Route path="/support" element={<AdminLayout><SupportHub /></AdminLayout>} />
                <Route path="/support/tickets/new" element={<AdminLayout><SupportTicket /></AdminLayout>} />
                <Route path="/messaging" element={<AdminLayout><Messaging /></AdminLayout>} />
                <Route path="/visits/:id" element={<AdminLayout><VisitDetails /></AdminLayout>} />
                <Route path="/visits/:id/complete" element={<AdminLayout><VisitCompletion /></AdminLayout>} />

                {/* Shared routes fallback for legacy/test paths */}
                <Route path="/shared/*" element={<AdminLayout><SharedRoutes /></AdminLayout>} />

                {/* Fallback & Home */}
                <Route path="/" element={<Navigate to="/admin/dashboard" replace />} />

                {/* Catch-all 404 (Outside Layout) */}
                <Route path="*" element={<NotFound />} />
            </Routes>
        </ErrorBoundary>
    );
};
