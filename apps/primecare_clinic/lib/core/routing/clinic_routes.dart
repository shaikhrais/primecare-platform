import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/theme/theme_config_generated.dart';
import '../../features/shared/screens/clinic_incident_report_screen.dart';
import '../../features/shared/screens/clinic_history_logs_screen.dart';
import '../../features/generated_screens/psw_dashboard_screen.dart';

class ClinicTenant extends PlatformTenant {
  @override
  String get tenantId => 'primecare_clinic';

  @override
  String get name => 'PrimeCare Clinic';

  PrimeThemeData get primeThemeData => PrimeThemeData(
        colors: PrimeColors.fromPalette(ThemeConfig.getAppPalette('clinic')),
      );

  @override
  ThemeData get branding => primeThemeData.toThemeData();
}

class ClinicCareModule extends PlatformModule {
  @override
  String get moduleId => 'clinic_care';
  @override
  String get name => 'Patient Care';
  @override
  IconData get icon => LucideIcons.heartPulse;
  @override
  List<PlatformRole> get allowedRoles => [
    PlatformRole.clinic,
    PlatformRole.rn,
    PlatformRole.rpn,
    PlatformRole.psw,
    PlatformRole.chiropractor,
    PlatformRole.physiotherapist,
    PlatformRole.socialWorker,
    PlatformRole.rmt,
    PlatformRole.clinicalDirector,
    PlatformRole.lpn,
    PlatformRole.np,
    PlatformRole.physician,
    PlatformRole.pediatric,
    PlatformRole.hsw,
    PlatformRole.cns,
    PlatformRole.caregiver,
    PlatformRole.therapist,
    PlatformRole.rnFieldSupervisor,
  ];
  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Care Plan',
      route: CommonRoutes.clinicCarePlan,
      icon: LucideIcons.clipboardList,
      builder: (context) => const PswCarePlanScreen(),
    ),
    PrimeCareScreen(
      title: 'Daily Notes',
      route: CommonRoutes.clinicDailyNotes,
      icon: LucideIcons.pencil,
      builder: (context) => const PswVisitNotesScreen(),
    ),
    PrimeCareScreen(
      title: 'Client Profile',
      route: CommonRoutes.clinicClientProfile,
      icon: LucideIcons.userCircle,
      builder: (context) => const PswClientProfileScreen(),
    ),
    PrimeCareScreen(
      title: 'Chiropractor Dashboard',
      route: ClinicalRoutes.chiropractorDashboard,
      icon: LucideIcons.home,
      requiredRole: PlatformRole.chiropractor,
      builder: (context) => const ChiropractorDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Chiropractor Analytics',
      route: '/offices/clinical/roles/chiropractor/analytics',
      icon: LucideIcons.barChart4,
      requiredRole: PlatformRole.chiropractor,
      builder: (context) => const ChiropractorAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'Chiropractor Compliance',
      route: '/offices/clinical/roles/chiropractor/compliance',
      icon: LucideIcons.shieldAlert,
      requiredRole: PlatformRole.chiropractor,
      builder: (context) => const ChiropractorComplianceScreen(),
    ),
    PrimeCareScreen(
      title: 'Chiropractor Workflow',
      route: '/offices/clinical/roles/chiropractor/workflow',
      icon: LucideIcons.activity,
      requiredRole: PlatformRole.chiropractor,
      builder: (context) => const ChiropractorWorkflowScreen(),
    ),
    PrimeCareScreen(
      title: 'Chiropractor Command Center',
      route: '/offices/clinical/roles/chiropractor/command-center',
      icon: LucideIcons.terminal,
      requiredRole: PlatformRole.chiropractor,
      builder: (context) => const ChiropractorCommandCenterScreen(),
    ),
    PrimeCareScreen(
      title: 'Chiropractor Appointments',
      route: '/offices/clinical/roles/chiropractor/appointments',
      icon: LucideIcons.calendar,
      requiredRole: PlatformRole.chiropractor,
      builder: (context) => const ChiropractorAppointmentsScreen(),
    ),
    PrimeCareScreen(
      title: 'Chiropractor Client Intake',
      route: '/offices/clinical/roles/chiropractor/client-intake',
      icon: LucideIcons.userPlus,
      requiredRole: PlatformRole.chiropractor,
      builder: (context) => const ChiropractorClientIntakeScreen(),
    ),
    PrimeCareScreen(
      title: 'Chiropractor Assessment',
      route: '/offices/clinical/roles/chiropractor/assessment',
      icon: LucideIcons.clipboard,
      requiredRole: PlatformRole.chiropractor,
      builder: (context) => const ChiropractorAssessmentScreen(),
    ),
    PrimeCareScreen(
      title: 'Chiropractor Treatment Notes',
      route: '/offices/clinical/roles/chiropractor/treatment-notes',
      icon: LucideIcons.fileText,
      requiredRole: PlatformRole.chiropractor,
      builder: (context) => const ChiropractorTreatmentNotesScreen(),
    ),
    PrimeCareScreen(
      title: 'Chiropractor Exercise Plan',
      route: '/offices/clinical/roles/chiropractor/exercise-plan',
      icon: LucideIcons.activity,
      requiredRole: PlatformRole.chiropractor,
      builder: (context) => const ChiropractorExercisePlanScreen(),
    ),
    PrimeCareScreen(
      title: 'Chiropractor Billing Link',
      route: '/offices/clinical/roles/chiropractor/billing-link',
      icon: LucideIcons.clipboard,
      requiredRole: PlatformRole.chiropractor,
      builder: (context) => const ChiropractorBillingLinkScreen(),
    ),
    PrimeCareScreen(
      title: 'Chiropractor Reports',
      route: '/offices/clinical/roles/chiropractor/reports',
      icon: LucideIcons.fileBarChart,
      requiredRole: PlatformRole.chiropractor,
      builder: (context) => const ChiropractorReportsScreen(),
    ),
    PrimeCareScreen(
      title: 'Chiropractic Assessment',
      route: '/offices/clinical/roles/chiropractor/chiropractic-assessment',
      icon: LucideIcons.clipboard,
      requiredRole: PlatformRole.chiropractor,
      builder: (context) => const ChiropracticAssessmentScreen(),
    ),
    PrimeCareScreen(
      title: 'Adjustment Notes',
      route: '/offices/clinical/roles/chiropractor/adjustment-notes',
      icon: LucideIcons.fileText,
      requiredRole: PlatformRole.chiropractor,
      builder: (context) => const AdjustmentNotesScreen(),
    ),
    PrimeCareScreen(
      title: 'Xray Review',
      route: '/offices/clinical/roles/chiropractor/xray-review',
      icon: LucideIcons.fileText,
      requiredRole: PlatformRole.chiropractor,
      builder: (context) => const XrayReviewScreen(),
    ),
    PrimeCareScreen(
      title: 'Chiropractic Progress Tracking',
      route:
          '/offices/clinical/roles/chiropractor/chiropractic-progress-tracking',
      icon: LucideIcons.activity,
      requiredRole: PlatformRole.chiropractor,
      builder: (context) => const ChiropracticProgressTrackingScreen(),
    ),
    PrimeCareScreen(
      title: 'Physiotherapist Dashboard',
      route: ClinicalRoutes.physiotherapistDashboard,
      icon: LucideIcons.home,
      requiredRole: PlatformRole.physiotherapist,
      builder: (context) => const PhysiotherapistDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Social Worker Dashboard',
      route: ClinicalRoutes.socialWorkerDashboard,
      icon: LucideIcons.home,
      requiredRole: PlatformRole.socialWorker,
      builder: (context) => const SocialWorkerDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'RMT Dashboard',
      route: ClinicalRoutes.rmtDashboard,
      icon: LucideIcons.home,
      requiredRole: PlatformRole.rmt,
      builder: (context) => const RmtDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Clinical Director Dashboard',
      route: ClinicalRoutes.clinicalDirectorDashboard,
      icon: LucideIcons.home,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => const ClinicalDirectorDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'LPN Dashboard',
      route: '/clinical/lpn-dashboard',
      icon: LucideIcons.home,
      requiredRole: PlatformRole.lpn,
      builder: (context) => const LpnDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'LPN Analytics',
      route: '/rpn/lpn-analytics',
      icon: LucideIcons.barChart4,
      requiredRole: PlatformRole.lpn,
      builder: (context) => const LicensedPracticalNurseLPNAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'LPN Compliance Workflow',
      route: '/rpn/lpn-workflow',
      icon: LucideIcons.activity,
      requiredRole: PlatformRole.lpn,
      builder: (context) => const LicensedPracticalNurseLPNComplianceWorkflowScreen(),
    ),
    PrimeCareScreen(
      title: 'NP Dashboard',
      route: '/clinical/np-dashboard',
      icon: LucideIcons.home,
      requiredRole: PlatformRole.np,
      builder: (context) => const NpDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'NP Analytics',
      route: '/rn/np-analytics',
      icon: LucideIcons.barChart4,
      requiredRole: PlatformRole.np,
      builder: (context) => const NursePractitionerNPAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'NP Compliance Workflow',
      route: '/rn/np-workflow',
      icon: LucideIcons.activity,
      requiredRole: PlatformRole.np,
      builder: (context) => const NursePractitionerNPComplianceWorkflowScreen(),
    ),
    PrimeCareScreen(
      title: 'HSW Dashboard',
      route: '/clinical/hsw-dashboard',
      icon: LucideIcons.home,
      requiredRole: PlatformRole.hsw,
      builder: (context) => const HswDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'HSW ADL Logger',
      route: '/clinical/hsw-adl-logger',
      icon: LucideIcons.activity,
      requiredRole: PlatformRole.hsw,
      builder: (context) => const HswAdlLoggerScreen(),
    ),
    PrimeCareScreen(
      title: 'HSW Care Plans',
      route: '/clinical/hsw-care-plans',
      icon: LucideIcons.clipboardList,
      requiredRole: PlatformRole.hsw,
      builder: (context) => const HswCarePlansScreen(),
    ),
    PrimeCareScreen(
      title: 'HSW Incident Reports',
      route: '/clinical/hsw-incident-reports',
      icon: LucideIcons.alertTriangle,
      requiredRole: PlatformRole.hsw,
      builder: (context) => const HswIncidentReportsScreen(),
    ),
    PrimeCareScreen(
      title: 'HSW Schedule',
      route: '/clinical/hsw-schedule',
      icon: LucideIcons.calendarDays,
      requiredRole: PlatformRole.hsw,
      builder: (context) => const HswScheduleScreen(),
    ),
    PrimeCareScreen(
      title: 'Pediatric Dashboard',
      route: '/clinical/pediatric-dashboard',
      icon: LucideIcons.home,
      requiredRole: PlatformRole.pediatric,
      builder: (context) => const PediatricDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Pediatric Analytics',
      route: '/clinical/pediatric-analytics',
      icon: LucideIcons.barChart4,
      requiredRole: PlatformRole.pediatric,
      builder: (context) => const PediatricSpecialistAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'Pediatric Workflow',
      route: '/clinical/pediatric-workflow',
      icon: LucideIcons.activity,
      requiredRole: PlatformRole.pediatric,
      builder: (context) => const PediatricSpecialistComplianceWorkflowScreen(),
    ),
    PrimeCareScreen(
      title: 'Physician Dashboard',
      route: '/clinical/physician-dashboard',
      icon: LucideIcons.home,
      requiredRole: PlatformRole.physician,
      builder: (context) => const PhysicianDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Physician Analytics',
      route: '/clinical/physician-analytics',
      icon: LucideIcons.barChart4,
      requiredRole: PlatformRole.physician,
      builder: (context) => PhysicianAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'Physician Workflow',
      route: '/clinical/physician-workflow',
      icon: LucideIcons.activity,
      requiredRole: PlatformRole.physician,
      builder: (context) => const PhysicianComplianceWorkflowScreen(),
    ),
    PrimeCareScreen(
      title: 'CNS Dashboard',
      route: '/clinical/cns-dashboard',
      icon: LucideIcons.home,
      requiredRole: PlatformRole.cns,
      builder: (context) => const CnsDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Caregiver Dashboard',
      route: '/offices/clinical/roles/caregiver/dashboard',
      icon: LucideIcons.home,
      requiredRole: PlatformRole.caregiver,
      builder: (context) => const CaregiverDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Caregiver Tasks',
      route: '/offices/clinical/roles/caregiver/tasks',
      icon: LucideIcons.checkSquare,
      requiredRole: PlatformRole.caregiver,
      builder: (context) => const CaregiverTasksScreen(),
    ),
    PrimeCareScreen(
      title: 'Caregiver Client Profile',
      route: '/offices/clinical/roles/caregiver/client-profile',
      icon: LucideIcons.userCircle,
      requiredRole: PlatformRole.caregiver,
      builder: (context) => const CaregiverClientProfileScreen(),
    ),
    PrimeCareScreen(
      title: 'Caregiver Visit Notes',
      route: '/offices/clinical/roles/caregiver/visit-notes',
      icon: LucideIcons.fileText,
      requiredRole: PlatformRole.caregiver,
      builder: (context) => const CaregiverVisitNotesScreen(),
    ),
    PrimeCareScreen(
      title: 'Caregiver Schedule',
      route: '/offices/clinical/roles/caregiver/schedule',
      icon: LucideIcons.calendarDays,
      requiredRole: PlatformRole.caregiver,
      builder: (context) => const CaregiverScheduleScreen(),
    ),
    PrimeCareScreen(
      title: 'Caregiver Incident Report',
      route: '/offices/clinical/roles/caregiver/incident-report',
      icon: LucideIcons.alertTriangle,
      requiredRole: PlatformRole.caregiver,
      builder: (context) => const CaregiverIncidentReportScreen(),
    ),
    PrimeCareScreen(
      title: 'Therapist Dashboard',
      route: '/offices/clinical/roles/therapist/dashboard',
      icon: LucideIcons.home,
      requiredRole: PlatformRole.therapist,
      builder: (context) => const TherapistDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Therapist Analytics',
      route: '/offices/clinical/roles/therapist/analytics',
      icon: LucideIcons.barChart4,
      requiredRole: PlatformRole.therapist,
      builder: (context) => TherapistAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'Therapist Workflow',
      route: '/offices/clinical/roles/therapist/workflow',
      icon: LucideIcons.activity,
      requiredRole: PlatformRole.therapist,
      builder: (context) => const TherapistComplianceWorkflowScreen(),
    ),
    // Physiotherapist Sub-Screens
    PrimeCareScreen(
      title: 'Physiotherapist Analytics',
      route: '/offices/clinical/roles/physiotherapist/analytics',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.physiotherapist,
      builder: (context) => const PhysiotherapistAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'Physiotherapist Appointments',
      route: '/offices/clinical/roles/physiotherapist/appointments',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.physiotherapist,
      builder: (context) => const PhysiotherapistAppointmentsScreen(),
    ),
    PrimeCareScreen(
      title: 'Physiotherapist Assessment',
      route: '/offices/clinical/roles/physiotherapist/assessment',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.physiotherapist,
      builder: (context) => const PhysiotherapistAssessmentScreen(),
    ),
    PrimeCareScreen(
      title: 'Physiotherapist Billing Link',
      route: '/offices/clinical/roles/physiotherapist/billing-link',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.physiotherapist,
      builder: (context) => const PhysiotherapistBillingLinkScreen(),
    ),
    PrimeCareScreen(
      title: 'Physiotherapist Client Intake',
      route: '/offices/clinical/roles/physiotherapist/client-intake',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.physiotherapist,
      builder: (context) => const PhysiotherapistClientIntakeScreen(),
    ),
    PrimeCareScreen(
      title: 'Physiotherapist Command Center',
      route: '/offices/clinical/roles/physiotherapist/command-center',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.physiotherapist,
      builder: (context) => const PhysiotherapistCommandCenterScreen(),
    ),
    PrimeCareScreen(
      title: 'Physiotherapist Compliance',
      route: '/offices/clinical/roles/physiotherapist/compliance',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.physiotherapist,
      builder: (context) => const PhysiotherapistComplianceScreen(),
    ),
    PrimeCareScreen(
      title: 'Physiotherapist Exercise Plan',
      route: '/offices/clinical/roles/physiotherapist/exercise-plan',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.physiotherapist,
      builder: (context) => const PhysiotherapistExercisePlanScreen(),
    ),
    PrimeCareScreen(
      title: 'Exercise Prescription',
      route: '/offices/clinical/roles/physiotherapist/exercise-prescription',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.physiotherapist,
      builder: (context) => const ExercisePrescriptionScreen(),
    ),
    PrimeCareScreen(
      title: 'Progress Tracking',
      route: '/offices/clinical/roles/physiotherapist/progress-tracking',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.physiotherapist,
      builder: (context) => const ProgressTrackingScreen(),
    ),
    PrimeCareScreen(
      title: 'Physiotherapist Reports',
      route: '/offices/clinical/roles/physiotherapist/reports',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.physiotherapist,
      builder: (context) => const PhysiotherapistReportsScreen(),
    ),
    PrimeCareScreen(
      title: 'Physiotherapist Treatment Notes',
      route: '/offices/clinical/roles/physiotherapist/treatment-notes',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.physiotherapist,
      builder: (context) => const PhysiotherapistTreatmentNotesScreen(),
    ),
    PrimeCareScreen(
      title: 'Treatment Plan',
      route: '/offices/clinical/roles/physiotherapist/treatment-plan',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.physiotherapist,
      builder: (context) => const TreatmentPlanScreen(),
    ),
    PrimeCareScreen(
      title: 'Physiotherapist Workflow',
      route: '/offices/clinical/roles/physiotherapist/workflow',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.physiotherapist,
      builder: (context) => const PhysiotherapistWorkflowScreen(),
    ),
    // RMT Sub-Screens
    PrimeCareScreen(
      title: 'Rmt Analytics',
      route: '/offices/clinical/roles/rmt/analytics',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rmt,
      builder: (context) => const RmtAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'Rmt Appointments',
      route: '/offices/clinical/roles/rmt/appointments',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rmt,
      builder: (context) => const RmtAppointmentsScreen(),
    ),
    PrimeCareScreen(
      title: 'Rmt Assessment',
      route: '/offices/clinical/roles/rmt/assessment',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rmt,
      builder: (context) => const RmtAssessmentScreen(),
    ),
    PrimeCareScreen(
      title: 'Rmt Billing Link',
      route: '/offices/clinical/roles/rmt/billing-link',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rmt,
      builder: (context) => const RmtBillingLinkScreen(),
    ),
    PrimeCareScreen(
      title: 'Rmt Client Intake',
      route: '/offices/clinical/roles/rmt/client-intake',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rmt,
      builder: (context) => const RmtClientIntakeScreen(),
    ),
    PrimeCareScreen(
      title: 'Client Progress',
      route: '/offices/clinical/roles/rmt/client-progress',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rmt,
      builder: (context) => const ClientProgressScreen(),
    ),
    PrimeCareScreen(
      title: 'Rmt Command Center',
      route: '/offices/clinical/roles/rmt/command-center',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rmt,
      builder: (context) => const RmtCommandCenterScreen(),
    ),
    PrimeCareScreen(
      title: 'Rmt Compliance',
      route: '/offices/clinical/roles/rmt/compliance',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rmt,
      builder: (context) => const RmtComplianceScreen(),
    ),
    PrimeCareScreen(
      title: 'Rmt Exercise Plan',
      route: '/offices/clinical/roles/rmt/exercise-plan',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rmt,
      builder: (context) => const RmtExercisePlanScreen(),
    ),
    PrimeCareScreen(
      title: 'Home Care Plan',
      route: '/offices/clinical/roles/rmt/home-care-plan',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rmt,
      builder: (context) => const HomeCarePlanScreen(),
    ),
    PrimeCareScreen(
      title: 'Massage Assessment',
      route: '/offices/clinical/roles/rmt/massage-assessment',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rmt,
      builder: (context) => const MassageAssessmentScreen(),
    ),
    PrimeCareScreen(
      title: 'Rmt Reports',
      route: '/offices/clinical/roles/rmt/reports',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rmt,
      builder: (context) => const RmtReportsScreen(),
    ),
    PrimeCareScreen(
      title: 'Rmt Treatment Notes',
      route: '/offices/clinical/roles/rmt/treatment-notes',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rmt,
      builder: (context) => const RmtTreatmentNotesScreen(),
    ),
    PrimeCareScreen(
      title: 'Rmt Workflow',
      route: '/offices/clinical/roles/rmt/workflow',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rmt,
      builder: (context) => const RmtWorkflowScreen(),
    ),
    // Social Worker Sub-Screens
    PrimeCareScreen(
      title: 'Social Worker Analytics',
      route: '/offices/clinical/roles/social_worker/analytics',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.socialWorker,
      builder: (context) => const SocialWorkerAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'Social Worker Compliance',
      route: '/offices/clinical/roles/social_worker/compliance',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.socialWorker,
      builder: (context) => const SocialWorkerComplianceScreen(),
    ),
    PrimeCareScreen(
      title: 'Social Worker Workflow',
      route: '/offices/clinical/roles/social_worker/workflow',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.socialWorker,
      builder: (context) => const SocialWorkerWorkflowScreen(),
    ),
    // Clinical Director Sub-Screens
    PrimeCareScreen(
      title: 'Clinical Analytics',
      route: '/offices/clinical/roles/clinical_director/analytics',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => const ClinicalAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'Clinical Director Approvals',
      route: '/offices/clinical/roles/clinical_director/approvals',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => const ClinicalDirectorApprovalsScreen(),
    ),
    PrimeCareScreen(
      title: 'Clinic Analytics',
      route: '/offices/clinical/roles/clinical_director/clinic-analytics',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => const ClinicAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'Clinic Compliance',
      route: '/offices/clinical/roles/clinical_director/clinic-compliance',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => const ClinicComplianceScreen(),
    ),
    PrimeCareScreen(
      title: 'Clinic Dashboard',
      route: '/offices/clinical/roles/clinical_director/clinic-dashboard',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => const ClinicDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Clinic Workflow',
      route: '/offices/clinical/roles/clinical_director/clinic-workflow',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => const ClinicWorkflowScreen(),
    ),
    PrimeCareScreen(
      title: 'Clinical Compliance',
      route: '/offices/clinical/roles/clinical_director/compliance',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => const ClinicalComplianceScreen(),
    ),
    PrimeCareScreen(
      title: 'Clinical Director Compliance',
      route: '/offices/clinical/roles/clinical_director/compliance-director',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => const ClinicalDirectorComplianceScreen(),
    ),
    PrimeCareScreen(
      title: 'Compliance Review',
      route: '/offices/clinical/roles/clinical_director/compliance-review',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => const ComplianceReviewScreen(),
    ),
    PrimeCareScreen(
      title: 'Clinical Dashboard',
      route: '/offices/clinical/roles/clinical_director/dashboard',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => const ClinicalDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Incident Oversight',
      route: '/offices/clinical/roles/clinical_director/incident-oversight',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => const IncidentOversightScreen(),
    ),
    PrimeCareScreen(
      title: 'Clinical Director Incident Review',
      route: '/offices/clinical/roles/clinical_director/incident-review',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => const ClinicalDirectorIncidentReviewScreen(),
    ),
    PrimeCareScreen(
      title: 'Clinical Operations4 K',
      route: '/offices/clinical/roles/clinical_director/operations4k',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => const ClinicalOperations4KScreen(),
    ),
    PrimeCareScreen(
      title: 'Clinical Director Performance',
      route: '/offices/clinical/roles/clinical_director/performance',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => const ClinicalDirectorPerformanceScreen(),
    ),
    PrimeCareScreen(
      title: 'Clinical Quality',
      route: '/offices/clinical/roles/clinical_director/quality',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => const ClinicalQualityScreen(),
    ),
    PrimeCareScreen(
      title: 'Clinical Director Reports',
      route: '/offices/clinical/roles/clinical_director/reports',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => const ClinicalDirectorReportsScreen(),
    ),
    PrimeCareScreen(
      title: 'Staff Performance',
      route: '/offices/clinical/roles/clinical_director/staff-performance',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => const StaffPerformanceScreen(),
    ),
    PrimeCareScreen(
      title: 'Clinical Director Staff Quality',
      route: '/offices/clinical/roles/clinical_director/staff-quality',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => const ClinicalDirectorStaffQualityScreen(),
    ),
    PrimeCareScreen(
      title: 'Clinical Workflow',
      route: '/offices/clinical/roles/clinical_director/workflow',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => const ClinicalWorkflowScreen(),
    ),
    // RN Sub-Screens
    PrimeCareScreen(
      title: 'Care Plan Review',
      route: '/offices/clinical/roles/rn/care-plan-review',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const CarePlanReviewScreen(),
    ),
    PrimeCareScreen(
      title: 'Rn Dashboard',
      route: '/offices/clinical/roles/rn/dashboard',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const RnDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Incident Review',
      route: '/offices/clinical/roles/rn/incident-review',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const IncidentReviewScreen(),
    ),
    PrimeCareScreen(
      title: 'Medication Administration',
      route: '/offices/clinical/roles/rn/medication-administration',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const MedicationAdministrationScreen(),
    ),
    PrimeCareScreen(
      title: 'Rn Medications',
      route: '/offices/clinical/roles/rn/medications',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const RnMedicationsScreen(),
    ),
    PrimeCareScreen(
      title: 'Rn Patient Charting',
      route: '/offices/clinical/roles/rn/patient-charting',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const RnPatientChartingScreen(),
    ),
    PrimeCareScreen(
      title: 'Rn Analytics',
      route: '/offices/clinical/roles/rn/rn-analytics',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const RnAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'Rn Assessments',
      route: '/offices/clinical/roles/rn/rn-assessments',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const RnAssessmentsScreen(),
    ),
    PrimeCareScreen(
      title: 'Rn Care Plan Review',
      route: '/offices/clinical/roles/rn/rn-care-plan-review',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const RnCarePlanReviewScreen(),
    ),
    PrimeCareScreen(
      title: 'Rn Care Plans',
      route: '/offices/clinical/roles/rn/rn-care-plans',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const RnCarePlansScreen(),
    ),
    PrimeCareScreen(
      title: 'Rn Command Center',
      route: '/offices/clinical/roles/rn/rn-command-center',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const RnCommandCenterScreen(),
    ),
    PrimeCareScreen(
      title: 'Rn Compliance',
      route: '/offices/clinical/roles/rn/rn-compliance',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const RnComplianceScreen(),
    ),
    PrimeCareScreen(
      title: 'Rn Incident Review',
      route: '/offices/clinical/roles/rn/rn-incident-review',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const RnIncidentReviewScreen(),
    ),
    PrimeCareScreen(
      title: 'Rn Reports',
      route: '/offices/clinical/roles/rn/rn-reports',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const RnReportsScreen(),
    ),
    PrimeCareScreen(
      title: 'Rn Tasks',
      route: '/offices/clinical/roles/rn/rn-tasks',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const RnTasksScreen(),
    ),
    PrimeCareScreen(
      title: 'Rn Workflow',
      route: '/offices/clinical/roles/rn/rn-workflow',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const RnWorkflowScreen(),
    ),
    PrimeCareScreen(
      title: 'Shift Report',
      route: '/offices/clinical/roles/rn/shift-report',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const ShiftReportScreen(),
    ),
    PrimeCareScreen(
      title: 'Rn Vitals',
      route: '/offices/clinical/roles/rn/vitals',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const RnVitalsScreen(),
    ),
    // RPN Sub-Screens
    PrimeCareScreen(
      title: 'Rpn Dashboard',
      route: '/offices/clinical/roles/rpn/dashboard',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rpn,
      builder: (context) => const RpnDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Medication',
      route: '/offices/clinical/roles/rpn/medication',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rpn,
      builder: (context) => const MedicationScreen(),
    ),
    PrimeCareScreen(
      title: 'Rpn Medications',
      route: '/offices/clinical/roles/rpn/medications',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rpn,
      builder: (context) => const RpnMedicationsScreen(),
    ),
    PrimeCareScreen(
      title: 'Nursing Task',
      route: '/offices/clinical/roles/rpn/nursing-task',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rpn,
      builder: (context) => const NursingTaskScreen(),
    ),
    PrimeCareScreen(
      title: 'Rpn Patient Charting',
      route: '/offices/clinical/roles/rpn/patient-charting',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rpn,
      builder: (context) => const RpnPatientChartingScreen(),
    ),
    PrimeCareScreen(
      title: 'Patient Observation',
      route: '/offices/clinical/roles/rpn/patient-observation',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rpn,
      builder: (context) => const PatientObservationScreen(),
    ),
    PrimeCareScreen(
      title: 'Rpn Analytics',
      route: '/offices/clinical/roles/rpn/rpn-analytics',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rpn,
      builder: (context) => const RpnAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'Rpn Care Plan Review',
      route: '/offices/clinical/roles/rpn/rpn-care-plan-review',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rpn,
      builder: (context) => const RpnCarePlanReviewScreen(),
    ),
    PrimeCareScreen(
      title: 'Rpn Command Center',
      route: '/offices/clinical/roles/rpn/rpn-command-center',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rpn,
      builder: (context) => const RpnCommandCenterScreen(),
    ),
    PrimeCareScreen(
      title: 'Rpn Compliance',
      route: '/offices/clinical/roles/rpn/rpn-compliance',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rpn,
      builder: (context) => const RpnComplianceScreen(),
    ),
    PrimeCareScreen(
      title: 'Rpn Incident Review',
      route: '/offices/clinical/roles/rpn/rpn-incident-review',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rpn,
      builder: (context) => const RpnIncidentReviewScreen(),
    ),
    PrimeCareScreen(
      title: 'Rpn Reports',
      route: '/offices/clinical/roles/rpn/rpn-reports',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rpn,
      builder: (context) => const RpnReportsScreen(),
    ),
    PrimeCareScreen(
      title: 'Rpn Tasks',
      route: '/offices/clinical/roles/rpn/rpn-tasks',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rpn,
      builder: (context) => const RpnTasksScreen(),
    ),
    PrimeCareScreen(
      title: 'Rpn Workflow',
      route: '/offices/clinical/roles/rpn/rpn-workflow',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rpn,
      builder: (context) => const RpnWorkflowScreen(),
    ),
    PrimeCareScreen(
      title: 'Rpn Vitals',
      route: '/offices/clinical/roles/rpn/vitals',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rpn,
      builder: (context) => const RpnVitalsScreen(),
    ),
    PrimeCareScreen(
      title: 'Vitals Tracking',
      route: '/offices/clinical/roles/rpn/vitals-tracking',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rpn,
      builder: (context) => const VitalsTrackingScreen(),
    ),
    // Other clinical common screens
    PrimeCareScreen(
      title: 'Agent Dispatch',
      route: '/common/agent-dispatch',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const AgentDispatchScreen(),
    ),
    PrimeCareScreen(
      title: 'Api Health Dashboard',
      route: '/common/api-health-dashboard',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const ApiHealthDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Audit',
      route: '/common/audit',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const ScreenAuditScreen(),
    ),
    PrimeCareScreen(
      title: 'Drift Findings',
      route: '/common/drift-findings',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const DriftFindingsScreen(),
    ),
    PrimeCareScreen(
      title: 'File Verification Dashboard',
      route: '/common/file-verification-dashboard',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const FileVerificationDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Governance Control Room',
      route: '/common/governance-control-room',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const GovernanceControlRoomScreen(),
    ),
    PrimeCareScreen(
      title: 'Governance Operations4 K',
      route: '/common/governance-operations4-k',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const GovernanceOperations4KScreen(),
    ),
    PrimeCareScreen(
      title: 'Pending Task Queue',
      route: '/common/pending-task-queue',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const PendingTaskQueueScreen(),
    ),
    PrimeCareScreen(
      title: 'Release Operations',
      route: '/common/release-operations',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const ReleaseOperationsScreen(),
    ),
    PrimeCareScreen(
      title: 'Responsive Preview',
      route: '/common/responsive-preview',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const ResponsivePreviewScreen(),
    ),
    PrimeCareScreen(
      title: 'Role Coverage Dashboard',
      route: '/common/role-coverage-dashboard',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const RoleCoverageDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Runtime Verification',
      route: '/common/runtime-verification',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const RuntimeVerificationScreen(),
    ),
    PrimeCareScreen(
      title: 'System Dashboard',
      route: '/common/system-dashboard',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const SystemDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Workflow Execution',
      route: '/common/workflow-execution',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const WorkflowExecutionScreen(),
    ),
    PrimeCareScreen(
      title: 'Governance Officer Analytics',
      route: '/management/governance-officer-analytics',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const GovernanceOfficerAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'Governance Officer Compliance',
      route: '/management/governance-officer-compliance',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const GovernanceOfficerComplianceScreen(),
    ),
    PrimeCareScreen(
      title: 'Governance Officer Dashboard',
      route: '/management/governance-officer-dashboard',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const GovernanceOfficerDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Governance Officer Workflow',
      route: '/management/governance-officer-workflow',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => const GovernanceOfficerWorkflowScreen(),
    ),
    PrimeCareScreen(
      title: 'Rn Field Supervisor Dashboard',
      route: '/rn/rn-field-supervisor-dashboard',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rnFieldSupervisor,
      builder: (context) => const RnFieldSupervisorDashboardScreen(),
    ),
  ];
}

