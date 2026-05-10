import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/flutter_core.dart';

class ClientTenant extends PlatformTenant {
  @override
  String get tenantId => 'primecare_client';

  @override
  String get name => 'PrimeCare Client Portal';

  @override
  ThemeData get branding => ThemeData.light(); // Could be customized for patient view
}

class ClientOperationsModule extends PlatformModule {
  @override
  String get moduleId => 'client_operations';

  @override
  String get name => 'Client Operations';

  @override
  IconData get icon => Icons.health_and_safety;

  @override
  List<PlatformRole> get allowedRoles => [
    PlatformRole.patient,
    PlatformRole.familyMember,
    PlatformRole.client,
    PlatformRole.guest,
  ];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Patient Dashboard',
      route: ClientRoutes.patientDashboard,
      requiredRole:
          PlatformRole.patient, // Assuming client also maps to patient
    ),
    PrimeCareScreen(
      title: 'Family Dashboard',
      route: ClientRoutes.familyMemberDashboard,
      requiredRole: PlatformRole.familyMember,
    ),
  ];
}

class ClientApplication extends PlatformApplication {
  @override
  String get appId => 'primecare_client';

  @override
  String get name => 'PrimeCare Client Portal';

  @override
  PlatformTenant get tenant => ClientTenant();

  @override
  List<PlatformModule> get modules => [ClientOperationsModule()];
}
