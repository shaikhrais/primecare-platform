// TenancyRoutes: all lazy imports extracted
import { lazy } from 'react';

// Manager Pages
export const Portfolio = lazy(() => import('./manager/pages/portfolio').then(m => ({ default: Object.values(m)[0] as any })));
export const DailyEntry = lazy(() => import('./manager/pages/daily-entry').then(m => ({ default: Object.values(m)[0] as any })));
export const UserList = lazy(() => import('../platform/admin/pages/users').then(m => ({ default: m.UserList  })));
export const Evaluations = lazy(() => import('./manager/pages/evaluations').then(m => ({ default: Object.values(m)[0] as any })));
export const ServiceReview = lazy(() => import('./manager/pages/service-review').then(m => ({ default: Object.values(m)[0] as any })));
export const ManagerDashboard = lazy(() => import('./manager/pages/dashboard').then(m => ({ default: Object.values(m)[0] as any })));
export const TrainingHub = lazy(() => import('./manager/pages/training').then(m => ({ default: Object.values(m)[0] as any })));
export const SurveyManager = lazy(() => import('./manager/pages/surveys').then(m => ({ default: Object.values(m)[0] as any })));
export const StaffRanker = lazy(() => import('./manager/pages/performance/T23-StaffRanker'));
export const BranchPL = lazy(() => import('./manager/pages/finance/D9-BranchPL'));
export const PayrollVerification = lazy(() => import('./manager/pages/finance/T24-PayrollVerification'));
export const MarketingDashboard = lazy(() => import('./marketing/D11-MarketingDashboard'));
export const HrRecruitmentPortal = lazy(() => import('./hr/H13-HrRecruitmentPortal'));
export const FinanceRegionalHub = lazy(() => import('./finance/D12-FinanceRegionalHub'));
export const ClinicalQaDashboard = lazy(() => import('./qa/D13-ClinicalQaDashboard'));
export const CoordinatorHub = lazy(() => import('./coordinator/pages/hub/H18-CoordinatorHub'));
export const DispatchMap = lazy(() => import('./coordinator/pages/map').then(m => ({ default: Object.values(m)[0] as any })));
export const SosCenter = lazy(() => import('./coordinator/pages/sos').then(m => ({ default: Object.values(m)[0] as any })));
export const WaitlistManager = lazy(() => import('./coordinator/pages/waitlist').then(m => ({ default: Object.values(m)[0] as any })));
export const AlliedHealthDashboard = lazy(() => import('./allied-health/D18-AlliedHealthDashboard'));
export const OperationsHub = lazy(() => import('./manager/pages/operations').then(m => ({ default: Object.values(m)[0] as any })));
export const RegionalStats = lazy(() => import('./manager/pages/D10-RegionalStats'));
export const ComplianceSync = lazy(() => import('./manager/pages/compliance').then(m => ({ default: Object.values(m)[0] as any })));
export const FinanceHub = lazy(() => import('./manager/pages/finance/D9-BranchPL'));

// PSW Pages
export const PswDashboard = lazy(() => import('./psw/pages/dashboard').then(m => ({ default: Object.values(m)[0] as any })));
export const PswSchedule = lazy(() => import('./psw/pages/schedule').then(m => ({ default: Object.values(m)[0] as any })));
export const PswOpenShifts = lazy(() => import('./psw/pages/OpenShifts').then(m => ({ default: Object.values(m)[0] as any })));
export const PswOpenOffers = lazy(() => import('./psw/pages/OpenShifts').then(m => ({ default: Object.values(m)[0] as any })));
export const PswAvailability = lazy(() => import('./psw/pages/availability').then(m => ({ default: Object.values(m)[0] as any })));
export const PswEarnings = lazy(() => import('./psw/pages/earnings').then(m => ({ default: Object.values(m)[0] as any })));
export const PswExpenses = lazy(() => import('./psw/pages/expenses').then(m => ({ default: Object.values(m)[0] as any })));
export const PswShiftConfirmation = lazy(() => import('./psw/pages/shift-confirmation').then(m => ({ default: Object.values(m)[0] as any })));
export const CredentialVault = lazy(() => import('./psw/pages/credentials/H14-CredentialVault'));
export const ProviderSocial = lazy(() => import('./psw/pages/feed/T27-ProviderSocial'));
export const LiveVisit = lazy(() => import('./psw/pages/schedule').then(m => ({ default: Object.values(m)[0] as any })));
export const CheckInScreen = lazy(() => import('./psw/pages/schedule').then(m => ({ default: Object.values(m)[0] as any })));
export const PswHandover = lazy(() => import('./psw/pages/handover').then(m => ({ default: Object.values(m)[0] as any })));
export const PswPayoutHistory = lazy(() => import('./psw/pages/payouts').then(m => ({ default: Object.values(m)[0] as any })));