class ClinicOperationsModule extends PlatformModule {
  @override
  String get moduleId => 'clinic_ops';
  @override
  String get name => 'Operations';
  @override
  IconData get icon => LucideIcons.building2;

  @override
  List<PlatformRole> get allowedRoles => [
    PlatformRole.clinic,
    PlatformRole.rn,
    PlatformRole.rpn,
    PlatformRole.psw,
    PlatformRole.intakeCoordinator,
    PlatformRole.trainingCoordinator,
  ];
  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Clinical Intelligence',
      route: CommonRoutes.clinicDashboard,
      icon: LucideIcons.barChart4,
      builder: (context) => const CareDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'My Shifts',
      route: CommonRoutes.clinicMyShifts,
      icon: LucideIcons.calendarDays,
      builder: (context) => const PswMyShiftsScreen(),
    ),
    PrimeCareScreen(
      title: 'Messaging',
      route: CommonRoutes.clinicMessaging,
      icon: LucideIcons.messageSquare,
      builder: (context) => const PswMessagesScreen(),
    ),
    PrimeCareScreen(
      title: 'Intake Coordinator Dashboard',
      route: ClinicalRoutes.intakeCoordinatorDashboard,
      icon: LucideIcons.home,
      requiredRole: PlatformRole.intakeCoordinator,
      builder: (context) => const IntakeCoordinatorDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Training Coordinator Dashboard',
      route: ClinicalRoutes.trainingCoordinatorDashboard,
      icon: LucideIcons.home,
      requiredRole: PlatformRole.trainingCoordinator,
      builder: (context) => const TrainingCoordinatorDashboardScreen(),
    ),
    // Intake Coordinator Sub-Screens
    PrimeCareScreen(
      title: 'Intake Analytics',
      route: '/offices/clinical/roles/intake_coordinator/analytics',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.intakeCoordinator,
      builder: (context) => const IntakeAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'Booking',
      route: '/offices/clinical/roles/intake_coordinator/booking',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.intakeCoordinator,
      builder: (context) => const BookingScreen(),
    ),
    PrimeCareScreen(
      title: 'Client Intake',
      route: '/offices/clinical/roles/intake_coordinator/client-intake',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.intakeCoordinator,
      builder: (context) => const ClientIntakeScreen(),
    ),
    PrimeCareScreen(
      title: 'Intake Compliance',
      route: '/offices/clinical/roles/intake_coordinator/compliance',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.intakeCoordinator,
      builder: (context) => const IntakeComplianceScreen(),
    ),
    PrimeCareScreen(
      title: 'Intake Coordinator Analytics',
      route: '/offices/clinical/roles/intake_coordinator/coordinator-analytics',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.intakeCoordinator,
      builder: (context) => const IntakeCoordinatorAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'Intake Coordinator Compliance',
      route: '/offices/clinical/roles/intake_coordinator/coordinator-compliance',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.intakeCoordinator,
      builder: (context) => const IntakeCoordinatorComplianceScreen(),
    ),
    PrimeCareScreen(
      title: 'Intake Coordinator Dashboard',
      route: '/offices/clinical/roles/intake_coordinator/coordinator-dashboard',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.intakeCoordinator,
      builder: (context) => const IntakeCoordinatorDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Intake Coordinator Workflow',
      route: '/offices/clinical/roles/intake_coordinator/coordinator-workflow',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.intakeCoordinator,
      builder: (context) => const IntakeCoordinatorWorkflowScreen(),
    ),
    PrimeCareScreen(
      title: 'Intake Dashboard',
      route: '/offices/clinical/roles/intake_coordinator/dashboard',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.intakeCoordinator,
      builder: (context) => const IntakeDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Followup',
      route: '/offices/clinical/roles/intake_coordinator/followup',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.intakeCoordinator,
      builder: (context) => const FollowupScreen(),
    ),
    PrimeCareScreen(
      title: 'Referral Management',
      route: '/offices/clinical/roles/intake_coordinator/referral-management',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.intakeCoordinator,
      builder: (context) => const ReferralManagementScreen(),
    ),
    PrimeCareScreen(
      title: 'Intake Workflow',
      route: '/offices/clinical/roles/intake_coordinator/workflow',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.intakeCoordinator,
      builder: (context) => const IntakeWorkflowScreen(),
    ),
  ];
}

