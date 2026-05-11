import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/flutter_core.dart';

class MarketingRoutes {
  static const String localMarketingManagerDashboard = '/local-marketing';
  static const String communityOutreachDashboard = '/outreach';
}

class MarketingTenant extends PlatformTenant {
  @override
  String get tenantId => 'primecare_marketing';

  @override
  String get name => 'PrimeCare Marketing';

  @override
  ThemeData get branding => ThemeData.light();
}

class MarketingOperationsModule extends PlatformModule {
  @override
  String get moduleId => 'marketing_operations';

  @override
  String get name => 'Marketing Operations';

  @override
  IconData get icon => Icons.campaign;

  @override
  List<PlatformRole> get allowedRoles => [
    PlatformRole.headOfMarketing,
    PlatformRole.localMarketingManager,
    PlatformRole.communityOutreach,
    PlatformRole.systemVerification,
  ];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Marketing Dashboard',
      route: MarketingRoutes.localMarketingManagerDashboard,
      requiredRole: PlatformRole.localMarketingManager,
    ),
    PrimeCareScreen(
      title: 'Outreach Dashboard',
      route: MarketingRoutes.communityOutreachDashboard,
      requiredRole: PlatformRole.communityOutreach,
    ),
    PrimeCareScreen(
      title: 'System Verification',
      route: '/offices/system-verification',
      requiredRole: PlatformRole.systemVerification,
    ),
  ];
}

class MarketingApplication extends PlatformApplication {
  @override
  String get appId => 'primecare_marketing';

  @override
  String get name => 'PrimeCare Marketing Portal';

  @override
  PlatformTenant get tenant => MarketingTenant();

  @override
  List<PlatformRoleDefinition> get roleDefinitions => [
        PlatformRoleDefinition(
          role: PlatformRole.localMarketingManager,
          dashboardRoute: MarketingRoutes.localMarketingManagerDashboard,
          modules: [MarketingOperationsModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.communityOutreach,
          dashboardRoute: MarketingRoutes.communityOutreachDashboard,
          modules: [MarketingOperationsModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.headOfMarketing,
          dashboardRoute: MarketingRoutes.localMarketingManagerDashboard,
          modules: [MarketingOperationsModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.systemVerification,
          dashboardRoute: '/offices/system-verification',
          modules: [MarketingOperationsModule()],
        ),
      ];
}
