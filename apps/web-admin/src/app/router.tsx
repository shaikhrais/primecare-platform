import React, { Suspense } from 'react';
import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';

// Layouts & Contexts
import AppLayout from '@/shared/components/layout/AppLayout';
import { NotificationCenterProvider } from '@/shared/context/NotificationCenterContext';
import { CommandPaletteWrapper } from '@/shared/components/CommandPaletteWrapper';

// Guards
import RequireRole from '@/shared/rbac/RequireRole';
import { useAuth } from '@/shared/context/AuthContext';

// Auth Pages (Eagerly loaded)
import Login from './routes/auth/pages/login';
import Register from './routes/auth/pages/register';
import ForgotPassword from './routes/auth/pages/forgot-password';
import ResetPassword from './routes/auth/pages/reset-password';

// Error Pages
import NotFound from './routes/shared/pages/error/NotFound';
import Unauthorized from './routes/shared/pages/error/Unauthorized';
import ServerError from './routes/shared/pages/error/ServerError';

const { RouteRegistry } = AdminRegistry;

// ----------------------------------------------------------------------
// LAZY LOADED PAGES (Consolidated from sub-routes)
// ----------------------------------------------------------------------

// Admin components (Eagerly loaded)
import AdminDashboard from './routes/admin/pages/dashboard';
import { UserList, UserEntry } from './routes/admin/pages/users';
import AdminEarningsPage from './routes/admin/pages/earnings';

// Admin Pages (Lazy loaded)
const Schedule = React.lazy(() => import('./routes/admin/pages/schedule'));
const IncidentList = React.lazy(() => import('./routes/admin/pages/incidents').then(m => ({ default: m.IncidentList })));
const IncidentEntry = React.lazy(() => import('./routes/admin/pages/incidents').then(m => ({ default: m.IncidentEntry })));
const LeadsPage = React.lazy(() => import('./routes/admin/pages/leads').then(m => ({ default: m.LeadsPage })));
const LeadEntryForm = React.lazy(() => import('./routes/admin/pages/leads').then(m => ({ default: m.LeadEntryForm })));
const Timesheets = React.lazy(() => import('./routes/admin/pages/timesheets'));
const TimesheetAdjustment = React.lazy(() => import('./routes/admin/pages/timesheet-adjustment'));
const Services = React.lazy(() => import('./routes/admin/pages/services'));
const Settings = React.lazy(() => import('./routes/admin/pages/settings'));
const ContentManager = React.lazy(() => import('./routes/admin/pages/content'));
const AuditLogs = React.lazy(() => import('./routes/admin/pages/audits'));
const LeadAdmission = React.lazy(() => import('./routes/admin/pages/admission'));
const Onboarding = React.lazy(() => import('./routes/admin/pages/onboarding'));
const ReportCenter = React.lazy(() => import('./routes/admin/pages/reports'));
const InvoicesNew = React.lazy(() => import('./routes/admin/pages/invoices-new'));

// Manager Pages
const ManagerDashboard = React.lazy(() => import('./routes/manager/pages/dashboard'));
const Portfolio = React.lazy(() => import('./routes/manager/pages/portfolio'));
const DailyEntry = React.lazy(() => import('./routes/manager/pages/daily-entry'));
const Evaluations = React.lazy(() => import('./routes/manager/pages/evaluations'));
const ServiceReview = React.lazy(() => import('./routes/manager/pages/service-review'));

// PSW Pages
const PswDashboard = React.lazy(() => import('./routes/psw/pages/dashboard'));
const PswSchedule = React.lazy(() => import('./routes/psw/pages/schedule'));
const PswOpenShifts = React.lazy(() => import('./routes/psw/pages/OpenShifts'));
const PswOpenOffers = React.lazy(() => import('./routes/psw/pages/OpenShifts/OpenOffers'));
const PswAvailability = React.lazy(() => import('./routes/psw/pages/availability'));
const PswEarnings = React.lazy(() => import('./routes/psw/pages/earnings'));
const PswExpenses = React.lazy(() => import('./routes/psw/pages/expenses'));

