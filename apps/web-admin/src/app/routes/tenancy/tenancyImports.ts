// TenancyRoutes: all lazy imports extracted
import { lazy } from 'react';

// Manager Pages
export const Portfolio = lazy(() => import('./manager/portfolio').then(m => ({ default: Object.values(m)[0] as any })));
export const DailyEntry = lazy(() => import('./manager/daily-entry').then(m => ({ default: Object.values(m)[0] as any })));
export const UserList = lazy(() => import('../platform/admin/users').then(m => ({ default: m.UserList  })));
export const Evaluations = lazy(() => import('./manager/evaluations').then(m => ({ default: Object.values(m)[0] as any })));
export const ServiceReview = lazy(() => import('./manager/service-review').then(m => ({ default: Object.values(m)[0] as any })));
export const ManagerDashboard = lazy(() => import('./manager/dashboard').then(m => ({ default: Object.values(m)[0] as any })));
export const TrainingHub = lazy(() => import('./manager/training').then(m => ({ default: Object.values(m)[0] as any })));
export const SurveyManager = lazy(() => import('./manager/surveys').then(m => ({ default: Object.values(m)[0] as any })));
export const StaffRanker = lazy(() => import('./manager/performance').then(m => ({ default: Object.values(m)[0] as any })));
export const BranchPL = lazy(() => import('./manager/finance').then(m => ({ default: m.BranchPL })));
export const PayrollVerification = lazy(() => import('./manager/finance').then(m => ({ default: m.PayrollVerification })));
export const MarketingDashboard = lazy(() => import('./marketing').then(m => ({ default: Object.values(m)[0] as any })));
export const HrRecruitmentPortal = lazy(() => import('./hr').then(m => ({ default: Object.values(m)[0] as any })));
export const FinanceRegionalHub = lazy(() => import('./finance').then(m => ({ default: Object.values(m)[0] as any })));
export const ClinicalQaDashboard = lazy(() => import('./qa').then(m => ({ default: Object.values(m)[0] as any })));
export const CoordinatorHub = lazy(() => import('./coordinator/pages/hub').then(m => ({ default: Object.values(m)[0] as any })));
export const DispatchMap = lazy(() => import('./coordinator/pages/map').then(m => ({ default: Object.values(m)[0] as any })));
export const SosCenter = lazy(() => import('./coordinator/pages/sos').then(m => ({ default: Object.values(m)[0] as any })));
export const WaitlistManager = lazy(() => import('./coordinator/pages/waitlist').then(m => ({ default: Object.values(m)[0] as any })));
export const AlliedHealthDashboard = lazy(() => import('./allied-health').then(m => ({ default: Object.values(m)[0] as any })));
export const OperationsHub = lazy(() => import('./manager/operations').then(m => ({ default: Object.values(m)[0] as any })));
export const RegionalStats = lazy(() => import('./manager/pages').then(m => ({ default: Object.values(m)[0] as any })));
export const ComplianceSync = lazy(() => import('./manager/compliance').then(m => ({ default: Object.values(m)[0] as any })));
export const FinanceHub = lazy(() => import('./manager/finance').then(m => ({ default: Object.values(m)[0] as any })));

// PSW Pages
export const PswDashboard = lazy(() => import('./staff/pages/dashboard').then(m => ({ default: Object.values(m)[0] as any })));
export const PswSchedule = lazy(() => import('./rn/pages/schedule').then(m => ({ default: Object.values(m)[0] as any })));
export const PswOpenShifts = lazy(() => import('./psw/pages/OpenShifts').then(m => ({ default: Object.values(m)[0] as any })));
export const PswOpenOffers = lazy(() => import('./psw/pages/OpenShifts').then(m => ({ default: Object.values(m)[0] as any })));
export const PswAvailability = lazy(() => import('./psw/pages/availability').then(m => ({ default: Object.values(m)[0] as any })));
export const PswEarnings = lazy(() => import('./psw/pages/earnings').then(m => ({ default: Object.values(m)[0] as any })));
export const PswExpenses = lazy(() => import('./psw/pages/expenses').then(m => ({ default: Object.values(m)[0] as any })));
export const PswShiftConfirmation = lazy(() => import('./psw/pages/shift-confirmation').then(m => ({ default: Object.values(m)[0] as any })));
export const CredentialVault = lazy(() => import('./psw/pages/credentials').then(m => ({ default: Object.values(m)[0] as any })));
export const ProviderSocial = lazy(() => import('./psw/pages/feed').then(m => ({ default: Object.values(m)[0] as any })));
export const LiveVisit = lazy(() => import('./rn/pages/schedule').then(m => ({ default: Object.values(m)[0] as any })));
export const CheckInScreen = lazy(() => import('./rn/pages/schedule').then(m => ({ default: Object.values(m)[0] as any })));
export const PswHandover = lazy(() => import('./psw/pages/handover').then(m => ({ default: Object.values(m)[0] as any })));
export const PswPayoutHistory = lazy(() => import('./psw/pages/payouts').then(m => ({ default: Object.values(m)[0] as any })));

