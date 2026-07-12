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
      builder: (context) => PswCarePlanScreen(),
    ),
    PrimeCareScreen(
      title: 'Daily Notes',
      route: CommonRoutes.clinicDailyNotes,
      icon: LucideIcons.pencil,
      builder: (context) => PswVisitNotesScreen(),
    ),
    PrimeCareScreen(
      title: 'Client Profile',
      route: CommonRoutes.clinicClientProfile,
      icon: LucideIcons.userCircle,
      builder: (context) => PswClientProfileScreen(),
    ),
    PrimeCareScreen(
      title: 'Chiropractor Dashboard',
      route: ClinicalRoutes.chiropractorDashboard,
      icon: LucideIcons.home,
      requiredRole: PlatformRole.chiropractor,
      builder: (context) => ChiropractorDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Chiropractor Analytics',
      route: '/offices/clinical/roles/chiropractor/analytics',
      icon: LucideIcons.barChart4,
      requiredRole: PlatformRole.chiropractor,
      builder: (context) => ChiropractorAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'Chiropractor Compliance',
      route: '/offices/clinical/roles/chiropractor/compliance',
      icon: LucideIcons.shieldAlert,
      requiredRole: PlatformRole.chiropractor,
      builder: (context) => ChiropractorComplianceScreen(),
    ),
    PrimeCareScreen(
      title: 'Chiropractor Workflow',
      route: '/offices/clinical/roles/chiropractor/workflow',
      icon: LucideIcons.activity,
      requiredRole: PlatformRole.chiropractor,
      builder: (context) => ChiropractorWorkflowScreen(),
    ),
    PrimeCareScreen(
      title: 'Chiropractor Command Center',
      route: '/offices/clinical/roles/chiropractor/command-center',
      icon: LucideIcons.terminal,
      requiredRole: PlatformRole.chiropractor,
      builder: (context) => ChiropractorCommandCenterScreen(),
    ),
    PrimeCareScreen(
      title: 'Chiropractor Appointments',
      route: '/offices/clinical/roles/chiropractor/appointments',
      icon: LucideIcons.calendar,
      requiredRole: PlatformRole.chiropractor,
      builder: (context) => ChiropractorAppointmentsScreen(),
    ),
    PrimeCareScreen(
      title: 'Chiropractor Client Intake',
      route: '/offices/clinical/roles/chiropractor/client-intake',
      icon: LucideIcons.userPlus,
      requiredRole: PlatformRole.chiropractor,
      builder: (context) => ChiropractorClientIntakeScreen(),
    ),
    PrimeCareScreen(
      title: 'Chiropractor Assessment',
      route: '/offices/clinical/roles/chiropractor/assessment',
      icon: LucideIcons.clipboard,
      requiredRole: PlatformRole.chiropractor,
      builder: (context) => ChiropractorAssessmentScreen(),
    ),
    PrimeCareScreen(
      title: 'Chiropractor Treatment Notes',
      route: '/offices/clinical/roles/chiropractor/treatment-notes',
      icon: LucideIcons.fileText,
      requiredRole: PlatformRole.chiropractor,
      builder: (context) => ChiropractorTreatmentNotesScreen(),
    ),
    PrimeCareScreen(
      title: 'Chiropractor Exercise Plan',
      route: '/offices/clinical/roles/chiropractor/exercise-plan',
      icon: LucideIcons.activity,
      requiredRole: PlatformRole.chiropractor,
      builder: (context) => ChiropractorExercisePlanScreen(),
    ),
    PrimeCareScreen(
      title: 'Chiropractor Billing Link',
      route: '/offices/clinical/roles/chiropractor/billing-link',
      icon: LucideIcons.clipboard,
      requiredRole: PlatformRole.chiropractor,
      builder: (context) => ChiropractorBillingLinkScreen(),
    ),
    PrimeCareScreen(
      title: 'Chiropractor Reports',
      route: '/offices/clinical/roles/chiropractor/reports',
      icon: LucideIcons.fileBarChart,
      requiredRole: PlatformRole.chiropractor,
      builder: (context) => ChiropractorReportsScreen(),
    ),
    PrimeCareScreen(
      title: 'Chiropractic Assessment',
      route: '/offices/clinical/roles/chiropractor/chiropractic-assessment',
      icon: LucideIcons.clipboard,
      requiredRole: PlatformRole.chiropractor,
      builder: (context) => ChiropracticAssessmentScreen(),
    ),
    PrimeCareScreen(
      title: 'Adjustment Notes',
      route: '/offices/clinical/roles/chiropractor/adjustment-notes',
      icon: LucideIcons.fileText,
      requiredRole: PlatformRole.chiropractor,
      builder: (context) => AdjustmentNotesScreen(),
    ),
    PrimeCareScreen(
      title: 'Xray Review',
      route: '/offices/clinical/roles/chiropractor/xray-review',
      icon: LucideIcons.fileText,
      requiredRole: PlatformRole.chiropractor,
      builder: (context) => XrayReviewScreen(),
    ),
    PrimeCareScreen(
      title: 'Chiropractic Progress Tracking',
      route:
          '/offices/clinical/roles/chiropractor/chiropractic-progress-tracking',
      icon: LucideIcons.activity,
      requiredRole: PlatformRole.chiropractor,
      builder: (context) => ChiropracticProgressTrackingScreen(),
    ),
    PrimeCareScreen(
      title: 'Physiotherapist Dashboard',
      route: ClinicalRoutes.physiotherapistDashboard,
      icon: LucideIcons.home,
      requiredRole: PlatformRole.physiotherapist,
      builder: (context) => PhysiotherapistDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Social Worker Dashboard',
      route: ClinicalRoutes.socialWorkerDashboard,
      icon: LucideIcons.home,
      requiredRole: PlatformRole.socialWorker,
      builder: (context) => SocialWorkerDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'RMT Dashboard',
      route: ClinicalRoutes.rmtDashboard,
      icon: LucideIcons.home,
      requiredRole: PlatformRole.rmt,
      builder: (context) => RmtDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Clinical Director Dashboard',
      route: ClinicalRoutes.clinicalDirectorDashboard,
      icon: LucideIcons.home,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => ClinicalDirectorDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'LPN Dashboard',
      route: '/clinical/lpn-dashboard',
      icon: LucideIcons.home,
      requiredRole: PlatformRole.lpn,
      builder: (context) => LpnDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'LPN Analytics',
      route: '/rpn/lpn-analytics',
      icon: LucideIcons.barChart4,
      requiredRole: PlatformRole.lpn,
      builder: (context) => LicensedPracticalNurseLPNAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'LPN Compliance Workflow',
      route: '/rpn/lpn-workflow',
      icon: LucideIcons.activity,
      requiredRole: PlatformRole.lpn,
      builder: (context) => LicensedPracticalNurseLPNComplianceWorkflowScreen(),
    ),
    PrimeCareScreen(
      title: 'NP Dashboard',
      route: '/clinical/np-dashboard',
      icon: LucideIcons.home,
      requiredRole: PlatformRole.np,
      builder: (context) => NpDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'NP Analytics',
      route: '/rn/np-analytics',
      icon: LucideIcons.barChart4,
      requiredRole: PlatformRole.np,
      builder: (context) => NursePractitionerNPAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'NP Compliance Workflow',
      route: '/rn/np-workflow',
      icon: LucideIcons.activity,
      requiredRole: PlatformRole.np,
      builder: (context) => NursePractitionerNPComplianceWorkflowScreen(),
    ),
    PrimeCareScreen(
      title: 'HSW Dashboard',
      route: '/clinical/hsw-dashboard',
      icon: LucideIcons.home,
      requiredRole: PlatformRole.hsw,
      builder: (context) => HswDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'HSW ADL Logger',
      route: '/clinical/hsw-adl-logger',
      icon: LucideIcons.activity,
      requiredRole: PlatformRole.hsw,
      builder: (context) => HswAdlLoggerScreen(),
    ),
    PrimeCareScreen(
      title: 'HSW Care Plans',
      route: '/clinical/hsw-care-plans',
      icon: LucideIcons.clipboardList,
      requiredRole: PlatformRole.hsw,
      builder: (context) => HswCarePlansScreen(),
    ),
    PrimeCareScreen(
      title: 'HSW Incident Reports',
      route: '/clinical/hsw-incident-reports',
      icon: LucideIcons.alertTriangle,
      requiredRole: PlatformRole.hsw,
      builder: (context) => HswIncidentReportsScreen(),
    ),
    PrimeCareScreen(
      title: 'HSW Schedule',
      route: '/clinical/hsw-schedule',
      icon: LucideIcons.calendarDays,
      requiredRole: PlatformRole.hsw,
      builder: (context) => HswScheduleScreen(),
    ),
    PrimeCareScreen(
      title: 'Pediatric Dashboard',
      route: '/clinical/pediatric-dashboard',
      icon: LucideIcons.home,
      requiredRole: PlatformRole.pediatric,
      builder: (context) => PediatricDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Pediatric Analytics',
      route: '/clinical/pediatric-analytics',
      icon: LucideIcons.barChart4,
      requiredRole: PlatformRole.pediatric,
      builder: (context) => PediatricSpecialistAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'Pediatric Workflow',
      route: '/clinical/pediatric-workflow',
      icon: LucideIcons.activity,
      requiredRole: PlatformRole.pediatric,
      builder: (context) => PediatricSpecialistComplianceWorkflowScreen(),
    ),
    PrimeCareScreen(
      title: 'Physician Dashboard',
      route: '/clinical/physician-dashboard',
      icon: LucideIcons.home,
      requiredRole: PlatformRole.physician,
      builder: (context) => PhysicianDashboardScreen(),
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
      builder: (context) => PhysicianComplianceWorkflowScreen(),
    ),
    PrimeCareScreen(
      title: 'CNS Dashboard',
      route: '/clinical/cns-dashboard',
      icon: LucideIcons.home,
      requiredRole: PlatformRole.cns,
      builder: (context) => CnsDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Caregiver Dashboard',
      route: '/offices/clinical/roles/caregiver/dashboard',
      icon: LucideIcons.home,
      requiredRole: PlatformRole.caregiver,
      builder: (context) => CaregiverDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Caregiver Tasks',
      route: '/offices/clinical/roles/caregiver/tasks',
      icon: LucideIcons.checkSquare,
      requiredRole: PlatformRole.caregiver,
      builder: (context) => CaregiverTasksScreen(),
    ),
    PrimeCareScreen(
      title: 'Caregiver Client Profile',
      route: '/offices/clinical/roles/caregiver/client-profile',
      icon: LucideIcons.userCircle,
      requiredRole: PlatformRole.caregiver,
      builder: (context) => CaregiverClientProfileScreen(),
    ),
    PrimeCareScreen(
      title: 'Caregiver Visit Notes',
      route: '/offices/clinical/roles/caregiver/visit-notes',
      icon: LucideIcons.fileText,
      requiredRole: PlatformRole.caregiver,
      builder: (context) => CaregiverVisitNotesScreen(),
    ),
    PrimeCareScreen(
      title: 'Caregiver Schedule',
      route: '/offices/clinical/roles/caregiver/schedule',
      icon: LucideIcons.calendarDays,
      requiredRole: PlatformRole.caregiver,
      builder: (context) => CaregiverScheduleScreen(),
    ),
    PrimeCareScreen(
      title: 'Caregiver Incident Report',
      route: '/offices/clinical/roles/caregiver/incident-report',
      icon: LucideIcons.alertTriangle,
      requiredRole: PlatformRole.caregiver,
      builder: (context) => CaregiverIncidentReportScreen(),
    ),
    PrimeCareScreen(
      title: 'Therapist Dashboard',
      route: '/offices/clinical/roles/therapist/dashboard',
      icon: LucideIcons.home,
      requiredRole: PlatformRole.therapist,
      builder: (context) => TherapistDashboardScreen(),
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
      builder: (context) => TherapistComplianceWorkflowScreen(),
    ),
    // Physiotherapist Sub-Screens
    PrimeCareScreen(
      title: 'Physiotherapist Analytics',
      route: '/offices/clinical/roles/physiotherapist/analytics',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.physiotherapist,
      builder: (context) => PhysiotherapistAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'Physiotherapist Appointments',
      route: '/offices/clinical/roles/physiotherapist/appointments',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.physiotherapist,
      builder: (context) => PhysiotherapistAppointmentsScreen(),
    ),
    PrimeCareScreen(
      title: 'Physiotherapist Assessment',
      route: '/offices/clinical/roles/physiotherapist/assessment',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.physiotherapist,
      builder: (context) => PhysiotherapistAssessmentScreen(),
    ),
    PrimeCareScreen(
      title: 'Physiotherapist Billing Link',
      route: '/offices/clinical/roles/physiotherapist/billing-link',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.physiotherapist,
      builder: (context) => PhysiotherapistBillingLinkScreen(),
    ),
    PrimeCareScreen(
      title: 'Physiotherapist Client Intake',
      route: '/offices/clinical/roles/physiotherapist/client-intake',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.physiotherapist,
      builder: (context) => PhysiotherapistClientIntakeScreen(),
    ),
    PrimeCareScreen(
      title: 'Physiotherapist Command Center',
      route: '/offices/clinical/roles/physiotherapist/command-center',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.physiotherapist,
      builder: (context) => PhysiotherapistCommandCenterScreen(),
    ),
    PrimeCareScreen(
      title: 'Physiotherapist Compliance',
      route: '/offices/clinical/roles/physiotherapist/compliance',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.physiotherapist,
      builder: (context) => PhysiotherapistComplianceScreen(),
    ),
    PrimeCareScreen(
      title: 'Physiotherapist Exercise Plan',
      route: '/offices/clinical/roles/physiotherapist/exercise-plan',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.physiotherapist,
      builder: (context) => PhysiotherapistExercisePlanScreen(),
    ),
    PrimeCareScreen(
      title: 'Exercise Prescription',
      route: '/offices/clinical/roles/physiotherapist/exercise-prescription',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.physiotherapist,
      builder: (context) => ExercisePrescriptionScreen(),
    ),
    PrimeCareScreen(
      title: 'Progress Tracking',
      route: '/offices/clinical/roles/physiotherapist/progress-tracking',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.physiotherapist,
      builder: (context) => ProgressTrackingScreen(),
    ),
    PrimeCareScreen(
      title: 'Physiotherapist Reports',
      route: '/offices/clinical/roles/physiotherapist/reports',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.physiotherapist,
      builder: (context) => PhysiotherapistReportsScreen(),
    ),
    PrimeCareScreen(
      title: 'Physiotherapist Treatment Notes',
      route: '/offices/clinical/roles/physiotherapist/treatment-notes',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.physiotherapist,
      builder: (context) => PhysiotherapistTreatmentNotesScreen(),
    ),
    PrimeCareScreen(
      title: 'Treatment Plan',
      route: '/offices/clinical/roles/physiotherapist/treatment-plan',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.physiotherapist,
      builder: (context) => TreatmentPlanScreen(),
    ),
    PrimeCareScreen(
      title: 'Physiotherapist Workflow',
      route: '/offices/clinical/roles/physiotherapist/workflow',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.physiotherapist,
      builder: (context) => PhysiotherapistWorkflowScreen(),
    ),
    // RMT Sub-Screens
    PrimeCareScreen(
      title: 'Rmt Analytics',
      route: '/offices/clinical/roles/rmt/analytics',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rmt,
      builder: (context) => RmtAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'Rmt Appointments',
      route: '/offices/clinical/roles/rmt/appointments',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rmt,
      builder: (context) => RmtAppointmentsScreen(),
    ),
    PrimeCareScreen(
      title: 'Rmt Assessment',
      route: '/offices/clinical/roles/rmt/assessment',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rmt,
      builder: (context) => RmtAssessmentScreen(),
    ),
    PrimeCareScreen(
      title: 'Rmt Billing Link',
      route: '/offices/clinical/roles/rmt/billing-link',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rmt,
      builder: (context) => RmtBillingLinkScreen(),
    ),
    PrimeCareScreen(
      title: 'Rmt Client Intake',
      route: '/offices/clinical/roles/rmt/client-intake',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rmt,
      builder: (context) => RmtClientIntakeScreen(),
    ),
    PrimeCareScreen(
      title: 'Client Progress',
      route: '/offices/clinical/roles/rmt/client-progress',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rmt,
      builder: (context) => ClientProgressScreen(),
    ),
    PrimeCareScreen(
      title: 'Rmt Command Center',
      route: '/offices/clinical/roles/rmt/command-center',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rmt,
      builder: (context) => RmtCommandCenterScreen(),
    ),
    PrimeCareScreen(
      title: 'Rmt Compliance',
      route: '/offices/clinical/roles/rmt/compliance',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rmt,
      builder: (context) => RmtComplianceScreen(),
    ),
    PrimeCareScreen(
      title: 'Rmt Exercise Plan',
      route: '/offices/clinical/roles/rmt/exercise-plan',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rmt,
      builder: (context) => RmtExercisePlanScreen(),
    ),
    PrimeCareScreen(
      title: 'Home Care Plan',
      route: '/offices/clinical/roles/rmt/home-care-plan',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rmt,
      builder: (context) => HomeCarePlanScreen(),
    ),
    PrimeCareScreen(
      title: 'Massage Assessment',
      route: '/offices/clinical/roles/rmt/massage-assessment',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rmt,
      builder: (context) => MassageAssessmentScreen(),
    ),
    PrimeCareScreen(
      title: 'Rmt Reports',
      route: '/offices/clinical/roles/rmt/reports',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rmt,
      builder: (context) => RmtReportsScreen(),
    ),
    PrimeCareScreen(
      title: 'Rmt Treatment Notes',
      route: '/offices/clinical/roles/rmt/treatment-notes',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rmt,
      builder: (context) => RmtTreatmentNotesScreen(),
    ),
    PrimeCareScreen(
      title: 'Rmt Workflow',
      route: '/offices/clinical/roles/rmt/workflow',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rmt,
      builder: (context) => RmtWorkflowScreen(),
    ),
    // Social Worker Sub-Screens
    PrimeCareScreen(
      title: 'Social Worker Analytics',
      route: '/offices/clinical/roles/social_worker/analytics',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.socialWorker,
      builder: (context) => SocialWorkerAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'Social Worker Compliance',
      route: '/offices/clinical/roles/social_worker/compliance',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.socialWorker,
      builder: (context) => SocialWorkerComplianceScreen(),
    ),
    PrimeCareScreen(
      title: 'Social Worker Workflow',
      route: '/offices/clinical/roles/social_worker/workflow',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.socialWorker,
      builder: (context) => SocialWorkerWorkflowScreen(),
    ),
    // Clinical Director Sub-Screens
    PrimeCareScreen(
      title: 'Clinical Analytics',
      route: '/offices/clinical/roles/clinical_director/analytics',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => ClinicalAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'Clinical Director Approvals',
      route: '/offices/clinical/roles/clinical_director/approvals',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => ClinicalDirectorApprovalsScreen(),
    ),
    PrimeCareScreen(
      title: 'Clinic Analytics',
      route: '/offices/clinical/roles/clinical_director/clinic-analytics',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => ClinicAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'Clinic Compliance',
      route: '/offices/clinical/roles/clinical_director/clinic-compliance',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => ClinicComplianceScreen(),
    ),
    PrimeCareScreen(
      title: 'Clinic Dashboard',
      route: '/offices/clinical/roles/clinical_director/clinic-dashboard',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => ClinicDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Clinic Workflow',
      route: '/offices/clinical/roles/clinical_director/clinic-workflow',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => ClinicWorkflowScreen(),
    ),
    PrimeCareScreen(
      title: 'Clinical Compliance',
      route: '/offices/clinical/roles/clinical_director/compliance',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => ClinicalComplianceScreen(),
    ),
    PrimeCareScreen(
      title: 'Clinical Director Compliance',
      route: '/offices/clinical/roles/clinical_director/compliance-director',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => ClinicalDirectorComplianceScreen(),
    ),
    PrimeCareScreen(
      title: 'Compliance Review',
      route: '/offices/clinical/roles/clinical_director/compliance-review',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => ComplianceReviewScreen(),
    ),
    PrimeCareScreen(
      title: 'Clinical Dashboard',
      route: '/offices/clinical/roles/clinical_director/dashboard',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => ClinicalDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Incident Oversight',
      route: '/offices/clinical/roles/clinical_director/incident-oversight',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => IncidentOversightScreen(),
    ),
    PrimeCareScreen(
      title: 'Clinical Director Incident Review',
      route: '/offices/clinical/roles/clinical_director/incident-review',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => ClinicalDirectorIncidentReviewScreen(),
    ),
    PrimeCareScreen(
      title: 'Clinical Operations4 K',
      route: '/offices/clinical/roles/clinical_director/operations4k',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => ClinicalOperations4KScreen(),
    ),
    PrimeCareScreen(
      title: 'Clinical Director Performance',
      route: '/offices/clinical/roles/clinical_director/performance',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => ClinicalDirectorPerformanceScreen(),
    ),
    PrimeCareScreen(
      title: 'Clinical Quality',
      route: '/offices/clinical/roles/clinical_director/quality',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => ClinicalQualityScreen(),
    ),
    PrimeCareScreen(
      title: 'Clinical Director Reports',
      route: '/offices/clinical/roles/clinical_director/reports',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => ClinicalDirectorReportsScreen(),
    ),
    PrimeCareScreen(
      title: 'Staff Performance',
      route: '/offices/clinical/roles/clinical_director/staff-performance',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => StaffPerformanceScreen(),
    ),
    PrimeCareScreen(
      title: 'Clinical Director Staff Quality',
      route: '/offices/clinical/roles/clinical_director/staff-quality',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => ClinicalDirectorStaffQualityScreen(),
    ),
    PrimeCareScreen(
      title: 'Clinical Workflow',
      route: '/offices/clinical/roles/clinical_director/workflow',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.clinicalDirector,
      builder: (context) => ClinicalWorkflowScreen(),
    ),
    // RN Sub-Screens
    PrimeCareScreen(
      title: 'Care Plan Review',
      route: '/offices/clinical/roles/rn/care-plan-review',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => CarePlanReviewScreen(),
    ),
    PrimeCareScreen(
      title: 'Rn Dashboard',
      route: '/offices/clinical/roles/rn/dashboard',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => RnDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Incident Review',
      route: '/offices/clinical/roles/rn/incident-review',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => IncidentReviewScreen(),
    ),
    PrimeCareScreen(
      title: 'Medication Administration',
      route: '/offices/clinical/roles/rn/medication-administration',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => MedicationAdministrationScreen(),
    ),
    PrimeCareScreen(
      title: 'Rn Medications',
      route: '/offices/clinical/roles/rn/medications',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => RnMedicationsScreen(),
    ),
    PrimeCareScreen(
      title: 'Rn Patient Charting',
      route: '/offices/clinical/roles/rn/patient-charting',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => RnPatientChartingScreen(),
    ),
    PrimeCareScreen(
      title: 'Rn Analytics',
      route: '/offices/clinical/roles/rn/rn-analytics',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => RnAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'Rn Assessments',
      route: '/offices/clinical/roles/rn/rn-assessments',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => RnAssessmentsScreen(),
    ),
    PrimeCareScreen(
      title: 'Rn Care Plan Review',
      route: '/offices/clinical/roles/rn/rn-care-plan-review',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => RnCarePlanReviewScreen(),
    ),
    PrimeCareScreen(
      title: 'Rn Care Plans',
      route: '/offices/clinical/roles/rn/rn-care-plans',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => RnCarePlansScreen(),
    ),
    PrimeCareScreen(
      title: 'Rn Command Center',
      route: '/offices/clinical/roles/rn/rn-command-center',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => RnCommandCenterScreen(),
    ),
    PrimeCareScreen(
      title: 'Rn Compliance',
      route: '/offices/clinical/roles/rn/rn-compliance',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => RnComplianceScreen(),
    ),
    PrimeCareScreen(
      title: 'Rn Incident Review',
      route: '/offices/clinical/roles/rn/rn-incident-review',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => RnIncidentReviewScreen(),
    ),
    PrimeCareScreen(
      title: 'Rn Reports',
      route: '/offices/clinical/roles/rn/rn-reports',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => RnReportsScreen(),
    ),
    PrimeCareScreen(
      title: 'Rn Tasks',
      route: '/offices/clinical/roles/rn/rn-tasks',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => RnTasksScreen(),
    ),
    PrimeCareScreen(
      title: 'Rn Workflow',
      route: '/offices/clinical/roles/rn/rn-workflow',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => RnWorkflowScreen(),
    ),
    PrimeCareScreen(
      title: 'Shift Report',
      route: '/offices/clinical/roles/rn/shift-report',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => ShiftReportScreen(),
    ),
    PrimeCareScreen(
      title: 'Rn Vitals',
      route: '/offices/clinical/roles/rn/vitals',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => RnVitalsScreen(),
    ),
    // RPN Sub-Screens
    PrimeCareScreen(
      title: 'Rpn Dashboard',
      route: '/offices/clinical/roles/rpn/dashboard',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rpn,
      builder: (context) => RpnDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Medication',
      route: '/offices/clinical/roles/rpn/medication',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rpn,
      builder: (context) => MedicationScreen(),
    ),
    PrimeCareScreen(
      title: 'Rpn Medications',
      route: '/offices/clinical/roles/rpn/medications',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rpn,
      builder: (context) => RpnMedicationsScreen(),
    ),
    PrimeCareScreen(
      title: 'Nursing Task',
      route: '/offices/clinical/roles/rpn/nursing-task',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rpn,
      builder: (context) => NursingTaskScreen(),
    ),
    PrimeCareScreen(
      title: 'Rpn Patient Charting',
      route: '/offices/clinical/roles/rpn/patient-charting',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rpn,
      builder: (context) => RpnPatientChartingScreen(),
    ),
    PrimeCareScreen(
      title: 'Patient Observation',
      route: '/offices/clinical/roles/rpn/patient-observation',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rpn,
      builder: (context) => PatientObservationScreen(),
    ),
    PrimeCareScreen(
      title: 'Rpn Analytics',
      route: '/offices/clinical/roles/rpn/rpn-analytics',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rpn,
      builder: (context) => RpnAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'Rpn Care Plan Review',
      route: '/offices/clinical/roles/rpn/rpn-care-plan-review',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rpn,
      builder: (context) => RpnCarePlanReviewScreen(),
    ),
    PrimeCareScreen(
      title: 'Rpn Command Center',
      route: '/offices/clinical/roles/rpn/rpn-command-center',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rpn,
      builder: (context) => RpnCommandCenterScreen(),
    ),
    PrimeCareScreen(
      title: 'Rpn Compliance',
      route: '/offices/clinical/roles/rpn/rpn-compliance',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rpn,
      builder: (context) => RpnComplianceScreen(),
    ),
    PrimeCareScreen(
      title: 'Rpn Incident Review',
      route: '/offices/clinical/roles/rpn/rpn-incident-review',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rpn,
      builder: (context) => RpnIncidentReviewScreen(),
    ),
    PrimeCareScreen(
      title: 'Rpn Reports',
      route: '/offices/clinical/roles/rpn/rpn-reports',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rpn,
      builder: (context) => RpnReportsScreen(),
    ),
    PrimeCareScreen(
      title: 'Rpn Tasks',
      route: '/offices/clinical/roles/rpn/rpn-tasks',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rpn,
      builder: (context) => RpnTasksScreen(),
    ),
    PrimeCareScreen(
      title: 'Rpn Workflow',
      route: '/offices/clinical/roles/rpn/rpn-workflow',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rpn,
      builder: (context) => RpnWorkflowScreen(),
    ),
    PrimeCareScreen(
      title: 'Rpn Vitals',
      route: '/offices/clinical/roles/rpn/vitals',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rpn,
      builder: (context) => RpnVitalsScreen(),
    ),
    PrimeCareScreen(
      title: 'Vitals Tracking',
      route: '/offices/clinical/roles/rpn/vitals-tracking',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rpn,
      builder: (context) => VitalsTrackingScreen(),
    ),
    // Other clinical common screens
    PrimeCareScreen(
      title: 'Agent Dispatch',
      route: '/common/agent-dispatch',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => AgentDispatchScreen(),
    ),
    PrimeCareScreen(
      title: 'Api Health Dashboard',
      route: '/common/api-health-dashboard',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => ApiHealthDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Audit',
      route: '/common/audit',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => ScreenAuditScreen(),
    ),
    PrimeCareScreen(
      title: 'Drift Findings',
      route: '/common/drift-findings',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => DriftFindingsScreen(),
    ),
    PrimeCareScreen(
      title: 'File Verification Dashboard',
      route: '/common/file-verification-dashboard',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => FileVerificationDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Governance Control Room',
      route: '/common/governance-control-room',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => GovernanceControlRoomScreen(),
    ),
    PrimeCareScreen(
      title: 'Governance Operations4 K',
      route: '/common/governance-operations4-k',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => GovernanceOperations4KScreen(),
    ),
    PrimeCareScreen(
      title: 'Pending Task Queue',
      route: '/common/pending-task-queue',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => PendingTaskQueueScreen(),
    ),
    PrimeCareScreen(
      title: 'Release Operations',
      route: '/common/release-operations',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => ReleaseOperationsScreen(),
    ),
    PrimeCareScreen(
      title: 'Responsive Preview',
      route: '/common/responsive-preview',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => ResponsivePreviewScreen(),
    ),
    PrimeCareScreen(
      title: 'Role Coverage Dashboard',
      route: '/common/role-coverage-dashboard',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => RoleCoverageDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Runtime Verification',
      route: '/common/runtime-verification',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => RuntimeVerificationScreen(),
    ),
    PrimeCareScreen(
      title: 'System Dashboard',
      route: '/common/system-dashboard',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => SystemDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Workflow Execution',
      route: '/common/workflow-execution',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => WorkflowExecutionScreen(),
    ),
    PrimeCareScreen(
      title: 'Governance Officer Analytics',
      route: '/management/governance-officer-analytics',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => GovernanceOfficerAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'Governance Officer Compliance',
      route: '/management/governance-officer-compliance',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => GovernanceOfficerComplianceScreen(),
    ),
    PrimeCareScreen(
      title: 'Governance Officer Dashboard',
      route: '/management/governance-officer-dashboard',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => GovernanceOfficerDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Governance Officer Workflow',
      route: '/management/governance-officer-workflow',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rn,
      builder: (context) => GovernanceOfficerWorkflowScreen(),
    ),
    PrimeCareScreen(
      title: 'Rn Field Supervisor Dashboard',
      route: '/rn/rn-field-supervisor-dashboard',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.rnFieldSupervisor,
      builder: (context) => RnFieldSupervisorDashboardScreen(),
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
      builder: (context) => CareDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'My Shifts',
      route: CommonRoutes.clinicMyShifts,
      icon: LucideIcons.calendarDays,
      builder: (context) => PswMyShiftsScreen(),
    ),
    PrimeCareScreen(
      title: 'Messaging',
      route: CommonRoutes.clinicMessaging,
      icon: LucideIcons.messageSquare,
      builder: (context) => PswMessagesScreen(),
    ),
    PrimeCareScreen(
      title: 'Intake Coordinator Dashboard',
      route: ClinicalRoutes.intakeCoordinatorDashboard,
      icon: LucideIcons.home,
      requiredRole: PlatformRole.intakeCoordinator,
      builder: (context) => IntakeCoordinatorDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Training Coordinator Dashboard',
      route: ClinicalRoutes.trainingCoordinatorDashboard,
      icon: LucideIcons.home,
      requiredRole: PlatformRole.trainingCoordinator,
      builder: (context) => TrainingCoordinatorDashboardScreen(),
    ),
    // Intake Coordinator Sub-Screens
    PrimeCareScreen(
      title: 'Intake Analytics',
      route: '/offices/clinical/roles/intake_coordinator/analytics',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.intakeCoordinator,
      builder: (context) => IntakeAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'Booking',
      route: '/offices/clinical/roles/intake_coordinator/booking',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.intakeCoordinator,
      builder: (context) => BookingScreen(),
    ),
    PrimeCareScreen(
      title: 'Client Intake',
      route: '/offices/clinical/roles/intake_coordinator/client-intake',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.intakeCoordinator,
      builder: (context) => ClientIntakeScreen(),
    ),
    PrimeCareScreen(
      title: 'Intake Compliance',
      route: '/offices/clinical/roles/intake_coordinator/compliance',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.intakeCoordinator,
      builder: (context) => IntakeComplianceScreen(),
    ),
    PrimeCareScreen(
      title: 'Intake Coordinator Analytics',
      route: '/offices/clinical/roles/intake_coordinator/coordinator-analytics',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.intakeCoordinator,
      builder: (context) => IntakeCoordinatorAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'Intake Coordinator Compliance',
      route: '/offices/clinical/roles/intake_coordinator/coordinator-compliance',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.intakeCoordinator,
      builder: (context) => IntakeCoordinatorComplianceScreen(),
    ),
    PrimeCareScreen(
      title: 'Intake Coordinator Dashboard',
      route: '/offices/clinical/roles/intake_coordinator/coordinator-dashboard',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.intakeCoordinator,
      builder: (context) => IntakeCoordinatorDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Intake Coordinator Workflow',
      route: '/offices/clinical/roles/intake_coordinator/coordinator-workflow',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.intakeCoordinator,
      builder: (context) => IntakeCoordinatorWorkflowScreen(),
    ),
    PrimeCareScreen(
      title: 'Intake Dashboard',
      route: '/offices/clinical/roles/intake_coordinator/dashboard',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.intakeCoordinator,
      builder: (context) => IntakeDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Followup',
      route: '/offices/clinical/roles/intake_coordinator/followup',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.intakeCoordinator,
      builder: (context) => FollowupScreen(),
    ),
    PrimeCareScreen(
      title: 'Referral Management',
      route: '/offices/clinical/roles/intake_coordinator/referral-management',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.intakeCoordinator,
      builder: (context) => ReferralManagementScreen(),
    ),
    PrimeCareScreen(
      title: 'Intake Workflow',
      route: '/offices/clinical/roles/intake_coordinator/workflow',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.intakeCoordinator,
      builder: (context) => IntakeWorkflowScreen(),
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
      builder: (context) => ClinicIncidentReportScreen(),
    ),
    PrimeCareScreen(
      title: 'History Logs',
      route: CommonRoutes.clinicHistoryLogs,
      icon: LucideIcons.history,
      builder: (context) => ClinicHistoryLogsScreen(),
    ),
    PrimeCareScreen(
      title: 'QA Dashboard',
      route: ClinicalRoutes.qualityAssuranceDashboard,
      icon: LucideIcons.home,
      requiredRole: PlatformRole.qualityAssurance,
      builder: (context) => QaDashboardScreen(),
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
      builder: (context) => CareDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Shift Tracker',
      route: ClinicalRoutes.pswSchedule,
      icon: LucideIcons.clock,
      builder: (context) => PswShiftTrackerScreen(),
    ),
    PrimeCareScreen(
      title: 'My Clients',
      route: ClinicalRoutes.pswPatientProfile,
      icon: LucideIcons.users,
      builder: (context) => PswClientsScreen(),
    ),
    PrimeCareScreen(
      title: 'Task List',
      route: ClinicalRoutes.pswVisitChecklist,
      icon: LucideIcons.checkSquare,
      builder: (context) => PswTasksScreen(),
    ),
    PrimeCareScreen(
      title: 'Messages',
      route: ClinicalRoutes.pswMessages,
      icon: LucideIcons.messageSquare,
      builder: (context) => PswMessagesScreen(),
    ),
    PrimeCareScreen(
      title: 'Visit Notes',
      route: ClinicalRoutes.pswVisitNotes,
      icon: LucideIcons.fileText,
      builder: (context) => PswVisitNotesScreen(),
    ),
    PrimeCareScreen(
      title: 'Profile',
      route: ClinicalRoutes.pswProfile,
      icon: LucideIcons.user,
      builder: (context) => PswClientProfileScreen(),
    ),
    PrimeCareScreen(
      title: 'Reports',
      route: ClinicalRoutes.pswReports,
      icon: LucideIcons.fileBarChart,
      builder: (context) => PswAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'Documents',
      route: ClinicalRoutes.pswDocuments,
      icon: LucideIcons.folder,
      builder: (context) => PswDocumentsScreen(),
    ),
    PrimeCareScreen(
      title: 'Check-In',
      route: ClinicalRoutes.pswCheckIn,
      icon: LucideIcons.mapPin,
      builder: (context) => PswShiftTrackerScreen(),
    ),
    PrimeCareScreen(
      title: 'System Logs',
      route: ClinicalRoutes.pswSystemLogs,
      icon: LucideIcons.terminal,
      builder: (context) => PswCommandCenterScreen(),
    ),
    PrimeCareScreen(
      title: 'Notifications',
      route: ClinicalRoutes.pswNotifications,
      icon: LucideIcons.bell,
      builder: (context) => PswMessagesScreen(),
    ),
    PrimeCareScreen(
      title: 'Help & Support',
      route: ClinicalRoutes.pswHelpSupport,
      icon: LucideIcons.helpCircle,
      builder: (context) => PswComplianceScreen(),
    ),
    PrimeCareScreen(
      title: 'Psw Care Plan',
      route: '/offices/clinical/roles/psw/care-plan',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.psw,
      builder: (context) => PswCarePlanScreen(),
    ),
    PrimeCareScreen(
      title: 'Psw Analytics',
      route: '/offices/clinical/roles/psw/psw-analytics',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.psw,
      builder: (context) => PswAnalyticsScreen(),
    ),
    PrimeCareScreen(
      title: 'Psw Client Profile',
      route: '/offices/clinical/roles/psw/psw-client-profile',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.psw,
      builder: (context) => PswClientProfileScreen(),
    ),
    PrimeCareScreen(
      title: 'Psw Command Center',
      route: '/offices/clinical/roles/psw/psw-command-center',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.psw,
      builder: (context) => PswCommandCenterScreen(),
    ),
    PrimeCareScreen(
      title: 'Psw Compliance',
      route: '/offices/clinical/roles/psw/psw-compliance',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.psw,
      builder: (context) => PswComplianceScreen(),
    ),
    PrimeCareScreen(
      title: 'Psw My Shifts',
      route: '/offices/clinical/roles/psw/psw-my-shifts',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.psw,
      builder: (context) => PswMyShiftsScreen(),
    ),
    PrimeCareScreen(
      title: 'Psw Workflow',
      route: '/offices/clinical/roles/psw/psw-workflow',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.psw,
      builder: (context) => PswWorkflowScreen(),
    ),
    PrimeCareScreen(
      title: 'Shift Tasks',
      route: '/offices/clinical/roles/psw/shift-tasks',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.psw,
      builder: (context) => ShiftTasksScreen(),
    ),
    PrimeCareScreen(
      title: 'Vitals Entry',
      route: '/offices/clinical/roles/psw/vitals-entry',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.psw,
      builder: (context) => VitalsEntryScreen(),
    ),
    PrimeCareScreen(
      title: 'Psw Vitals Log',
      route: '/offices/clinical/roles/psw/observation-vitals-log',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.psw,
      builder: (context) => PswVitalsLogScreen(),
    ),
    PrimeCareScreen(
      title: 'Psw Incident Report',
      route: '/offices/clinical/roles/psw/incident-report',
      icon: LucideIcons.circleDot,
      requiredRole: PlatformRole.psw,
      builder: (context) => PswIncidentReportScreen(),
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