// RN Pages
const RnDashboard = React.lazy(() => import('./routes/rn/pages/dashboard'));

// Client Pages
const ClientDashboard = React.lazy(() => import('./routes/client/pages/dashboard'));
const ClientBookings = React.lazy(() => import('./routes/client/pages/bookings'));
const ClientBilling = React.lazy(() => import('./routes/client/pages/billing'));
const ClientFeedback = React.lazy(() => import('./routes/client/pages/feedback'));
const RequestBooking = React.lazy(() => import('./routes/client/pages/request-booking'));

// Shared Protected Pages
const Profile = React.lazy(() => import('./routes/shared/pages/profile'));
const SupportHub = React.lazy(() => import('./routes/shared/pages/support-hub'));
const SupportTicket = React.lazy(() => import('./routes/shared/pages/support-ticket'));
const Messaging = React.lazy(() => import('./routes/shared/pages/messaging'));
const VisitDetails = React.lazy(() => import('./routes/shared/pages/visit-details'));
const VisitCompletion = React.lazy(() => import('./routes/shared/pages/visit-completion'));

// Fallback Loader
const LoadingFallback = () => (
    <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh', width: '100%', color: '#6B7280' }}>
        <div className="animate-spin" style={{ fontSize: '2rem' }}>⌛</div>
    </div>
);

// ----------------------------------------------------------------------
// COMPONENTS
// ----------------------------------------------------------------------

