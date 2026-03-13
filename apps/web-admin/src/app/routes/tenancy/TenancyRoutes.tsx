import React, { lazy } from 'react';
import { Route } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import RequireRole from '@/shared/rbac/RequireRole';
import AppLayout from '@/shared/components/layout/AppLayout';

const { RouteRegistry } = AdminRegistry;

// Manager Pages
const Portfolio = lazy(() => import('./manager/pages/portfolio/T19-Portfolio'));
const DailyEntry = lazy(() => import('./manager/pages/daily-entry/T20-DailyEntry'));
const UserList = lazy(() => import('../platform/admin/pages/users').then(m => ({ default: m.UserList })));
const Evaluations = lazy(() => import('./manager/pages/evaluations/L13-Evaluations'));
const ServiceReview = lazy(() => import('./manager/pages/service-review/T21-ServiceReview'));
const ManagerDashboard = lazy(() => import('./manager/pages/dashboard/D7-ManagerDashboard'));
const TrainingHub = lazy(() => import('./manager/pages/training/H11-TrainingHub'));
const SurveyManager = lazy(() => import('./manager/pages/surveys/T22-SurveyManager'));
const StaffRanker = lazy(() => import('./manager/pages/performance/T23-StaffRanker'));
const BranchPL = lazy(() => import('./manager/pages/finance/D9-BranchPL'));
const PayrollVerification = lazy(() => import('./manager/pages/finance/T24-PayrollVerification'));
const MarketingDashboard = lazy(() => import('./marketing/D11-MarketingDashboard'));
const HrRecruitmentPortal = lazy(() => import('./hr/H13-HrRecruitmentPortal'));
const FinanceRegionalHub = lazy(() => import('./finance/D12-FinanceRegionalHub'));
const ClinicalQaDashboard = lazy(() => import('./qa/D13-ClinicalQaDashboard'));
const CoordinatorHub = lazy(() => import('./coordinator/pages/hub/H18-CoordinatorHub'));
const DispatchMap = lazy(() => import('./coordinator/pages/map/T38-DispatchMap'));
const SosCenter = lazy(() => import('./coordinator/pages/sos/T39-SosCenter'));
const WaitlistManager = lazy(() => import('./coordinator/pages/waitlist/L20-WaitlistManager'));
const AlliedHealthDashboard = lazy(() => import('./allied-health/D18-AlliedHealthDashboard'));
const OperationsHub = lazy(() => import('./manager/pages/operations/H12-OperationsHub'));
const RegionalStats = lazy(() => import('./manager/pages/D10-RegionalStats'));
const ComplianceSync = lazy(() => import('./manager/pages/compliance/T25-ComplianceSync'));
const FinanceHub = lazy(() => import('./manager/pages/finance/D9-BranchPL'));

// PSW Pages
const PswDashboard = lazy(() => import('./psw/pages/dashboard/D14-PswDashboard'));
const PswSchedule = lazy(() => import('./psw/pages/schedule/L16-PswSchedule'));
const PswOpenShifts = lazy(() => import('./psw/pages/OpenShifts/L17-OpenShifts'));
const PswOpenOffers = lazy(() => import('./psw/pages/OpenShifts/OpenOffers'));
const PswAvailability = lazy(() => import('./psw/pages/availability/F15-Availability'));
const PswEarnings = lazy(() => import('./psw/pages/earnings/R3-PswEarnings'));
const PswExpenses = lazy(() => import('./psw/pages/expenses'));
const PswShiftConfirmation = lazy(() => import('./psw/pages/shift-confirmation/T26-ShiftConfirmation'));
const CredentialVault = lazy(() => import('./psw/pages/credentials/H14-CredentialVault'));
const ProviderSocial = lazy(() => import('./psw/pages/feed/T27-ProviderSocial'));
const LiveVisit = lazy(() => import('./psw/pages/schedule/LiveVisit'));
const CheckInScreen = lazy(() => import('./psw/pages/schedule/CheckInScreen'));
const PswHandover = lazy(() => import('./psw/pages/handover'));
const PswPayoutHistory = lazy(() => import('./psw/pages/payouts/R4-PayoutHistory'));

