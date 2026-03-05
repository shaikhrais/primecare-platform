import React, { lazy } from 'react';
import { Route } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import RequireRole from '@/shared/rbac/RequireRole';
import AppLayout from '@/shared/components/layout/AppLayout';

const { RouteRegistry } = AdminRegistry;

// Manager Pages
const Portfolio = lazy(() => import('./manager/pages/portfolio'));
const DailyEntry = lazy(() => import('./manager/pages/daily-entry'));
const Evaluations = lazy(() => import('./manager/pages/evaluations'));
const ServiceReview = lazy(() => import('./manager/pages/service-review'));
const ManagerDashboard = lazy(() => import('./manager/pages/dashboard'));
const TrainingHub = lazy(() => import('./manager/pages/training'));
const SurveyManager = lazy(() => import('./manager/pages/surveys'));
const StaffRanker = lazy(() => import('./manager/pages/performance/StaffRanker'));
const BranchPL = lazy(() => import('./manager/pages/finance/BranchP_L'));
const PayrollVerification = lazy(() => import('./manager/pages/finance/PayrollVerification'));
const MarketingDashboard = lazy(() => import('./marketing/MarketingDashboard'));
const HrRecruitmentPortal = lazy(() => import('./hr/HrRecruitmentPortal'));
const FinanceRegionalHub = lazy(() => import('./finance/FinanceRegionalHub'));
const ClinicalQaDashboard = lazy(() => import('./qa/ClinicalQaDashboard'));
const CoordinatorHub = lazy(() => import('./coordinator/pages/hub/CoordinatorHub'));
const AlliedHealthDashboard = lazy(() => import('./allied-health/AlliedHealthDashboard'));
const RegionalStats = lazy(() => import('./manager/pages/RegionalStats'));

// PSW Pages
const PswDashboard = lazy(() => import('./psw/pages/dashboard'));
const PswSchedule = lazy(() => import('./psw/pages/schedule'));
const PswOpenShifts = lazy(() => import('./psw/pages/OpenShifts'));
const PswOpenOffers = lazy(() => import('./psw/pages/OpenShifts/OpenOffers'));
const PswAvailability = lazy(() => import('./psw/pages/availability'));
const PswEarnings = lazy(() => import('./psw/pages/earnings'));
const PswExpenses = lazy(() => import('./psw/pages/expenses'));
const PswShiftConfirmation = lazy(() => import('./psw/pages/shift-confirmation'));
const CredentialVault = lazy(() => import('./psw/pages/credentials/CredentialVault'));
const ProviderSocial = lazy(() => import('./psw/pages/feed/ProviderSocial'));
const LiveVisit = lazy(() => import('./psw/pages/schedule/LiveVisit'));
const PswHandover = lazy(() => import('./psw/pages/handover'));
const PswPayoutHistory = lazy(() => import('./psw/pages/payouts'));

// RN Pages
const RnDashboard = lazy(() => import('./rn/pages/dashboard'));
const CarePlanManager = lazy(() => import('./rn/pages/care-plans'));
const EntryVerify = lazy(() => import('./rn/pages/audit'));
const SupervisionHub = lazy(() => import('./rn/pages/supervision'));
const AssessmentsHub = lazy(() => import('./rn/pages/assessments'));

// Client Pages
const ClientDashboard = lazy(() => import('./client/pages/dashboard'));
const ClientBookings = lazy(() => import('./client/pages/bookings'));
const ClientBilling = lazy(() => import('./client/pages/billing'));
const ClientFeedback = lazy(() => import('./client/pages/feedback'));
const RequestBooking = lazy(() => import('./client/pages/request-booking'));
const CatalogBrowser = lazy(() => import('./client/pages/services/CatalogBrowser'));
const ClientMessaging = lazy(() => import('./client/pages/support/ClientMessaging'));
const CareTeam = lazy(() => import('./client/pages/team/CareTeam'));
const FeedbackLoop = lazy(() => import('./client/pages/support/FeedbackLoop'));
const FamilyCareHub = lazy(() => import('./client/pages/engagement/FamilyCareHub'));