class ErrorBoundary extends React.Component<{ children: React.ReactNode }, { hasError: boolean }> {
    constructor(props: { children: React.ReactNode }) {
        super(props);
        this.state = { hasError: false };
    }
    static getDerivedStateFromError() { return { hasError: true }; }
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

const IndexRedirect: React.FC = () => {
    const { user, loading } = useAuth();
    if (loading) return null;
    if (!user) return <Navigate to={RouteRegistry.LOGIN} replace />;

    const role = user.activeRole || (user.roles && user.roles[0]) || 'client';
    const target = RouteRegistry.ROLE_DASHBOARDS[role.toLowerCase()] || RouteRegistry.DASHBOARD;
    return <Navigate to={target} replace />;
};

// ----------------------------------------------------------------------
// MAIN ROUTER
// ----------------------------------------------------------------------

export const AppRouter: React.FC = () => {
    return (
        <NotificationCenterProvider>
            <ErrorBoundary>
                <Suspense fallback={<LoadingFallback />}>
                    <Routes>
                        {/* PUBLIC AUTH ROUTES */}
                        <Route path={RouteRegistry.LOGIN} element={<Login />} />
                        <Route path={RouteRegistry.REGISTER} element={<Register />} />
                        <Route path="/forgot-password" element={<ForgotPassword />} />
                        <Route path={RouteRegistry.USERS} element={<RequireRole allowedRoles={['admin', 'staff']}><UserList /></RequireRole>} />
                        <Route path={RouteRegistry.USERS_NEW} element={<RequireRole allowedRoles={['admin', 'staff']}><UserEntry /></RequireRole>} />
                        <Route path={RouteRegistry.USERS_EDIT(':id')} element={<RequireRole allowedRoles={['admin', 'staff']}><UserEntry /></RequireRole>} />
                        <Route path="/reset-password" element={<ResetPassword />} />

                        {/* ADMIN PORTAL */}
                        <Route path="/admin" element={<RequireRole allowedRoles={['admin']}><AppLayout /></RequireRole>}>
                            <Route path="dashboard" element={<AdminDashboard />} />
                            <Route path="users" element={<UserList />} />
                            <Route path="users/new" element={<UserEntry />} />
                            <Route path="users/:id/edit" element={<UserEntry />} />
                            <Route path="schedule" element={<Schedule />} />
                            <Route path="earnings" element={<AdminEarningsPage />} />
                            <Route path="incidents" element={<IncidentList />} />
                            <Route path="incidents/new" element={<IncidentEntry />} />
                            <Route path="timesheets" element={<Timesheets />} />
                            <Route path="timesheets/adjust" element={<TimesheetAdjustment />} />
                            <Route path="leads" element={<LeadsPage />} />
                            <Route path="leads/new" element={<LeadEntryForm />} />
                            <Route path="services" element={<Services />} />
                            <Route path="settings" element={<Settings />} />
                            <Route path="content" element={<ContentManager />} />
                            <Route path="audits" element={<AuditLogs />} />
                            <Route path="admission" element={<LeadAdmission />} />
                            <Route path="onboarding" element={<Onboarding />} />
                            <Route path="reports" element={<ReportCenter />} />
                            <Route path="invoices/new" element={<InvoicesNew />} />
                        </Route>

                        {/* MANAGER PORTAL */}
                        <Route path="/managers" element={<RequireRole allowedRoles={['manager', 'operations_manager', 'clinical_manager']}><AppLayout /></RequireRole>}>
                            <Route path="dashboard" element={<Portfolio />} />
                            <Route path="portfolio" element={<Portfolio />} />
                            <Route path="daily-entry" element={<DailyEntry />} />
                            <Route path="evaluations" element={<Evaluations />} />
                            <Route path="service-review" element={<ServiceReview />} />
                            <Route path=":category" element={<ManagerDashboard />} />
                            <Route index element={<Portfolio />} />
                        </Route>

                        {/* STAFF PORTAL */}
                        <Route path="/staff" element={<RequireRole allowedRoles={['staff', 'admin']}><AppLayout /></RequireRole>}>
                            <Route path="dashboard" element={<AdminDashboard />} />
                            <Route path="customers" element={<UserList />} />
                        </Route>

                        {/* PSW / PROVIDER PORTAL */}
                        <Route path="/psw" element={<RequireRole allowedRoles={['psw']}><AppLayout /></RequireRole>}>
                            <Route path="dashboard" element={<PswDashboard />} />
                            <Route path="schedule" element={<PswSchedule />} />
                            <Route path="open-shifts" element={<PswOpenShifts />} />
                            <Route path="offers" element={<PswOpenOffers />} />
                            <Route path="availability" element={<PswAvailability />} />
                            <Route path="earnings" element={<PswEarnings />} />
                            <Route path="expenses" element={<PswExpenses />} />
                        </Route>

                        {/* RN PORTAL */}
                        <Route path="/rn" element={<RequireRole allowedRoles={['rn']}><AppLayout /></RequireRole>}>
                            <Route path="dashboard" element={<RnDashboard />} />
                        </Route>

                        {/* CLIENT PORTAL */}
                        <Route path="/client" element={<RequireRole allowedRoles={['client']}><AppLayout /></RequireRole>}>
                            <Route path="dashboard" element={<ClientDashboard />} />
                            <Route path="bookings" element={<ClientBookings />} />
                            <Route path="billing" element={<ClientBilling />} />
                            <Route path="feedback" element={<ClientFeedback />} />
                            <Route path="request-booking" element={<RequestBooking />} />
                        </Route>

                        {/* SHARED PROTECTED ROUTES */}
                        <Route element={<RequireRole allowedRoles={['admin', 'staff', 'manager', 'psw', 'rn', 'client']}><AppLayout /></RequireRole>}>
                            <Route path="/profile" element={<Profile />} />
                            <Route path="/support" element={<SupportHub />} />
                            <Route path="/support/tickets/new" element={<SupportTicket />} />
                            <Route path="/messaging" element={<Messaging />} />
                            <Route path="/visits/:id" element={<VisitDetails />} />
                            <Route path="/visits/:id/complete" element={<VisitCompletion />} />
                            <Route path="/shared/404" element={<NotFound />} />
                            <Route path="/shared/401" element={<Unauthorized />} />
                            <Route path="/shared/500" element={<ServerError />} />
                        </Route>

                        {/* REDIRECTS & FALLBACKS */}
                        <Route path="/" element={<IndexRedirect />} />
                        <Route path="/app" element={<IndexRedirect />} />
                        <Route path="/shifts" element={<Navigate to="/admin/schedule" replace />} />
                        <Route path="*" element={<NotFound />} />
                    </Routes>
                </Suspense>
            </ErrorBoundary>
        </NotificationCenterProvider>
    );
};

export default AppRouter;