// RN Pages
const RnDashboard = lazy(() => import('./rn/pages/dashboard/D15-RnDashboard'));
const CarePlanManager = lazy(() => import('./rn/pages/care-plans/T29-CarePlanManager'));
const EntryVerify = lazy(() => import('./rn/pages/audit/T30-EntryVerify'));
const SupervisionHub = lazy(() => import('./rn/pages/supervision/H16-SupervisionHub'));
const AssessmentsHub = lazy(() => import('./rn/pages/assessments/L18-AssessmentsHub'));
const RnCheckInScreen = lazy(() => import('./rn/pages/schedule/RnCheckInScreen'));

// Client Pages
const ClientDashboard = lazy(() => import('./client/pages/dashboard/D8-ClientDashboard'));
const ClientBookings = lazy(() => import('./client/pages/bookings/L14-ClientBookings'));
const ClientBilling = lazy(() => import('./client/pages/billing/H10-BillingHub'));
const ClientFeedback = lazy(() => import('./client/pages/feedback'));
const RequestBooking = lazy(() => import('./client/pages/request-booking/F17-RequestBooking'));
const CatalogBrowser = lazy(() => import('./client/pages/services/T34-CatalogBrowser'));
const ClientMessaging = lazy(() => import('./client/pages/support/T35-ClientMessaging'));
const CareTeam = lazy(() => import('./client/pages/team/T36-TeamRoster'));
const FeedbackLoop = lazy(() => import('./client/pages/support/T37-FeedbackLoop'));
const FamilyCareHub = lazy(() => import('./client/pages/engagement/H17-FamilyCareHub'));

// Staff Pages
const StaffDashboard = lazy(() => import('./staff/pages/dashboard/D19-StaffDashboard'));
const StaffTaskGrid = lazy(() => import('./staff/pages/tasks/T43-TaskGrid'));
const StaffMessageCenter = lazy(() => import('./staff/pages/messages/T44-MessageCenter'));
const StaffIncidentPortal = lazy(() => import('./staff/pages/operations/T45-IncidentPortal'));
const StaffComplianceMonitor = lazy(() => import('./staff/pages/operations/T46-ComplianceMonitor'));

// Scrum Master Pages
const ResponseBotAudit = lazy(() => import('./scrum-master/pages/T47-ResponseBotAudit'));

const MedicalSummary = lazy(() => import('./client/pages/medical/R5-MedicalSummary'));
const FamilyPortal = lazy(() => import('./client/pages/family/P1-FamilyPortal'));
const MarDashboard = lazy(() => import('./rn/pages/mar/D16-MarDashboard'));
const MarClient = lazy(() => import('./rn/pages/mar/T31-MarClient'));
const WoundCareDashboard = lazy(() => import('./rn/pages/wound-care/D17-WoundCareDashboard'));
const WoundCareClient = lazy(() => import('./rn/pages/wound-care/T32-WoundCareClient'));
const RaiAssessments = lazy(() => import('./rn/pages/rai/L19-RaiAssessments'));
const RaiAssessmentDetail = lazy(() => import('./rn/pages/rai/T33-RaiAssessmentDetail'));
const MileageTracker = lazy(() => import('./psw/pages/mileage/T28-MileageTracker'));
const PswTrainingHub = lazy(() => import('./psw/pages/training/H15-PswTrainingHub'));
const FleetManagement = lazy(() => import('./coordinator/pages/fleet/T40-FleetManagement'));
const ShiftSwap = lazy(() => import('./coordinator/pages/shift-swap/T41-ShiftSwap'));
const TreatmentList = lazy(() => import('./allied-health/pages/treatments/L21-TreatmentList'));
const SignOff = lazy(() => import('./allied-health/pages/sign-off/T42-SignOff'));

