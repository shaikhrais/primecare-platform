import 'package:primecare_ui/primecare_ui.dart';

class FranchiseTenant extends PlatformTenant {
  @override
  String get tenantId => 'primecare_franchise';

  @override
  String get name => 'PrimeCare Franchise';

  @override
  ThemeData get branding => PrimeThemeData(
        colors: const PrimeColors().copyWith(
          primary: const Color(0xFF6D28D9), // Deep Purple
          onPrimary: Colors.white,
          primaryContainer: const Color(0xFFEDE9FE),
        ),
      ).toThemeData();
}

class FranchiseOperationsModule extends PlatformModule {
  @override
  String get moduleId => 'franchise_operations';

  @override
  String get name => 'Franchise Operations';

  @override
  IconData get icon => Icons.storefront;

  @override
  List<PlatformRole> get allowedRoles => [
    PlatformRole.franchiseOwner,
    PlatformRole.operationsManager,
    PlatformRole.scheduler,
    PlatformRole.billingAdmin,
    PlatformRole.hrHiring,
    PlatformRole.hrManager,
    PlatformRole.owner,
  ];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Franchise Owner Dashboard',
      route: FranchiseRoutes.franchiseOwnerDashboard,
),
    PrimeCareScreen(
      title: 'Operations Manager Dashboard',
      route: FranchiseRoutes.operationsManagerDashboard,
),
    PrimeCareScreen(
      title: 'Billing Admin Dashboard',
      route: FranchiseRoutes.billingAdminDashboard,
),
    PrimeCareScreen(
      title: 'Hr Hiring Dashboard',
      route: FranchiseRoutes.hrHiringDashboard,
),
    PrimeCareScreen(
      title: 'Scheduler Dashboard',
      route: FranchiseRoutes.schedulerDashboard,
),
  ];
}

class FranchiseApplication extends PlatformApplication {
  @override
  String get appId => 'primecare_franchise';

  @override
  String get name => 'PrimeCare Franchise Portal';

  @override
  PlatformTenant get tenant => FranchiseTenant();

  @override
  List<PlatformRoleDefinition> get roleDefinitions => [
        PlatformRoleDefinition(
          role: PlatformRole.franchiseOwner,
          dashboardRoute: FranchiseRoutes.franchiseOwnerDashboard,
          modules: [FranchiseOperationsModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.operationsManager,
          dashboardRoute: FranchiseRoutes.operationsManagerDashboard,
          modules: [FranchiseOperationsModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.scheduler,
          dashboardRoute: FranchiseRoutes.schedulerDashboard,
          modules: [FranchiseOperationsModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.billingAdmin,
          dashboardRoute: FranchiseRoutes.billingAdminDashboard,
          modules: [FranchiseOperationsModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.hrHiring,
          dashboardRoute: FranchiseRoutes.hrHiringDashboard,
          modules: [FranchiseOperationsModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.hrManager,
          dashboardRoute: FranchiseRoutes.hrHiringDashboard, // Default for now
          modules: [FranchiseOperationsModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.owner,
          dashboardRoute: FranchiseRoutes.franchiseOwnerDashboard,
          modules: [FranchiseOperationsModule()],
        ),
      ];
}
