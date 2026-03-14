// TenancyRoutes: all lazy imports extracted
import { lazy } from 'react';

// Manager Pages
export const Portfolio = lazy(() => import('./manager/pages/portfolio/T19-Portfolio'));
export const DailyEntry = lazy(() => import('./manager/pages/daily-entry/T20-DailyEntry'));
export const UserList = lazy(() => import('../platform/admin/pages/users/L3a-UserList'));
export const Evaluations = lazy(() => import('./manager/pages/evaluations/L13-Evaluations'));
export const ServiceReview = lazy(() => import('./manager/pages/service-review/T21-ServiceReview'));
export const ManagerDashboard = lazy(() => import('./manager/pages/dashboard/D7-ManagerDashboard'));
export const TrainingHub = lazy(() => import('./manager/pages/training/H11-TrainingHub'));
export const SurveyManager = lazy(() => import('./manager/pages/surveys/T22-SurveyManager'));
export const StaffRanker = lazy(() => import('./manager/pages/performance/T23-StaffRanker'));
export const BranchPL = lazy(() => import('./manager/pages/finance/D9-BranchPL'));
export const PayrollVerification = lazy(() => import('./manager/pages/finance/T24-PayrollVerification'));
export const MarketingDashboard = lazy(() => import('./marketing/D11-MarketingDashboard'));
export const HrRecruitmentPortal = lazy(() => import('./hr/H13-HrRecruitmentPortal'));
export const FinanceRegionalHub = lazy(() => import('./finance/D12-FinanceRegionalHub'));
export const ClinicalQaDashboard = lazy(() => import('./qa/D13-ClinicalQaDashboard'));
export const CoordinatorHub = lazy(() => import('./coordinator/pages/hub/H18-CoordinatorHub'));
export const DispatchMap = lazy(() => import('./coordinator/pages/map/T38-DispatchMap'));
export const SosCenter = lazy(() => import('./coordinator/pages/sos/T39-SosCenter'));
export const WaitlistManager = lazy(() => import('./coordinator/pages/waitlist/L20-WaitlistManager'));
export const AlliedHealthDashboard = lazy(() => import('./allied-health/D18-AlliedHealthDashboard'));
export const OperationsHub = lazy(() => import('./manager/pages/operations/H12-OperationsHub'));
export const RegionalStats = lazy(() => import('./manager/pages/D10-RegionalStats'));
export const ComplianceSync = lazy(() => import('./manager/pages/compliance/T25-ComplianceSync'));
export const FinanceHub = lazy(() => import('./manager/pages/finance/D9-BranchPL'));

// PSW Pages
export const PswDashboard = lazy(() => import('./psw/pages/dashboard/D14-PswDashboard'));
export const PswSchedule = lazy(() => import('./psw/pages/schedule/L16-PswSchedule'));
export const PswOpenShifts = lazy(() => import('./psw/pages/OpenShifts/L17-OpenShifts'));
export const PswOpenOffers = lazy(() => import('./psw/pages/OpenShifts/T60-OpenOffers'));
export const PswAvailability = lazy(() => import('./psw/pages/availability/F15-Availability'));
export const PswEarnings = lazy(() => import('./psw/pages/earnings/R3-PswEarnings'));
export const PswExpenses = lazy(() => import('./psw/pages/expenses/F14-ExpenseClaim'));
export const PswShiftConfirmation = lazy(() => import('./psw/pages/shift-confirmation/T26-ShiftConfirmation'));
export const CredentialVault = lazy(() => import('./psw/pages/credentials/H14-CredentialVault'));
export const ProviderSocial = lazy(() => import('./psw/pages/feed/T27-ProviderSocial'));
export const LiveVisit = lazy(() => import('./psw/pages/schedule/T61-LiveVisit'));
export const CheckInScreen = lazy(() => import('./psw/pages/schedule/T62-CheckInScreen'));
export const PswHandover = lazy(() => import('./psw/pages/handover/F13-ShiftHandover'));
export const PswPayoutHistory = lazy(() => import('./psw/pages/payouts/R4-PayoutHistory'));

