import React, { Suspense } from 'react';
import { Routes, Route, Navigate } from 'react-router';
import { AdminRegistry } from 'prime-care-shared';

// Layouts & Contexts
import AppLayout from '@/shared/components/layout/AppLayout';


// Guards
import RequireRole from '@/shared/rbac/RequireRole';
import { useAuth } from '@/shared/context/AuthContext';

// Auth Pages (Eagerly loaded)
import Login from './routes/auth/pages/login';
import Register from './routes/auth/pages/register';
import ForgotPassword from './routes/auth/pages/forgot-password';
import ResetPassword from './routes/auth/pages/reset-password';
import BusinessOnboard from './routes/auth/pages/onboard-business';

// Error Pages
import NotFound from './routes/shared/pages/error/NotFound';
import Unauthorized from './routes/shared/pages/error/Unauthorized';
import ServerError from './routes/shared/pages/error/ServerError';

// Sub-Routers
import { AdminRoutes } from './routes/platform/admin/AdminRoutes';
import { ScrumMasterRoutes } from './routes/platform/scrum-master/ScrumMasterRoutes';
import { TenancyRoutes } from './routes/tenancy/TenancyRoutes';
import { PlatformRoutes } from './routes/platform/PlatformRoutes';
import { StaffRoutes } from './routes/tenancy/staff/StaffRoutes';

const { RouteRegistry } = AdminRegistry;

// Shared Protected Pages (Lazy loaded)
const Profile = React.lazy(() => import('./routes/shared/pages/profile'));
const SupportHub = React.lazy(() => import('./routes/shared/pages/support-hub'));
const SupportTicket = React.lazy(() => import('./routes/shared/pages/support-ticket'));
const Messaging = React.lazy(() => import('./routes/shared/pages/messaging'));
const VisitDetails = React.lazy(() => import('./routes/shared/pages/visit-details'));
const VisitCompletion = React.lazy(() => import('./routes/shared/pages/visit-completion'));
const UserTrainingPage = React.lazy(() => import('./routes/shared/pages/training'));
const KnowledgeBaseIndex = React.lazy(() => import('./routes/platform/admin/pages/knowledge-base/KnowledgeBaseIndex'));
const KnowledgeBaseArticle = React.lazy(() => import('./routes/platform/admin/pages/knowledge-base/KnowledgeBaseArticle'));
const MarketingShowcase = React.lazy(() => import('./routes/shared/pages/MarketingShowcase'));

// Fallback Loader
// Skeleton Loader for lazy-loaded route chunks
const LoadingFallback = () => (
    <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem', padding: '2rem', maxWidth: '800px', margin: '2rem auto' }}>
        {/* Header skeleton */}
        <div style={{ height: '2rem', width: '40%', borderRadius: '0.5rem', background: 'linear-gradient(90deg, #e5e7eb 25%, #f3f4f6 50%, #e5e7eb 75%)', backgroundSize: '200% 100%', animation: 'shimmer 1.5s infinite' }} />
        {/* Content skeleton bars */}
        <div style={{ height: '1rem', width: '100%', borderRadius: '0.5rem', background: 'linear-gradient(90deg, #e5e7eb 25%, #f3f4f6 50%, #e5e7eb 75%)', backgroundSize: '200% 100%', animation: 'shimmer 1.5s infinite' }} />
        <div style={{ height: '1rem', width: '85%', borderRadius: '0.5rem', background: 'linear-gradient(90deg, #e5e7eb 25%, #f3f4f6 50%, #e5e7eb 75%)', backgroundSize: '200% 100%', animation: 'shimmer 1.5s infinite' }} />
        <div style={{ height: '1rem', width: '60%', borderRadius: '0.5rem', background: 'linear-gradient(90deg, #e5e7eb 25%, #f3f4f6 50%, #e5e7eb 75%)', backgroundSize: '200% 100%', animation: 'shimmer 1.5s infinite' }} />
        {/* Card skeletons */}
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(200px, 1fr))', gap: '1rem', marginTop: '1rem' }}>
            {[1,2,3].map(i => (
                <div key={i} style={{ height: '120px', borderRadius: '0.75rem', background: 'linear-gradient(90deg, #e5e7eb 25%, #f3f4f6 50%, #e5e7eb 75%)', backgroundSize: '200% 100%', animation: 'shimmer 1.5s infinite' }} />
            ))}
        </div>
        <style>{`@keyframes shimmer { 0% { background-position: 200% 0; } 100% { background-position: -200% 0; } }`}</style>
    </div>
);