// RN Pages
export const RnDashboard = lazy(() => import('./staff/pages/dashboard').then(m => ({ default: Object.values(m)[0] as any })));
export const CarePlanManager = lazy(() => import('./rn/pages/care-plans').then(m => ({ default: Object.values(m)[0] as any })));
export const EntryVerify = lazy(() => import('./rn/pages/audit').then(m => ({ default: Object.values(m)[0] as any })));
export const SupervisionHub = lazy(() => import('./rn/pages/supervision').then(m => ({ default: Object.values(m)[0] as any })));
export const AssessmentsHub = lazy(() => import('./rn/pages/assessments').then(m => ({ default: Object.values(m)[0] as any })));
export const RnCheckInScreen = lazy(() => import('./rn/pages/schedule').then(m => ({ default: Object.values(m)[0] as any })));

// Client Pages
export const ClientDashboard = lazy(() => import('./staff/pages/dashboard').then(m => ({ default: Object.values(m)[0] as any })));
export const ClientBookings = lazy(() => import('./client/pages/bookings').then(m => ({ default: Object.values(m)[0] as any })));
export const ClientBilling = lazy(() => import('./client/pages/billing'));
export const ClientFeedback = lazy(() => import('./client/pages/feedback').then(m => ({ default: Object.values(m)[0] as any })));
export const RequestBooking = lazy(() => import('./client/pages/request-booking').then(m => ({ default: Object.values(m)[0] as any })));
export const CatalogBrowser = lazy(() => import('./client/pages/services').then(m => ({ default: Object.values(m)[0] as any })));
export const ClientMessaging = lazy(() => import('./client/pages/support').then(m => ({ default: m.ClientMessaging })));
export const CareTeam = lazy(() => import('./client/pages/team').then(m => ({ default: Object.values(m)[0] as any })));
export const FeedbackLoop = lazy(() => import('./client/pages/support').then(m => ({ default: m.FeedbackLoop })));
export const FamilyCareHub = lazy(() => import('./manager/engagement').then(m => ({ default: Object.values(m)[0] as any })));

// Staff Pages
export const StaffDashboard = lazy(() => import('./staff/pages/dashboard').then(m => ({ default: Object.values(m)[0] as any })));
export const StaffTaskGrid = lazy(() => import('./staff/pages/tasks').then(m => ({ default: Object.values(m)[0] as any })));
export const StaffMessageCenter = lazy(() => import('./staff/pages/messages').then(m => ({ default: Object.values(m)[0] as any })));
export const StaffIncidentPortal = lazy(() => import('./staff/pages/operations').then(m => ({ default: m.IncidentPortal })));
export const StaffComplianceMonitor = lazy(() => import('./staff/pages/operations').then(m => ({ default: m.ComplianceMonitor })));

// Scrum Master
export const ResponseBotAudit = lazy(() => import('./scrum-master/pages').then(m => ({ default: Object.values(m)[0] as any })));

// Additional Pages
export const MedicalSummary = lazy(() => import('./client/pages/medical').then(m => ({ default: Object.values(m)[0] as any })));
export const FamilyPortal = lazy(() => import('./client/pages/family').then(m => ({ default: Object.values(m)[0] as any })));
export const MarDashboard = lazy(() => import('./rn/pages/mar').then(m => ({ default: m.MarDashboard })));
export const MarClient = lazy(() => import('./rn/pages/mar').then(m => ({ default: m.MarClient })));
export const WoundCareDashboard = lazy(() => import('./rn/pages/wound-care'));
export const WoundCareClient = lazy(() => import('./rn/pages/wound-care'));
export const RaiAssessments = lazy(() => import('./rn/pages/rai').then(m => ({ default: m.RaiAssessments })));
export const RaiAssessmentDetail = lazy(() => import('./rn/pages/rai').then(m => ({ default: m.RaiAssessmentDetail })));
export const MileageTracker = lazy(() => import('./psw/pages/mileage').then(m => ({ default: Object.values(m)[0] as any })));
export const PswTrainingHub = lazy(() => import('./psw/pages/training').then(m => ({ default: Object.values(m)[0] as any })));
export const FleetManagement = lazy(() => import('./coordinator/pages/fleet').then(m => ({ default: Object.values(m)[0] as any })));
export const ShiftSwap = lazy(() => import('./coordinator/pages/shift-swap').then(m => ({ default: Object.values(m)[0] as any })));
export const TreatmentList = lazy(() => import('./allied-health/pages/treatments').then(m => ({ default: Object.values(m)[0] as any })));
export const SignOff = lazy(() => import('./allied-health/pages/sign-off').then(m => ({ default: Object.values(m)[0] as any })));

// ── NEW PREMIUM PAGES (Session Sprint 3-6) ──
export const GamificationHub = lazy(() => import('./manager/engagement').then(m => ({ default: Object.values(m)[0] as any })));
export const IoTMonitoring = lazy(() => import('./manager/iot').then(m => ({ default: Object.values(m)[0] as any })));
export const DocumentSigningCenter = lazy(() => import('./manager/documents').then(m => ({ default: Object.values(m)[0] as any })));
export const SMSHub = lazy(() => import('../platform/admin/communications').then(m => ({ default: Object.values(m)[0] as any })));
export const PerformanceReviews = lazy(() => import('./manager/hr').then(m => ({ default: Object.values(m)[0] as any })));
export const TrainingAcademy = lazy(() => import('./manager/training').then(m => ({ default: m.TrainingAcademy })));
export const PswUserGuide = lazy(() => import('./psw/pages/guide').then(m => ({ default: Object.values(m)[0] as any })));
