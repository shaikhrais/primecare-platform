// Governance - Category: middleware | Purpose: Routing definition mapping client endpoints, paths, layouts, and access guards.
import 'package:primecare_ui/primecare_ui.dart' hide HelpDeskDashboardScreen, EscalationDashboardScreen;
import 'package:flutter_core/theme/theme_config_generated.dart';
import '../../features/support/screens/help_desk_dashboard_screen.dart';
import '../../features/support/screens/escalation_dashboard_screen.dart';

class SupportRoutes {
  static const String helpDeskDashboard = '/helpdesk';
  static const String escalationDashboard = '/escalation';
}

class SupportTenant extends PlatformTenant {
  @override
  String get tenantId => 'primecare_support';

  @override
  String get name => 'PrimeCare Support';

  @override
  ThemeData get branding => PrimeThemeData(
        colors: PrimeColors.fromPalette(ThemeConfig.getAppPalette('support')),
      ).toThemeData();
}

class SupportOperationsModule extends PlatformModule {
  @override
  String get moduleId => 'support_operations';

  @override
  String get name => 'Support Operations';

  @override
  IconData get icon => Icons.support_agent;

  @override
  List<PlatformRole> get allowedRoles => [
    PlatformRole.support,
    PlatformRole.customerSupport,
    PlatformRole.systemVerification,
  ];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Help Desk Dashboard',
      route: SupportRoutes.helpDeskDashboard,
      builder: (context) => const HelpDeskDashboardScreen(),
),
    PrimeCareScreen(
      title: 'Escalation Dashboard',
      route: SupportRoutes.escalationDashboard,
      builder: (context) => const EscalationDashboardScreen(),
),
    PrimeCareScreen(
      title: 'System Verification',
      route: '/offices/system-verification',
),
  ];
}

class SupportApplication extends PlatformApplication {
  @override
  String get appId => 'primecare_support';

  @override
  String get name => 'PrimeCare Support Portal';

  @override
  PlatformTenant get tenant => SupportTenant();

  @override
  List<PlatformRoleDefinition> get roleDefinitions => [
        PlatformRoleDefinition(
          role: PlatformRole.support,
          dashboardRoute: SupportRoutes.helpDeskDashboard,
          modules: [SupportOperationsModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.customerSupport,
          dashboardRoute: SupportRoutes.helpDeskDashboard,
          modules: [SupportOperationsModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.systemVerification,
          dashboardRoute: '/offices/system-verification',
          modules: [SupportOperationsModule()],
        ),
      ];
}