// ----------------------------------------------------------------------
// COMPONENTS
// ----------------------------------------------------------------------

// ErrorBoundary removed — now handled globally by src/shared/components/ErrorBoundary.tsx
// Wrapped in App.tsx, so router-level one is no longer needed.
import { ErrorBoundary } from '@/shared/components/ErrorBoundary';

const IndexRedirect: React.FC = () => {
    const { user, loading } = useAuth();
    if (loading) return null;
    if (!user) return <Navigate to={RouteRegistry.LOGIN} replace />;

    const role = user.activeRole || (user.roles && user.roles[0]) || 'client';
    const target = RouteRegistry.ROLE_DASHBOARDS[role.toLowerCase()] || RouteRegistry.ADMIN.DASHBOARD;
    return <Navigate to={target} replace />;
};

// ----------------------------------------------------------------------
// MAIN ROUTER
// ----------------------------------------------------------------------

export const AppRouter: React.FC = () => {
    return (
        <ErrorBoundary>
            <Suspense fallback={<LoadingFallback />}>
                <Routes>
                    {/* PUBLIC AUTH ROUTES */}
                    <Route path={RouteRegistry.LOGIN} element={<Login />} />
                    <Route path={RouteRegistry.REGISTER} element={<Register />} />
                    <Route path={RouteRegistry.BUSINESS_ONBOARD} element={<BusinessOnboard />} />
                    <Route path={RouteRegistry.FORGOT_PASSWORD} element={<ForgotPassword />} />
                    <Route path={RouteRegistry.RESET_PASSWORD} element={<ResetPassword />} />
                    <Route path="/cmo-showcase" element={<MarketingShowcase />} />

                    {/* EXTRACTED ROUTE MODULES */}
                    {AdminRoutes()}
                    {TenancyRoutes()}
                    {StaffRoutes()}
                    {PlatformRoutes()}
                    {ScrumMasterRoutes()}

                    {/* SHARED PROTECTED ROUTES */}
                    <Route element={<RequireRole allowedRoles={['super_admin', 'admin', 'staff', 'manager', 'operations_manager', 'clinical_manager', 'hr_manager', 'finance_manager', 'regional_manager', 'marketing_manager', 'recruiting_manager', 'coordinator', 'finance', 'psw', 'rn', 'rmt', 'rpt', 'rch', 'client']}><AppLayout /></RequireRole>}>
                        <Route path={RouteRegistry.PROFILE} element={<Profile />} />
                        <Route path={RouteRegistry.SUPPORT} element={<SupportHub />} />
                        <Route path={RouteRegistry.SUPPORT_TICKETS_NEW} element={<SupportTicket />} />
                        <Route path={RouteRegistry.MESSAGING} element={<Messaging />} />
                        <Route path={RouteRegistry.VISITS_DETAILS(':id')} element={<VisitDetails />} />
                        <Route path={RouteRegistry.VISITS_COMPLETE(':id')} element={<VisitCompletion />} />
                        <Route path={RouteRegistry.KNOWLEDGE_BASE} element={<KnowledgeBaseIndex />} />
                        <Route path={RouteRegistry.KNOWLEDGE_BASE_ARTICLE(':slug')} element={<KnowledgeBaseArticle />} />
                        <Route path={RouteRegistry.LEARN} element={<UserTrainingPage />} />
                        <Route path={RouteRegistry.NOT_FOUND} element={<NotFound />} />
                        <Route path={RouteRegistry.UNAUTHORIZED} element={<Unauthorized />} />
                        <Route path={RouteRegistry.SERVER_ERROR} element={<ServerError />} />
                    </Route>

                    {/* REDIRECTS & FALLBACKS */}
                    <Route path="/" element={<IndexRedirect />} />
                    <Route path="/dashboard" element={<IndexRedirect />} />
                    <Route path="/app" element={<IndexRedirect />} />
                    <Route path="/shifts" element={<Navigate to={RouteRegistry.ADMIN.SCHEDULE} replace />} />
                    <Route path="*" element={<NotFound />} />
                </Routes>
            </Suspense>
        </ErrorBoundary>
    );
};

export default AppRouter;