class ClinicSafetyModule extends PlatformModule {
  @override
  String get moduleId => 'clinic_safety';
  @override
  String get name => 'Safety & Quality';
  @override
  IconData get icon => LucideIcons.shieldAlert;
  @override
  List<PlatformRole> get allowedRoles => [
    PlatformRole.clinic,
    PlatformRole.rn,
    PlatformRole.rpn,
    PlatformRole.qualityAssurance,
  ];
  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Incident Report',
      route: CommonRoutes.clinicIncidentReport,
      icon: LucideIcons.alertTriangle,
      builder: (context) => const ClinicIncidentReportScreen(),
    ),
    PrimeCareScreen(
      title: 'History Logs',
      route: CommonRoutes.clinicHistoryLogs,
      icon: LucideIcons.history,
      builder: (context) => const ClinicHistoryLogsScreen(),
    ),
    PrimeCareScreen(
      title: 'QA Dashboard',
      route: ClinicalRoutes.qualityAssuranceDashboard,
      icon: LucideIcons.home,
      requiredRole: PlatformRole.qualityAssurance,
      builder: (context) => const QaDashboardScreen(),
    ),
  ];
}

class ClinicPswModule extends PlatformModule {
  @override
  String get moduleId => 'clinic_psw';
  @override
  String get name => 'PSW Care';
  @override
  IconData get icon => LucideIcons.userPlus;
  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.psw];
  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Care Dashboard',
      route: ClinicalRoutes.pswDashboard,
      icon: LucideIcons.home,
      builder: (context) => const CareDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Shift Tracker',
      route: ClinicalRoutes.pswSchedule,
      icon: LucideIcons.clock,
      builder: (context) => const PswShiftTrackerScreen(),
    ),
    PrimeCareScreen(
      title: 'My Clients',
      route: ClinicalRoutes.pswPatientProfile,
      icon: LucideIcons.users,
      builder: (context) => const PswClientsScreen(),
    ),
    PrimeCareScreen(
      title: 'Task List',
      route: ClinicalRoutes.pswVisitChecklist,
      icon: LucideIcons.checkSquare,
      builder: (context) => const PswTasksScreen(),
    ),
    PrimeCareScreen(
      title: 'Messages',
      route: ClinicalRoutes.pswMessages,
      icon: LucideIcons.messageSquare,
      builder: (context) => const PswMessagesScreen(),
    ),
    PrimeCareScreen(
      title: 'Visit Notes',
      route: ClinicalRoutes.pswVisitNotes,
      icon: LucideIcons.fileText,
      builder: (context) => const PswVisitNotesScreen(),
    ),
    PrimeCareScreen(
      title: 'Profile',
      route: ClinicalRoutes.pswProfile,
      icon: LucideIcons.user,
      builder: (context) => const PswClientProfileScreen(),
    ),
    PrimeCareScreen(
      title: 'Reports',
      route: ClinicalRoutes.pswReports,
      icon: LucideIcons.fileBarChart,
      builder: (context) => const PswAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'Documents',
      route: ClinicalRoutes.pswDocuments,
      icon: LucideIcons.folder,
      builder: (context) => const PswDocumentsScreen(),
    ),
    PrimeCareScreen(
      title: 'Check-In',
      route: ClinicalRoutes.pswCheckIn,
      icon: LucideIcons.mapPin,
      builder: (context) => const PswShiftTrackerScreen(),
    ),
    PrimeCareScreen(
      title: 'System Logs',
      route: ClinicalRoutes.pswSystemLogs,
      icon: LucideIcons.terminal,
      builder: (context) => const PswCommandCenterScreen(),
    ),
    PrimeCareScreen(
      title: 'Notifications',
      route: ClinicalRoutes.pswNotifications,
      icon: LucideIcons.bell,
      builder: (context) => const PswMessagesScreen(),
    ),
    PrimeCareScreen(
      title: 'Help & Support',
      route: ClinicalRoutes.pswHelpSupport,
      icon: LucideIcons.helpCircle,
      builder: (context) => const PswComplianceScreen(),
    ),
    PrimeCareScreen(
      title: 'Psw Care Plan',
      route: '/offices/clinical/roles/psw/care-plan',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.psw,
      builder: (context) => const PswCarePlanScreen(),
    ),
    PrimeCareScreen(
      title: 'Psw Analytics',
      route: '/offices/clinical/roles/psw/psw-analytics',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.psw,
      builder: (context) => const PswAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'Psw Client Profile',
      route: '/offices/clinical/roles/psw/psw-client-profile',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.psw,
      builder: (context) => const PswClientProfileScreen(),
    ),
    PrimeCareScreen(
      title: 'Psw Command Center',
      route: '/offices/clinical/roles/psw/psw-command-center',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.psw,
      builder: (context) => const PswCommandCenterScreen(),
    ),
    PrimeCareScreen(
      title: 'Psw Compliance',
      route: '/offices/clinical/roles/psw/psw-compliance',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.psw,
      builder: (context) => const PswComplianceScreen(),
    ),
    PrimeCareScreen(
      title: 'Psw My Shifts',
      route: '/offices/clinical/roles/psw/psw-my-shifts',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.psw,
      builder: (context) => const PswMyShiftsScreen(),
    ),
    PrimeCareScreen(
      title: 'Psw Workflow',
      route: '/offices/clinical/roles/psw/psw-workflow',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.psw,
      builder: (context) => const PswWorkflowScreen(),
    ),
    PrimeCareScreen(
      title: 'Shift Tasks',
      route: '/offices/clinical/roles/psw/shift-tasks',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.psw,
      builder: (context) => const ShiftTasksScreen(),
    ),
    PrimeCareScreen(
      title: 'Vitals Entry',
      route: '/offices/clinical/roles/psw/vitals-entry',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.psw,
      builder: (context) => const VitalsEntryScreen(),
    ),
    PrimeCareScreen(
      title: 'Psw Vitals Log',
      route: '/offices/clinical/roles/psw/observation-vitals-log',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.psw,
      builder: (context) => const PswVitalsLogScreen(),
    ),
    PrimeCareScreen(
      title: 'Psw Incident Report',
      route: '/offices/clinical/roles/psw/incident-report',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.psw,
      builder: (context) => const PswIncidentReportScreen(),
    ),
  ];
}

