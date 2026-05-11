import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/flutter_core.dart';

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
  ThemeData get branding => ThemeData.light();
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
      requiredRole: PlatformRole.support,
    ),
    PrimeCareScreen(
      title: 'Escalation Dashboard',
      route: SupportRoutes.escalationDashboard,
      requiredRole: PlatformRole.support,
    ),
    PrimeCareScreen(
      title: 'System Verification',
      route: '/offices/system-verification',
      requiredRole: PlatformRole.systemVerification,
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
