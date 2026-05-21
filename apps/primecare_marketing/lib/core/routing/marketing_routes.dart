import 'package:primecare_ui/primecare_ui.dart' hide
    LocalMarketingManagerDashboardScreen,
    CommunityOutreachDashboardScreen,
    TerritorySalesManagerDashboardScreen;
import 'package:flutter_core/flutter_core.dart';
import '../../features/marketing/screens/local_marketing_manager_dashboard_screen.dart';
import '../../features/marketing/screens/community_outreach_dashboard_screen.dart';
import '../../features/marketing/screens/territory_sales_manager_dashboard_screen.dart';

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
    PlatformRole.territorySalesManager,
    PlatformRole.systemVerification,
  ];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Marketing Dashboard',
      route: MarketingRoutes.localMarketingManagerDashboard,
      builder: (context) => const LocalMarketingManagerDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Outreach Dashboard',
      route: MarketingRoutes.communityOutreachDashboard,
      builder: (context) => const CommunityOutreachDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Territory Sales Dashboard',
      route: MarketingRoutes.territorySalesManagerDashboard,
      builder: (context) => const TerritorySalesManagerDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'System Verification',
      route: '/offices/system-verification',
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
          role: PlatformRole.territorySalesManager,
          dashboardRoute: MarketingRoutes.territorySalesManagerDashboard,
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
