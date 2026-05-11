import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ClinicTenant extends PlatformTenant {
  @override
  String get tenantId => 'primecare_clinic';

  @override
  String get name => 'PrimeCare Clinic';
  
  @override
  ThemeData get branding => ThemeData(
    primaryColor: const Color(0xFF2E7D32), // Medical Green
    useMaterial3: true,
  );
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
          requiredRole: PlatformRole.clinic,
          icon: LucideIcons.clipboardList,
        ),
        PrimeCareScreen(
          title: 'Daily Notes',
          route: CommonRoutes.clinicDailyNotes,
          requiredRole: PlatformRole.clinic,
          icon: LucideIcons.pencil,

        ),
        PrimeCareScreen(
          title: 'Client Profile',
          route: CommonRoutes.clinicClientProfile,
          requiredRole: PlatformRole.clinic,
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
          requiredRole: PlatformRole.clinic,
          icon: LucideIcons.barChart4,
        ),
        PrimeCareScreen(
          title: 'My Shifts',
          route: CommonRoutes.clinicMyShifts,
          requiredRole: PlatformRole.clinic,
          icon: LucideIcons.calendarDays,
        ),
        PrimeCareScreen(
          title: 'Messaging',
          route: CommonRoutes.clinicMessaging,
          requiredRole: PlatformRole.clinic,
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
          requiredRole: PlatformRole.clinic,
          icon: LucideIcons.alertTriangle,
        ),
        PrimeCareScreen(
          title: 'History Logs',
          route: CommonRoutes.clinicHistoryLogs,
          requiredRole: PlatformRole.clinic,
          icon: LucideIcons.history,
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
          dashboardRoute: CommonRoutes.clinicDashboard,
          modules: [ClinicCareModule(), ClinicOperationsModule()],
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