// RN Pages
export const RnDashboard = lazy(() => import('./rn/pages/dashboard').then(m => ({ default: Object.values(m)[0] as any })));
export const CarePlanManager = lazy(() => import('./rn/pages/care-plans').then(m => ({ default: Object.values(m)[0] as any })));
export const EntryVerify = lazy(() => import('./rn/pages/audit').then(m => ({ default: Object.values(m)[0] as any })));
export const SupervisionHub = lazy(() => import('./rn/pages/supervision').then(m => ({ default: Object.values(m)[0] as any })));
export const AssessmentsHub = lazy(() => import('./rn/pages/assessments').then(m => ({ default: Object.values(m)[0] as any })));
export const RnCheckInScreen = lazy(() => import('./rn/pages/schedule/T63-RnCheckInScreen'));

// Client Pages
export const ClientDashboard = lazy(() => import('./client/pages/dashboard').then(m => ({ default: Object.values(m)[0] as any })));
export const ClientBookings = lazy(() => import('./client/pages/bookings').then(m => ({ default: Object.values(m)[0] as any })));
export const ClientBilling = lazy(() => import('./client/pages/billing'));
export const ClientFeedback = lazy(() => import('./client/pages/feedback').then(m => ({ default: Object.values(m)[0] as any })));
export const RequestBooking = lazy(() => import('./client/pages/request-booking').then(m => ({ default: Object.values(m)[0] as any })));
export const CatalogBrowser = lazy(() => import('./client/pages/services/T34-CatalogBrowser'));
export const ClientMessaging = lazy(() => import('./client/pages/support/T35-ClientMessaging'));
export const CareTeam = lazy(() => import('./client/pages/team/T36-TeamRoster'));
export const FeedbackLoop = lazy(() => import('./client/pages/support/T37-FeedbackLoop'));
export const FamilyCareHub = lazy(() => import('./client/pages/engagement/H17-FamilyCareHub'));

// Staff Pages
export const StaffDashboard = lazy(() => import('./staff/pages/dashboard').then(m => ({ default: Object.values(m)[0] as any })));
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
export const WoundCareDashboard = lazy(() => import('./rn/pages/wound-care'));
export const WoundCareClient = lazy(() => import('./rn/pages/wound-care'));
export const RaiAssessments = lazy(() => import('./rn/pages/rai/L19-RaiAssessments'));
export const RaiAssessmentDetail = lazy(() => import('./rn/pages/rai/T33-RaiAssessmentDetail'));
export const MileageTracker = lazy(() => import('./psw/pages/mileage/T28-MileageTracker'));
export const PswTrainingHub = lazy(() => import('./psw/pages/training/H15-PswTrainingHub'));
export const FleetManagement = lazy(() => import('./coordinator/pages/fleet/T40-FleetManagement'));
export const ShiftSwap = lazy(() => import('./coordinator/pages/shift-swap/T41-ShiftSwap'));
export const TreatmentList = lazy(() => import('./allied-health/pages/treatments/L21-TreatmentList'));
export const SignOff = lazy(() => import('./allied-health/pages/sign-off/T42-SignOff'));

// ── NEW PREMIUM PAGES (Session Sprint 3-6) ──
export const GamificationHub = lazy(() => import('./manager/pages/engagement/H19-GamificationHub'));
export const IoTMonitoring = lazy(() => import('./manager/pages/iot/H20-IoTMonitoring'));
export const DocumentSigningCenter = lazy(() => import('./manager/pages/documents/H21-DocumentSigningCenter'));
export const SMSHub = lazy(() => import('../platform/admin/pages/communications/H22-SMSHub'));
export const PerformanceReviews = lazy(() => import('./manager/pages/hr/L15-PerformanceReviews'));
export const TrainingAcademy = lazy(() => import('./manager/pages/training').then(m => ({ default: m.TrainingAcademy })));
export const PswUserGuide = lazy(() => import('./psw/pages/guide/G1-PswUserGuide'));
