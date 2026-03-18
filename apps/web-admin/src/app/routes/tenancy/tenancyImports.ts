// TenancyRoutes: all lazy imports extracted
import { lazy } from 'react';

// Manager Pages
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const Portfolio = lazy(() => import('./manager').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const DailyEntry = lazy(() => import('./manager').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
export const UserList = lazy(() => import('../platform/admin').then(m => ({ default: m.UserList  })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const Evaluations = lazy(() => import('./manager').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const ServiceReview = lazy(() => import('./manager').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const ManagerDashboard = lazy(() => import('./manager').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const TrainingHub = lazy(() => import('./manager').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const SurveyManager = lazy(() => import('./manager').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const StaffRanker = lazy(() => import('./manager').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
export const BranchPL = lazy(() => import('./manager').then(m => ({ default: m.BranchPL })));
// @ts-ignore
// @ts-ignore
export const PayrollVerification = lazy(() => import('./manager').then(m => ({ default: m.PayrollVerification })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const MarketingDashboard = lazy(() => import('./marketing').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const HrRecruitmentPortal = lazy(() => import('./hr').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const FinanceRegionalHub = lazy(() => import('./finance').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const ClinicalQaDashboard = lazy(() => import('./qa').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const CoordinatorHub = lazy(() => import('./coordinator').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const DispatchMap = lazy(() => import('./coordinator').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const SosCenter = lazy(() => import('./coordinator').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const WaitlistManager = lazy(() => import('./coordinator').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const AlliedHealthDashboard = lazy(() => import('./allied-health').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const OperationsHub = lazy(() => import('./manager').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const RegionalStats = lazy(() => import('./manager').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const ComplianceSync = lazy(() => import('./manager').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const FinanceHub = lazy(() => import('./manager').then(m => ({ default: Object.values(m)[0] as any })));

// PSW Pages
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const PswDashboard = lazy(() => import('./staff').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const PswSchedule = lazy(() => import('./rn') .then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const PswOpenShifts = lazy(() => import('./psw').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const PswOpenOffers = lazy(() => import('./psw').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const PswAvailability = lazy(() => import('./psw').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const PswEarnings = lazy(() => import('./psw').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const PswExpenses = lazy(() => import('./psw').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const PswShiftConfirmation = lazy(() => import('./psw').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const CredentialVault = lazy(() => import('./psw').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const ProviderSocial = lazy(() => import('./psw').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const LiveVisit = lazy(() => import('./rn') .then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const CheckInScreen = lazy(() => import('./rn') .then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const PswHandover = lazy(() => import('./psw').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const PswPayoutHistory = lazy(() => import('./psw').then(m => ({ default: Object.values(m)[0] as any })));

// RN Pages
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const RnDashboard = lazy(() => import('./staff').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const CarePlanManager = lazy(() => import('./rn') .then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const EntryVerify = lazy(() => import('./rn') .then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const SupervisionHub = lazy(() => import('./rn') .then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const AssessmentsHub = lazy(() => import('./rn') .then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const RnCheckInScreen = lazy(() => import('./rn') .then(m => ({ default: Object.values(m)[0] as any })));

// Client Pages
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const ClientDashboard = lazy(() => import('./staff').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const ClientBookings = lazy(() => import('./client') .then(m => ({ default: Object.values(m)[0] as any })));
export const ClientBilling = lazy(() => import('./client') as any);
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const ClientFeedback = lazy(() => import('./client') .then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const RequestBooking = lazy(() => import('./client') .then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const CatalogBrowser = lazy(() => import('./client') .then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
export const ClientMessaging = lazy(() => import('./client') .then(m => ({ default: m.ClientMessaging })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const CareTeam = lazy(() => import('./client') .then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
export const FeedbackLoop = lazy(() => import('./client') .then(m => ({ default: m.FeedbackLoop })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const FamilyCareHub = lazy(() => import('./manager').then(m => ({ default: Object.values(m)[0] as any })));

// Staff Pages
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const StaffDashboard = lazy(() => import('./staff').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const StaffTaskGrid = lazy(() => import('./staff').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const StaffMessageCenter = lazy(() => import('./staff').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
export const StaffIncidentPortal = lazy(() => import('./staff').then(m => ({ default: m.IncidentPortal })));
// @ts-ignore
// @ts-ignore
export const StaffComplianceMonitor = lazy(() => import('./staff').then(m => ({ default: m.ComplianceMonitor })));

// Scrum Master
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const ResponseBotAudit = lazy(() => import('./scrum-master').then(m => ({ default: Object.values(m)[0] as any })));

// Additional Pages
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const MedicalSummary = lazy(() => import('./client') .then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const FamilyPortal = lazy(() => import('./client') .then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
export const MarDashboard = lazy(() => import('./rn') .then(m => ({ default: m.MarDashboard })));
// @ts-ignore
// @ts-ignore
export const MarClient = lazy(() => import('./rn') .then(m => ({ default: m.MarClient })));
export const WoundCareDashboard = lazy(() => import('./rn') as any);
export const WoundCareClient = lazy(() => import('./rn') as any);
// @ts-ignore
// @ts-ignore
export const RaiAssessments = lazy(() => import('./rn') .then(m => ({ default: m.RaiAssessments })));
// @ts-ignore
// @ts-ignore
export const RaiAssessmentDetail = lazy(() => import('./rn') .then(m => ({ default: m.RaiAssessmentDetail })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const MileageTracker = lazy(() => import('./psw').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const PswTrainingHub = lazy(() => import('./psw').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const FleetManagement = lazy(() => import('./coordinator').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const ShiftSwap = lazy(() => import('./coordinator').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const TreatmentList = lazy(() => import('./allied-health').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const SignOff = lazy(() => import('./allied-health').then(m => ({ default: Object.values(m)[0] as any })));

// ── NEW PREMIUM PAGES (Session Sprint 3-6) ──
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const GamificationHub = lazy(() => import('./manager').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const IoTMonitoring = lazy(() => import('./manager').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const DocumentSigningCenter = lazy(() => import('./manager').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const SMSHub = lazy(() => import('../platform/admin').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const PerformanceReviews = lazy(() => import('./manager').then(m => ({ default: Object.values(m)[0] as any })));
// @ts-ignore
// @ts-ignore
export const TrainingAcademy = lazy(() => import('./manager').then(m => ({ default: m.TrainingAcademy })));
// @ts-ignore
// @ts-ignore
// @ts-ignore
export const PswUserGuide = lazy(() => import('./psw').then(m => ({ default: Object.values(m)[0] as any })));