export const TenancyRoutes = () => (
    <>
        {/* MANAGER PORTAL */}
        <Route path={`${RouteRegistry.MANAGER.DASHBOARD}/*`} element={<RequireRole allowedRoles={['manager', 'operations_manager', 'clinical_manager']}><AppLayout /></RequireRole>}>
            <Route index element={<ManagerDashboard />} />
            <Route path="operations" element={<OperationsHub />} />
            <Route path="regional-stats" element={<RegionalStats />} />
            <Route path="compliance" element={<ComplianceSync />} />
            <Route path="finance" element={<FinanceHub />} />
            <Route path="performance" element={<StaffRanker />} />
            <Route path="portfolio" element={<Portfolio />} />
            <Route path="training" element={<TrainingHub />} />
            <Route path="surveys" element={<SurveyManager />} />
            <Route path="evaluations" element={<Evaluations />} />
            <Route path="service-review" element={<ServiceReview />} />
            <Route path="daily-entry" element={<DailyEntry />} />
            <Route path="team" element={<UserList />} />
        </Route>

        {/* MARKETING PORTAL */}
        <Route path={`${RouteRegistry.MANAGER.MARKETING}/*`} element={<RequireRole allowedRoles={['marketing_manager']}><AppLayout /></RequireRole>}>
            <Route index element={<MarketingDashboard />} />
        </Route>

        {/* HR & RECRUITMENT PORTAL */}
        <Route path={`${RouteRegistry.MANAGER.RECRUITING}/*`} element={<RequireRole allowedRoles={['hr_manager', 'recruiting_manager']}><AppLayout /></RequireRole>}>
            <Route index element={<HrRecruitmentPortal />} />
        </Route>

        {/* FINANCE & REGIONAL HUB - FOR REGIONAL MANAGERS */}
        <Route path={`${RouteRegistry.MANAGER.FINANCE}/*`} element={<RequireRole allowedRoles={['finance_manager', 'regional_manager']}><AppLayout /></RequireRole>}>
            <Route index element={<FinanceRegionalHub />} />
        </Route>

        {/* CLINICAL QA DASHBOARD */}
        <Route path={`${RouteRegistry.MANAGER.CLINICAL}/*`} element={<RequireRole allowedRoles={['clinical_manager']}><AppLayout /></RequireRole>}>
            <Route index element={<ClinicalQaDashboard />} />
        </Route>

        {/* COORDINATOR PORTAL */}
        <Route path={`${RouteRegistry.COORDINATOR.DASHBOARD}/*`} element={<RequireRole allowedRoles={['coordinator', 'operations_manager']}><AppLayout /></RequireRole>}>
            <Route index element={<CoordinatorHub />} />
            <Route path="hub" element={<CoordinatorHub />} />
            <Route path="dispatch-map" element={<DispatchMap />} />
            <Route path="waitlist" element={<WaitlistManager />} />
            <Route path="sos-center" element={<SosCenter />} />
            <Route path="schedule" element={<CoordinatorHub />} />
        </Route>

        {/* PSW / PROVIDER PORTAL */}
        <Route path={`${RouteRegistry.PSW.DASHBOARD}/*`} element={<RequireRole allowedRoles={['psw']}><AppLayout /></RequireRole>}>
            <Route index element={<PswDashboard />} />
            <Route path="schedule" element={<PswSchedule />} />
            <Route path="open-shifts" element={<PswOpenShifts />} />
            <Route path="offers" element={<PswOpenOffers />} />
            <Route path="availability" element={<PswAvailability />} />
            <Route path="earnings" element={<PswEarnings />} />
            <Route path="expenses" element={<PswExpenses />} />
            <Route path="shift-confirmation" element={<PswShiftConfirmation />} />
            <Route path="credentials" element={<CredentialVault />} />
            <Route path="feed" element={<ProviderSocial />} />
            <Route path="live-visit/:id" element={<LiveVisit />} />
            <Route path="check-in/:id" element={<CheckInScreen />} />
            <Route path="handover" element={<PswHandover />} />
            <Route path="payouts" element={<PswPayoutHistory />} />
        </Route>

        {/* RN PORTAL */}
        <Route path={`${RouteRegistry.RN.DASHBOARD}/*`} element={<RequireRole allowedRoles={['rn', 'clinical_manager']}><AppLayout /></RequireRole>}>
            <Route index element={<RnDashboard />} />
            <Route path="care-plans" element={<CarePlanManager />} />
            <Route path="entry-verify" element={<EntryVerify />} />
            <Route path="supervision" element={<SupervisionHub />} />
            <Route path="assessments" element={<AssessmentsHub />} />
            <Route path="check-in/:id" element={<RnCheckInScreen />} />
        </Route>

        {/* CLIENT PORTAL */}
        <Route path={`${RouteRegistry.CLIENT.DASHBOARD}/*`} element={<RequireRole allowedRoles={['client']}><AppLayout /></RequireRole>}>
            <Route index element={<ClientDashboard />} />
            <Route path="bookings" element={<ClientBookings />} />
            <Route path="billing" element={<ClientBilling />} />
            <Route path="feedback" element={<ClientFeedback />} />
            <Route path="request-booking" element={<RequestBooking />} />
            <Route path="services" element={<CatalogBrowser />} />
            <Route path="support" element={<ClientMessaging />} />
            <Route path="team" element={<CareTeam />} />
            <Route path="feedback-loop" element={<FeedbackLoop />} />
            <Route path="family-hub" element={<FamilyCareHub />} />
        </Route>

        {/* ALLIED HEALTH PORTAL */}
        <Route path={`${RouteRegistry.ALLIED.DASHBOARD}/*`} element={<RequireRole allowedRoles={['rmt', 'rpt', 'rch']}><AppLayout /></RequireRole>}>
            <Route index element={<AlliedHealthDashboard />} />
        </Route>

        {/* STAFF PORTAL */}
        <Route path={`${RouteRegistry.STAFF.DASHBOARD}/*`} element={<RequireRole allowedRoles={['staff', 'admin']}><AppLayout /></RequireRole>}>
            <Route index element={<StaffDashboard />} />
            <Route path="customers" element={<UserList />} />
            <Route path="tasks" element={<StaffTaskGrid />} />
            <Route path="messages" element={<StaffMessageCenter />} />
            <Route path="incidents" element={<StaffIncidentPortal />} />
            <Route path="compliance" element={<StaffComplianceMonitor />} />
        </Route>


    
        {/* NEWLY GENERATED STUB PAGES (Absolute Paths) */}
        <Route element={<RequireRole allowedRoles={['admin', 'client', 'rn', 'psw', 'coordinator', 'rmt', 'rpt', 'rch']}><AppLayout /></RequireRole>}>
            <Route path={RouteRegistry.CLIENT.MEDICAL_SUMMARY} element={<MedicalSummary />} />
            <Route path={RouteRegistry.CLIENT.FAMILY_PORTAL} element={<FamilyPortal />} />
            <Route path={RouteRegistry.RN.MAR} element={<MarDashboard />} />
            <Route path={RouteRegistry.RN.MAR_CLIENT(':clientId')} element={<MarClient />} />
            <Route path={RouteRegistry.RN.WOUND_CARE} element={<WoundCareDashboard />} />
            <Route path={RouteRegistry.RN.WOUND_CARE_CLIENT(':clientId')} element={<WoundCareClient />} />
            <Route path={RouteRegistry.RN.RAI_ASSESSMENTS} element={<RaiAssessments />} />
            <Route path={RouteRegistry.RN.RAI_ASSESSMENT_DETAIL(':id')} element={<RaiAssessmentDetail />} />
            <Route path={RouteRegistry.PSW.MILEAGE} element={<MileageTracker />} />
            <Route path={RouteRegistry.PSW.TRAINING} element={<PswTrainingHub />} />
            <Route path={RouteRegistry.COORDINATOR.FLEET} element={<FleetManagement />} />
            <Route path={RouteRegistry.COORDINATOR.SHIFT_SWAP} element={<ShiftSwap />} />
            <Route path={RouteRegistry.ALLIED.TREATMENTS} element={<TreatmentList />} />
            <Route path={RouteRegistry.ALLIED.SIGN_OFF} element={<SignOff />} />
        </Route>

    </>
);