class ClinicApplication extends PlatformApplication {
  @override
  String get appId => 'primecare_clinic';

  @override
  String get name => 'PrimeCare Clinic Portal';

  @override
  PlatformTenant get tenant => ClinicTenant();

  @override
  PlatformRoleDefinition? getDefinition(PlatformRole role) {
    if (role == PlatformRole.intake) {
      return super.getDefinition(PlatformRole.intakeCoordinator);
    }
    return super.getDefinition(role);
  }

  @override
  List<PlatformRoleDefinition> get roleDefinitions => [
    PlatformRoleDefinition(
      role: PlatformRole.clinic,
      dashboardRoute: CommonRoutes.clinicDashboard,
      modules: [
        ClinicCareModule(),
        ClinicOperationsModule(),
        ClinicSafetyModule(),
      ],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.rn,
      dashboardRoute: '/offices/clinical/roles/rn/dashboard',
      modules: [
        ClinicCareModule(),
        ClinicOperationsModule(),
        ClinicSafetyModule(),
      ],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.rpn,
      dashboardRoute: '/offices/clinical/roles/rpn/dashboard',
      modules: [
        ClinicCareModule(),
        ClinicOperationsModule(),
        ClinicSafetyModule(),
      ],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.psw,
      dashboardRoute: ClinicalRoutes.pswDashboard,
      modules: [
        ClinicPswModule(),
        ClinicCareModule(),
        ClinicOperationsModule(),
      ],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.clinicalDirector,
      dashboardRoute: ClinicalRoutes.clinicalDirectorDashboard,
      modules: [
        ClinicCareModule(),
        ClinicOperationsModule(),
        ClinicSafetyModule(),
      ],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.intakeCoordinator,
      dashboardRoute: ClinicalRoutes.intakeCoordinatorDashboard,
      modules: [ClinicOperationsModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.qualityAssurance,
      dashboardRoute: ClinicalRoutes.qualityAssuranceDashboard,
      modules: [ClinicSafetyModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.trainingCoordinator,
      dashboardRoute: ClinicalRoutes.trainingCoordinatorDashboard,
      modules: [ClinicOperationsModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.receptionist,
      dashboardRoute: CommonRoutes.receptionistDashboard,
      modules: [ClinicOperationsModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.rmt,
      dashboardRoute: ClinicalRoutes.rmtDashboard,
      modules: [ClinicCareModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.chiropractor,
      dashboardRoute: ClinicalRoutes.chiropractorDashboard,
      modules: [ClinicCareModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.physiotherapist,
      dashboardRoute: ClinicalRoutes.physiotherapistDashboard,
      modules: [ClinicCareModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.socialWorker,
      dashboardRoute: ClinicalRoutes.socialWorkerDashboard,
      modules: [ClinicCareModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.lpn,
      dashboardRoute: '/clinical/lpn-dashboard',
      modules: [ClinicCareModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.np,
      dashboardRoute: '/clinical/np-dashboard',
      modules: [ClinicCareModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.physician,
      dashboardRoute: '/clinical/physician-dashboard',
      modules: [ClinicCareModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.pediatric,
      dashboardRoute: '/clinical/pediatric-dashboard',
      modules: [ClinicCareModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.hsw,
      dashboardRoute: '/clinical/hsw-dashboard',
      modules: [ClinicCareModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.cns,
      dashboardRoute: '/clinical/cns-dashboard',
      modules: [ClinicCareModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.caregiver,
      dashboardRoute: '/offices/clinical/roles/caregiver/dashboard',
      modules: [ClinicCareModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.therapist,
      dashboardRoute: '/offices/clinical/roles/therapist/dashboard',
      modules: [ClinicCareModule()],
    ),
    PlatformRoleDefinition(
      role: PlatformRole.rnFieldSupervisor,
      dashboardRoute: '/rn/rn-field-supervisor-dashboard',
      modules: [
        ClinicCareModule(),
        ClinicOperationsModule(),
        ClinicSafetyModule(),
      ],
    ),
  ];
}
