import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/flutter_core.dart';

class ClinicTenant extends PlatformTenant {
  @override
  String get tenantId => 'primecare_clinic';

  @override
  String get name => 'PrimeCare Clinic';

  @override
  ThemeData get branding => ThemeData.light();
}

class ClinicOperationsModule extends PlatformModule {
  @override
  String get moduleId => 'clinic_operations';

  @override
  String get name => 'Operations';

  @override
  IconData get icon => Icons.local_hospital;

  @override
  List<PlatformRole> get allowedRoles => [
    PlatformRole.clinic,
    PlatformRole.rn,
    PlatformRole.rpn,
    PlatformRole.psw,
    PlatformRole.rmt,
    PlatformRole.chiropractor,
    PlatformRole.physiotherapist,
    PlatformRole.socialWorker,
    PlatformRole.intakeCoordinator,
    PlatformRole.systemVerification,
  ];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Clinical Intelligence',
      route: CommonRoutes.clinicDashboard,
      requiredRole: PlatformRole.clinic,
    ),
    PrimeCareScreen(
      title: 'Clinic Client Profile',
      route: CommonRoutes.clinicClientProfile,
      requiredRole: PlatformRole.clinic,
    ),
    PrimeCareScreen(
      title: 'Clinic Care Plan',
      route: CommonRoutes.clinicCarePlan,
      requiredRole: PlatformRole.clinic,
    ),
    PrimeCareScreen(
      title: 'Clinic History Logs',
      route: CommonRoutes.clinicHistoryLogs,
      requiredRole: PlatformRole.clinic,
    ),
    PrimeCareScreen(
      title: 'Clinic Profile Settings',
      route: CommonRoutes.clinicProfileSettings,
      requiredRole: PlatformRole.clinic,
    ),
    PrimeCareScreen(
      title: 'Clinic Messaging',
      route: CommonRoutes.clinicMessaging,
      requiredRole: PlatformRole.clinic,
    ),
    PrimeCareScreen(
      title: 'Clinic Incident Report',
      route: CommonRoutes.clinicIncidentReport,
      requiredRole: PlatformRole.clinic,
    ),
    PrimeCareScreen(
      title: 'Clinic Check In Out',
      route: CommonRoutes.clinicCheckInOut,
      requiredRole: PlatformRole.clinic,
    ),
    PrimeCareScreen(
      title: 'Clinic Daily Notes',
      route: CommonRoutes.clinicDailyNotes,
      requiredRole: PlatformRole.clinic,
    ),
    PrimeCareScreen(
      title: 'Clinic Shift Details',
      route: CommonRoutes.clinicShiftDetails,
      requiredRole: PlatformRole.clinic,
    ),
    PrimeCareScreen(
      title: 'Clinic My Shifts',
      route: CommonRoutes.clinicMyShifts,
      requiredRole: PlatformRole.clinic,
    ),
    PrimeCareScreen(
      title: 'Institutional Scheduler',
      route: CommonRoutes.institutionalScheduler,
      requiredRole: PlatformRole.clinic,
    ),
    PrimeCareScreen(
      title: 'System Verification',
      route: '/offices/system-verification',
      requiredRole: PlatformRole.systemVerification,
    ),
    PrimeCareScreen(
      title: 'PSW Dashboard',
      route: ClinicalRoutes.pswDashboard,
      requiredRole: PlatformRole.psw,
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
  List<PlatformModule> get modules => [ClinicOperationsModule()];
}
