import React from 'react';
import { Route } from 'react-router';
import { AdminRegistry } from 'prime-care-shared';
import RequireRole from '@/shared/rbac/RequireRole';
import AppLayout from '@/shared/components/layout/AppLayout';
import {
    // Manager
    Portfolio, DailyEntry, UserList, Evaluations, ServiceReview, ManagerDashboard,
    TrainingHub, SurveyManager, StaffRanker, BranchPL, PayrollVerification,
    MarketingDashboard, HrRecruitmentPortal, FinanceRegionalHub, ClinicalQaDashboard,
    CoordinatorHub, DispatchMap, SosCenter, WaitlistManager, AlliedHealthDashboard,
    OperationsHub, RegionalStats, ComplianceSync, FinanceHub,
    // PSW
    PswDashboard, PswSchedule, PswOpenShifts, PswOpenOffers, PswAvailability,
    PswEarnings, PswExpenses, PswShiftConfirmation, CredentialVault, ProviderSocial,
    LiveVisit, CheckInScreen, PswHandover, PswPayoutHistory,
    // RN
    RnDashboard, CarePlanManager, EntryVerify, SupervisionHub, AssessmentsHub, RnCheckInScreen,
    // Client
    ClientDashboard, ClientBookings, ClientBilling, ClientFeedback, RequestBooking,
    CatalogBrowser, ClientMessaging, CareTeam, FeedbackLoop, FamilyCareHub,
    // Staff
    StaffDashboard, StaffTaskGrid, StaffMessageCenter, StaffIncidentPortal, StaffComplianceMonitor,
    // Scrum Master
    ResponseBotAudit,
    // Additional
    MedicalSummary, FamilyPortal, MarDashboard, MarClient, WoundCareDashboard,
    WoundCareClient, RaiAssessments, RaiAssessmentDetail, MileageTracker,
    PswTrainingHub, FleetManagement, ShiftSwap, TreatmentList, SignOff,
    // NEW PREMIUM PAGES
    GamificationHub, IoTMonitoring, DocumentSigningCenter, SMSHub,
    PerformanceReviews, TrainingAcademy, PswUserGuide,
} from './tenancyImports';

const { RouteRegistry } = AdminRegistry;

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
            {/* NEW PREMIUM PAGES */}
            <Route path="gamification" element={<GamificationHub />} />
            <Route path="iot-monitoring" element={<IoTMonitoring />} />
            <Route path="document-signing" element={<DocumentSigningCenter />} />
            <Route path="sms-hub" element={<SMSHub />} />
            <Route path="performance-reviews" element={<PerformanceReviews />} />
            <Route path="training-academy" element={<TrainingAcademy />} />
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
            <Route path="guide" element={<PswUserGuide />} />
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
