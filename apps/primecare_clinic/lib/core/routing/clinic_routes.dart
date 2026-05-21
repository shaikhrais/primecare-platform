import 'package:primecare_ui/primecare_ui.dart' hide PswDashboardScreen, PswMessagesScreen, PswVisitNotesScreen;
class ClinicTenant extends PlatformTenant {
  @override
  String get tenantId => 'primecare_clinic';

  @override
  String get name => 'PrimeCare Clinic';
  
  @override
  ThemeData get branding => PrimeThemeData(
        colors: const PrimeColors().copyWith(
          primary: const Color(0xFF0F766E), // Medical Teal
          onPrimary: Colors.white,
          primaryContainer: const Color(0xFFCCFBF1),
        ),
      ).toThemeData();
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
      ];
  @override
  List<PrimeCareScreen> get screens => [
        PrimeCareScreen(
          title: 'Care Plan',
          route: CommonRoutes.clinicCarePlan,
          icon: LucideIcons.clipboardList,
        ),
        PrimeCareScreen(
          title: 'Daily Notes',
          route: CommonRoutes.clinicDailyNotes,
          icon: LucideIcons.pencil,

        ),
        PrimeCareScreen(
          title: 'Client Profile',
          route: CommonRoutes.clinicClientProfile,
          icon: LucideIcons.userCircle,
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
      ];
  @override
  List<PrimeCareScreen> get screens => [
        PrimeCareScreen(
          title: 'Clinical Intelligence',
          route: CommonRoutes.clinicDashboard,
          icon: LucideIcons.barChart4,
        ),
        PrimeCareScreen(
          title: 'My Shifts',
          route: CommonRoutes.clinicMyShifts,
          icon: LucideIcons.calendarDays,
        ),
        PrimeCareScreen(
          title: 'Messaging',
          route: CommonRoutes.clinicMessaging,
          icon: LucideIcons.messageSquare,
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
      ];
  @override
  List<PrimeCareScreen> get screens => [
        PrimeCareScreen(
          title: 'Incident Report',
          route: CommonRoutes.clinicIncidentReport,
          icon: LucideIcons.alertTriangle,
        ),
        PrimeCareScreen(
          title: 'History Logs',
          route: CommonRoutes.clinicHistoryLogs,
          icon: LucideIcons.history,
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
          
        ),
        PrimeCareScreen(
          title: 'Shift Tracker',
          route: ClinicalRoutes.pswSchedule,
          icon: LucideIcons.clock,
          
        ),
        PrimeCareScreen(
          title: 'My Clients',
          route: ClinicalRoutes.pswPatientProfile,
          icon: LucideIcons.users,
          
        ),
        PrimeCareScreen(
          title: 'Task List',
          route: ClinicalRoutes.pswVisitChecklist,
          icon: LucideIcons.checkSquare,
          
        ),
        PrimeCareScreen(
          title: 'Messages',
          route: ClinicalRoutes.pswMessages,
          icon: LucideIcons.messageSquare,
          
        ),
        PrimeCareScreen(
          title: 'Visit Notes',
          route: ClinicalRoutes.pswVisitNotes,
          icon: LucideIcons.fileText,
          
        ),
        PrimeCareScreen(
          title: 'Profile',
          route: ClinicalRoutes.pswProfile,
          icon: LucideIcons.user,
          
        ),
        PrimeCareScreen(
          title: 'Reports',
          route: ClinicalRoutes.pswReports,
          icon: LucideIcons.fileBarChart,
          
        ),
        PrimeCareScreen(
          title: 'Documents',
          route: ClinicalRoutes.pswDocuments,
          icon: LucideIcons.folder,
          
        ),
        PrimeCareScreen(
          title: 'Check-In',
          route: ClinicalRoutes.pswCheckIn,
          icon: LucideIcons.mapPin,
          
        ),
        PrimeCareScreen(
          title: 'System Logs',
          route: ClinicalRoutes.pswSystemLogs,
          icon: LucideIcons.terminal,
          
        ),
        PrimeCareScreen(
          title: 'Notifications',
          route: ClinicalRoutes.pswNotifications,
          icon: LucideIcons.bell,
          
        ),
        PrimeCareScreen(
          title: 'Help & Support',
          route: ClinicalRoutes.pswHelpSupport,
          icon: LucideIcons.helpCircle,
          
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
  List<PlatformRoleDefinition> get roleDefinitions => [
        PlatformRoleDefinition(
          role: PlatformRole.clinic,
          dashboardRoute: CommonRoutes.clinicDashboard,
          modules: [ClinicCareModule(), ClinicOperationsModule(), ClinicSafetyModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.rn,
          dashboardRoute: CommonRoutes.clinicDashboard,
          modules: [ClinicCareModule(), ClinicOperationsModule(), ClinicSafetyModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.rpn,
          dashboardRoute: CommonRoutes.clinicDashboard,
          modules: [ClinicCareModule(), ClinicOperationsModule(), ClinicSafetyModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.psw,
          dashboardRoute: ClinicalRoutes.pswDashboard,
          modules: [ClinicPswModule(), ClinicCareModule(), ClinicOperationsModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.clinicalDirector,
          dashboardRoute: ClinicalRoutes.clinicalDirectorDashboard,
          modules: [ClinicCareModule(), ClinicOperationsModule(), ClinicSafetyModule()],
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
      ];
}
