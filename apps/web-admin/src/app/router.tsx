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
import BusinessOnboard from './routes/auth/pages/onboard-business';

// Error Pages
import NotFound from './routes/shared/pages/error/NotFound';
import Unauthorized from './routes/shared/pages/error/Unauthorized';
import ServerError from './routes/shared/pages/error/ServerError';

const { RouteRegistry } = AdminRegistry;

// ----------------------------------------------------------------------
// LAZY LOADED PAGES (Consolidated from sub-routes)
// ----------------------------------------------------------------------

// Admin components (Eagerly loaded)
import AdminDashboard from './routes/platform/admin/pages/dashboard';
import { UserList, UserEntry } from './routes/platform/admin/pages/users';
import AdminEarningsPage from './routes/platform/admin/pages/earnings';

// Admin Pages (Lazy loaded)
const Schedule = React.lazy(() => import('./routes/platform/admin/pages/schedule'));
const IncidentList = React.lazy(() => import('./routes/platform/admin/pages/incidents').then(m => ({ default: m.IncidentList })));
const IncidentEntry = React.lazy(() => import('./routes/platform/admin/pages/incidents').then(m => ({ default: m.IncidentEntry })));
const LeadsPage = React.lazy(() => import('./routes/platform/admin/pages/leads').then(m => ({ default: m.LeadsPage })));
const LeadEntryForm = React.lazy(() => import('./routes/platform/admin/pages/leads').then(m => ({ default: m.LeadEntryForm })));
const Timesheets = React.lazy(() => import('./routes/platform/admin/pages/timesheets'));
const TimesheetAdjustment = React.lazy(() => import('./routes/platform/admin/pages/timesheet-adjustment'));
const Services = React.lazy(() => import('./routes/platform/admin/pages/services'));
const Settings = React.lazy(() => import('./routes/platform/admin/pages/settings'));
const ContentManager = React.lazy(() => import('./routes/platform/admin/pages/content'));
const AuditLogs = React.lazy(() => import('./routes/platform/admin/pages/audits'));
const LeadAdmission = React.lazy(() => import('./routes/platform/admin/pages/admission'));
const Onboarding = React.lazy(() => import('./routes/platform/admin/pages/onboarding'));
const ReportCenter = React.lazy(() => import('./routes/platform/admin/pages/reports'));
const InvoicesNew = React.lazy(() => import('./routes/platform/admin/pages/invoices').then(m => ({ default: m.InvoiceEntry })));
const BusinessSetupWizard = React.lazy(() => import('./routes/platform/admin/pages/setup/BusinessSetupWizard'));
const WizardHub = React.lazy(() => import('./routes/platform/admin/pages/setup/WizardHub'));
const StaffOnboardingWizard = React.lazy(() => import('./routes/platform/admin/pages/setup/StaffOnboardingWizard'));
const CarePlanWizard = React.lazy(() => import('./routes/platform/admin/pages/setup/CarePlanWizard'));
const RevenueWizard = React.lazy(() => import('./routes/platform/admin/pages/setup/RevenueWizard'));
const BusinessModelWizard = React.lazy(() => import('./routes/platform/admin/pages/setup/BusinessModelWizard'));
const BusinessStatus = React.lazy(() => import('./routes/platform/admin/pages/setup/BusinessStatus'));
const DeveloperPortal = React.lazy(() => import('./routes/platform/admin/pages/developer'));
const Marketplace = React.lazy(() => import('./routes/platform/admin/pages/marketplace'));
const ResellerDashboard = React.lazy(() => import('./routes/platform/admin/pages/reseller/ResellerDashboard'));
const PrivateMarketplace = React.lazy(() => import('./routes/platform/admin/pages/reseller/PrivateMarketplace'));
const GrowthStrategy = React.lazy(() => import('./routes/platform/admin/pages/strategy/GrowthStrategy'));
const KnowledgeBaseIndex = React.lazy(() => import('./routes/platform/admin/pages/knowledge-base/KnowledgeBaseIndex'));
const KnowledgeBaseArticle = React.lazy(() => import('./routes/platform/admin/pages/knowledge-base/KnowledgeBaseArticle'));
const AIInsights = React.lazy(() => import('./routes/platform/admin/pages/insights'));
const ClinicalAssistant = React.lazy(() => import('./routes/platform/admin/pages/clinical-assistant'));
const AutoPilotDashboard = React.lazy(() => import('./routes/platform/admin/pages/automation/AutoPilotDashboard'));
const FHIRCenter = React.lazy(() => import('./routes/platform/admin/pages/interoperability/FHIRCenter'));
const SovereignWallet = React.lazy(() => import('./routes/platform/admin/pages/sovereign/SovereignWallet'));
const Locations = React.lazy(() => import('./routes/platform/admin/pages/locations'));
const RoleEditor = React.lazy(() => import('./routes/platform/admin/pages/role-editor'));