// RN Pages
export const RnDashboard = lazy(() => import('./rn/pages/dashboard/D15-RnDashboard'));
export const CarePlanManager = lazy(() => import('./rn/pages/care-plans/T29-CarePlanManager'));
export const EntryVerify = lazy(() => import('./rn/pages/audit/T30-EntryVerify'));
export const SupervisionHub = lazy(() => import('./rn/pages/supervision/H16-SupervisionHub'));
export const AssessmentsHub = lazy(() => import('./rn/pages/assessments/L18-AssessmentsHub'));
export const RnCheckInScreen = lazy(() => import('./rn/pages/schedule/T63-RnCheckInScreen'));

// Client Pages
export const ClientDashboard = lazy(() => import('./client/pages/dashboard/D8-ClientDashboard'));
export const ClientBookings = lazy(() => import('./client/pages/bookings/L14-ClientBookings'));
export const ClientBilling = lazy(() => import('./client/pages/billing/H10-BillingHub'));
export const ClientFeedback = lazy(() => import('./client/pages/feedback/F16-SubmitFeedback'));
export const RequestBooking = lazy(() => import('./client/pages/request-booking/F17-RequestBooking'));
export const CatalogBrowser = lazy(() => import('./client/pages/services/T34-CatalogBrowser'));
export const ClientMessaging = lazy(() => import('./client/pages/support/T35-ClientMessaging'));
export const CareTeam = lazy(() => import('./client/pages/team/T36-TeamRoster'));
export const FeedbackLoop = lazy(() => import('./client/pages/support/T37-FeedbackLoop'));
export const FamilyCareHub = lazy(() => import('./client/pages/engagement/H17-FamilyCareHub'));

// Staff Pages
export const StaffDashboard = lazy(() => import('./staff/pages/dashboard/D19-StaffDashboard'));
export const StaffTaskGrid = lazy(() => import('./staff/pages/tasks/T43-TaskGrid'));
export const StaffMessageCenter = lazy(() => import('./staff/pages/messages/T44-MessageCenter'));
export const StaffIncidentPortal = lazy(() => import('./staff/pages/operations/T45-IncidentPortal'));
export const StaffComplianceMonitor = lazy(() => import('./staff/pages/operations/T46-ComplianceMonitor'));

// Scrum Master
export const ResponseBotAudit = lazy(() => import('./scrum-master/pages/T47-ResponseBotAudit'));

// Additional Pages
export const MedicalSummary = lazy(() => import('./client/pages/medical/R5-MedicalSummary'));
export const FamilyPortal = lazy(() => import('./client/pages/family/P1-FamilyPortal'));
export const MarDashboard = lazy(() => import('./rn/pages/mar/D16-MarDashboard'));
export const MarClient = lazy(() => import('./rn/pages/mar/T31-MarClient'));
export const WoundCareDashboard = lazy(() => import('./rn/pages/wound-care/D17-WoundCareDashboard'));
export const WoundCareClient = lazy(() => import('./rn/pages/wound-care/T32-WoundCareClient'));
export const RaiAssessments = lazy(() => import('./rn/pages/rai/L19-RaiAssessments'));
export const RaiAssessmentDetail = lazy(() => import('./rn/pages/rai/T33-RaiAssessmentDetail'));
export const MileageTracker = lazy(() => import('./psw/pages/mileage/T28-MileageTracker'));
export const PswTrainingHub = lazy(() => import('./psw/pages/training/H15-PswTrainingHub'));
export const FleetManagement = lazy(() => import('./coordinator/pages/fleet/T40-FleetManagement'));
export const ShiftSwap = lazy(() => import('./coordinator/pages/shift-swap/T41-ShiftSwap'));
export const TreatmentList = lazy(() => import('./allied-health/pages/treatments/L21-TreatmentList'));
export const SignOff = lazy(() => import('./allied-health/pages/sign-off/T42-SignOff'));