export const TenancyRoutes = () => (
    <>
        {/* MANAGER PORTAL */}
        <Route path={RouteRegistry.MANAGER.DASHBOARD} element={<RequireRole allowedRoles={['manager', 'operations_manager', 'clinical_manager']}><AppLayout /></RequireRole>}>
            <Route index element={<Portfolio />} />
            <Route path={RouteRegistry.MANAGER.DAILY_ENTRY} element={<DailyEntry />} />
            <Route path={RouteRegistry.MANAGER.EVALUATIONS} element={<Evaluations />} />
            <Route path={RouteRegistry.MANAGER.SERVICE_REVIEW} element={<ServiceReview />} />
            <Route path={RouteRegistry.MANAGER.PERFORMANCE} element={<StaffRanker />} />
            <Route path={RouteRegistry.MANAGER.FINANCE} element={<BranchPL />} />
            <Route path={RouteRegistry.MANAGER.PAYROLL} element={<PayrollVerification />} />
            <Route path={RouteRegistry.MANAGER.REGIONAL_STATS} element={<RegionalStats />} />
            <Route path={RouteRegistry.MANAGER.TRAINING} element={<TrainingHub />} />
            <Route path={RouteRegistry.MANAGER.SURVEYS} element={<SurveyManager />} />
            <Route path=":category" element={<ManagerDashboard />} />
        </Route>

        {/* MARKETING PORTAL */}
        <Route path={RouteRegistry.MANAGER.MARKETING} element={<RequireRole allowedRoles={['marketing_manager']}><AppLayout /></RequireRole>}>
            <Route index element={<MarketingDashboard />} />
        </Route>

        {/* HR & RECRUITMENT PORTAL */}
        <Route path={RouteRegistry.MANAGER.RECRUITING} element={<RequireRole allowedRoles={['hr_manager', 'recruiting_manager']}><AppLayout /></RequireRole>}>
            <Route index element={<HrRecruitmentPortal />} />
        </Route>

        {/* FINANCE & REGIONAL HUB */}
        <Route path={RouteRegistry.MANAGER.FINANCE} element={<RequireRole allowedRoles={['finance_manager', 'regional_manager']}><AppLayout /></RequireRole>}>
            <Route index element={<FinanceRegionalHub />} />
        </Route>

        {/* CLINICAL QA DASHBOARD */}
        <Route path={RouteRegistry.MANAGER.CLINICAL} element={<RequireRole allowedRoles={['clinical_manager']}><AppLayout /></RequireRole>}>
            <Route index element={<ClinicalQaDashboard />} />
        </Route>

        {/* COORDINATOR HUB */}
        <Route path={RouteRegistry.MANAGER.COORDINATOR} element={<RequireRole allowedRoles={['coordinator', 'operations_manager']}><AppLayout /></RequireRole>}>
            <Route index element={<CoordinatorHub />} />
        </Route>

        {/* PSW / PROVIDER PORTAL */}
        <Route path={RouteRegistry.PSW.DASHBOARD} element={<RequireRole allowedRoles={['psw']}><AppLayout /></RequireRole>}>
            <Route index element={<PswDashboard />} />
            <Route path={RouteRegistry.PSW.SCHEDULE} element={<PswSchedule />} />
            <Route path={RouteRegistry.PSW.OPEN_SHIFTS} element={<PswOpenShifts />} />
            <Route path={RouteRegistry.PSW.OFFERS} element={<PswOpenOffers />} />
            <Route path={RouteRegistry.PSW.AVAILABILITY} element={<PswAvailability />} />
            <Route path={RouteRegistry.PSW.EARNINGS} element={<PswEarnings />} />
            <Route path={RouteRegistry.PSW.EXPENSES} element={<PswExpenses />} />
            <Route path={RouteRegistry.PSW.SHIFT_CONFIRMATION} element={<PswShiftConfirmation />} />
            <Route path={RouteRegistry.PSW.CREDENTIALS} element={<CredentialVault />} />
            <Route path={RouteRegistry.PSW.FEED} element={<ProviderSocial />} />
            <Route path={RouteRegistry.PSW.LIVE_VISIT} element={<LiveVisit />} />
            <Route path={RouteRegistry.PSW.HANDOVER} element={<PswHandover />} />
            <Route path={RouteRegistry.PSW.PAYOUTS} element={<PswPayoutHistory />} />
        </Route>

        {/* RN PORTAL */}
        <Route path={RouteRegistry.RN.DASHBOARD} element={<RequireRole allowedRoles={['rn', 'clinical_manager']}><AppLayout /></RequireRole>}>
            <Route index element={<RnDashboard />} />
            <Route path={RouteRegistry.RN.CARE_PLANS} element={<CarePlanManager />} />
            <Route path={RouteRegistry.RN.DAILY_AUDIT} element={<EntryVerify />} />
            <Route path={RouteRegistry.RN.SUPERVISION} element={<SupervisionHub />} />
            <Route path={RouteRegistry.RN.ASSESSMENTS} element={<AssessmentsHub />} />
        </Route>

        {/* CLIENT PORTAL */}
        <Route path={RouteRegistry.CLIENT.DASHBOARD} element={<RequireRole allowedRoles={['client']}><AppLayout /></RequireRole>}>
            <Route index element={<ClientDashboard />} />
            <Route path={RouteRegistry.CLIENT.BOOKINGS} element={<ClientBookings />} />
            <Route path={RouteRegistry.CLIENT.BILLING} element={<ClientBilling />} />
            <Route path={RouteRegistry.CLIENT.FEEDBACK} element={<ClientFeedback />} />
            <Route path={RouteRegistry.CLIENT.REQUEST_BOOKING} element={<RequestBooking />} />
            <Route path={RouteRegistry.CLIENT.SERVICES} element={<CatalogBrowser />} />
            <Route path={RouteRegistry.CLIENT.SUPPORT} element={<ClientMessaging />} />
            <Route path={RouteRegistry.CLIENT.TEAM} element={<CareTeam />} />
            <Route path={RouteRegistry.CLIENT.FEEDBACK_LOOP} element={<FeedbackLoop />} />
            <Route path={RouteRegistry.CLIENT.FAMILY_HUB} element={<FamilyCareHub />} />
        </Route>

        {/* ALLIED HEALTH PORTAL */}
        <Route path={RouteRegistry.PLAN.ALLIED.DASHBOARD} element={<RequireRole allowedRoles={['rmt', 'rpt', 'rch']}><AppLayout /></RequireRole>}>
            <Route index element={<AlliedHealthDashboard />} />
        </Route>
    </>
);