// Manager Pages
const ManagerDashboard = React.lazy(() => import('./routes/tenancy/manager/pages/dashboard'));
const Portfolio = React.lazy(() => import('./routes/tenancy/manager/pages/portfolio'));
const DailyEntry = React.lazy(() => import('./routes/tenancy/manager/pages/daily-entry'));
const Evaluations = React.lazy(() => import('./routes/tenancy/manager/pages/evaluations'));
const ServiceReview = React.lazy(() => import('./routes/tenancy/manager/pages/service-review'));

// PSW Pages
const PswDashboard = React.lazy(() => import('./routes/tenancy/psw/pages/dashboard'));
const PswSchedule = React.lazy(() => import('./routes/tenancy/psw/pages/schedule'));
const PswOpenShifts = React.lazy(() => import('./routes/tenancy/psw/pages/OpenShifts'));
const PswOpenOffers = React.lazy(() => import('./routes/tenancy/psw/pages/OpenShifts/OpenOffers'));
const PswAvailability = React.lazy(() => import('./routes/tenancy/psw/pages/availability'));
const PswEarnings = React.lazy(() => import('./routes/tenancy/psw/pages/earnings'));
const PswExpenses = React.lazy(() => import('./routes/tenancy/psw/pages/expenses'));
const PswShiftConfirmation = React.lazy(() => import('./routes/tenancy/psw/pages/shift-confirmation'));

// RN Pages
const RnDashboard = React.lazy(() => import('./routes/tenancy/rn/pages/dashboard'));

// Staff Pages
const StaffDashboard = React.lazy(() => import('./routes/tenancy/staff/pages/dashboard'));

// Platform Portal (Super Admin)
const PlatformDashboard = React.lazy(() => import('./routes/platform/pages/dashboard'));
const PlatformAuditLogs = React.lazy(() => import('./routes/platform/pages/audit-logs'));
const SLAMonitoring = React.lazy(() => import('./routes/platform/pages/sla-monitoring'));
const RiskSurveillanceDashboard = React.lazy(() => import('./routes/platform/superuser/super-admin/pages/RiskSurveillanceDashboard'));

