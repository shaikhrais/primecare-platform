import 'package:primecare_ui/primecare_ui.dart';

class ClientTenant extends PlatformTenant {
  @override
  String get tenantId => 'primecare_client';

  @override
  String get name => 'PrimeCare Client Portal';

  @override
  ThemeData get branding => PrimeThemeData(
        colors: const PrimeColors().copyWith(
          primary: const Color(0xFF0EA5E9), // Soft Accessible Blue
          onPrimary: Colors.white,
          primaryContainer: const Color(0xFFE0F2FE),
        ),
      ).toThemeData();
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
// Assuming client also maps to patient
    ),
    PrimeCareScreen(
      title: 'Family Dashboard',
      route: ClientRoutes.familyMemberDashboard,
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
  List<PlatformRoleDefinition> get roleDefinitions => [
        PlatformRoleDefinition(
          role: PlatformRole.patient,
          dashboardRoute: ClientRoutes.patientDashboard,
          modules: [ClientOperationsModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.familyMember,
          dashboardRoute: ClientRoutes.familyMemberDashboard,
          modules: [ClientOperationsModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.client,
          dashboardRoute: ClientRoutes.patientDashboard,
          modules: [ClientOperationsModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.guest,
          dashboardRoute: ClientRoutes.patientDashboard, // Fallback
          modules: [ClientOperationsModule()],
        ),
      ];
}