// Client Pages
const ClientDashboard = React.lazy(() => import('./routes/tenancy/client/pages/dashboard'));
const ClientBookings = React.lazy(() => import('./routes/tenancy/client/pages/bookings'));
const ClientBilling = React.lazy(() => import('./routes/tenancy/client/pages/billing'));
const ClientFeedback = React.lazy(() => import('./routes/tenancy/client/pages/feedback'));
const RequestBooking = React.lazy(() => import('./routes/tenancy/client/pages/request-booking'));

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
    const target = RouteRegistry.ROLE_DASHBOARDS[role.toLowerCase()] || RouteRegistry.ADMIN.DASHBOARD;
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
                        <Route path={RouteRegistry.BUSINESS_ONBOARD} element={<BusinessOnboard />} />
                        <Route path={RouteRegistry.FORGOT_PASSWORD} element={<ForgotPassword />} />
                        <Route path={RouteRegistry.RESET_PASSWORD} element={<ResetPassword />} />

                        {/* ADMIN PORTAL */}
                        <Route path={RouteRegistry.ADMIN.DASHBOARD} element={<RequireRole allowedRoles={['admin']}><AppLayout /></RequireRole>}>
                            <Route index element={<AdminDashboard />} />
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
                            <Route path="setup-wizard" element={<BusinessSetupWizard />} />
                            <Route path="wizard-hub" element={<WizardHub />} />
                            <Route path="wizards/staff-onboarding" element={<StaffOnboardingWizard />} />
                            <Route path="wizards/care-plan" element={<CarePlanWizard />} />
                            <Route path="wizards/revenue" element={<RevenueWizard />} />
                            <Route path="wizards/business-strategy" element={<BusinessModelWizard />} />
                            <Route path="business-status" element={<BusinessStatus />} />
                            <Route path="developer" element={<DeveloperPortal />} />
                            <Route path="marketplace" element={<Marketplace />} />
                            <Route path="reseller" element={<ResellerDashboard />} />
                            <Route path="private-marketplace" element={<PrivateMarketplace />} />
                            <Route path="growth-strategy" element={<GrowthStrategy />} />
                            <Route path="knowledge-base" element={<KnowledgeBaseIndex />} />
                            <Route path="knowledge-base/:slug" element={<KnowledgeBaseArticle />} />
                            <Route path="insights" element={<AIInsights />} />
                            <Route path="clinical-assistant" element={<ClinicalAssistant />} />
                            <Route path="automation/clinical-autopilot" element={<AutoPilotDashboard />} />
                            <Route path="interop" element={<FHIRCenter />} />
                            <Route path="sovereign" element={<SovereignWallet />} />
                            <Route path="locations" element={<Locations />} />
                            <Route path="role-editor" element={<RoleEditor />} />
                        </Route>

                        {/* MANAGER PORTAL */}
                        <Route path={RouteRegistry.MANAGER.DASHBOARD} element={<RequireRole allowedRoles={['manager', 'operations_manager', 'clinical_manager']}><AppLayout /></RequireRole>}>
                            <Route index element={<Portfolio />} />
                            <Route path="daily-entry" element={<DailyEntry />} />
                            <Route path="evaluations" element={<Evaluations />} />
                            <Route path="service-review" element={<ServiceReview />} />
                            <Route path=":category" element={<ManagerDashboard />} />
                        </Route>

                        {/* STAFF PORTAL */}
                        <Route path={RouteRegistry.STAFF.DASHBOARD} element={<RequireRole allowedRoles={['staff', 'admin']}><AppLayout /></RequireRole>}>
                            <Route index element={<StaffDashboard />} />
                            <Route path="customers" element={<UserList />} />
                        </Route>

                        {/* PSW / PROVIDER PORTAL */}
                        <Route path={RouteRegistry.PSW.DASHBOARD} element={<RequireRole allowedRoles={['psw']}><AppLayout /></RequireRole>}>
                            <Route index element={<PswDashboard />} />
                            <Route path="schedule" element={<PswSchedule />} />
                            <Route path="open-shifts" element={<PswOpenShifts />} />
                            <Route path="offers" element={<PswOpenOffers />} />
                            <Route path="availability" element={<PswAvailability />} />
                            <Route path="earnings" element={<PswEarnings />} />
                            <Route path="expenses" element={<PswExpenses />} />
                            <Route path="shift-confirmation" element={<PswShiftConfirmation />} />
                        </Route>

                        {/* RN PORTAL */}
                        <Route path={RouteRegistry.RN.DASHBOARD} element={<RequireRole allowedRoles={['rn']}><AppLayout /></RequireRole>}>
                            <Route index element={<RnDashboard />} />
                        </Route>

                        {/* CLIENT PORTAL */}
                        <Route path={RouteRegistry.CLIENT.DASHBOARD} element={<RequireRole allowedRoles={['client']}><AppLayout /></RequireRole>}>
                            <Route index element={<ClientDashboard />} />
                            <Route path="bookings" element={<ClientBookings />} />
                            <Route path="billing" element={<ClientBilling />} />
                            <Route path="feedback" element={<ClientFeedback />} />
                            <Route path="request-booking" element={<RequestBooking />} />
                        </Route>

                        {/* PLATFORM PORTAL (SUPER ADMIN) */}
                        <Route path={RouteRegistry.SUPERUSER.DASHBOARD} element={<RequireRole allowedRoles={['super_admin']}><AppLayout /></RequireRole>}>
                            <Route index element={<PlatformDashboard />} />
                            <Route path="audit-logs" element={<PlatformAuditLogs />} />
                            <Route path="sla" element={<SLAMonitoring />} />
                            <Route path="risk-surveillance" element={<RiskSurveillanceDashboard />} />
                        </Route>

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
                            <Route path={RouteRegistry.NOT_FOUND} element={<NotFound />} />
                            <Route path={RouteRegistry.UNAUTHORIZED} element={<Unauthorized />} />
                            <Route path={RouteRegistry.SERVER_ERROR} element={<ServerError />} />
                        </Route>

                        {/* REDIRECTS & FALLBACKS */}
                        <Route path="/" element={<IndexRedirect />} />
                        <Route path="/app" element={<IndexRedirect />} />
                        <Route path="/shifts" element={<Navigate to={RouteRegistry.ADMIN.SCHEDULE} replace />} />
                        <Route path="*" element={<NotFound />} />
                    </Routes>
                </Suspense>
            </ErrorBoundary>
        </NotificationCenterProvider>
    );
};

export default AppRouter;
