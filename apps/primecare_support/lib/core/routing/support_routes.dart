// Governance - Category: middleware | Purpose: Routing definition mapping client endpoints, paths, layouts, and access guards.
import 'package:primecare_ui/primecare_ui.dart'
    hide
        HelpDeskDashboardScreen,
        EscalationDashboardScreen,
        QualityAssuranceDashboardScreen,
        TrainingCoordinatorDashboardScreen;
import 'package:flutter_core/theme/theme_config_generated.dart';
import '../../features/support/screens/help_desk_dashboard_screen.dart';
import '../../features/support/screens/escalation_dashboard_screen.dart';
import '../../features/support/screens/it_administrator_dashboard_screen.dart';
import '../../features/support/screens/quality_assurance_dashboard_screen.dart';
import '../../features/support/screens/training_coordinator_dashboard_screen.dart';
import 'package:flutter_core/flutter_core.dart';

class SupportRoutes {
  static const String helpDeskDashboard = '/offices/support/roles/customer_support/dashboard';
  static const String escalationDashboard = '/offices/support/roles/customer_support/escalations';
  static const String premiumConciergeDashboard = '/management/premium-concierge-dashboard';
  static const String vipManagerDashboard = '/management/vip-manager-dashboard';
  static const String itAdminDashboard = '/offices/support/roles/it_admin/dashboard';
  static const String trainingCoordinatorDashboard = '/offices/support/roles/training_coordinator/dashboard';
  static const String qaSpecialistDashboard = '/offices/support/roles/qa_specialist/dashboard';
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

class SupportManagementModule extends PlatformModule {
  @override
  String get moduleId => 'support_management';

  @override
  String get name => 'Support Management';

  @override
  IconData get icon => Icons.admin_panel_settings;

  @override
  List<PlatformRole> get allowedRoles => [
    PlatformRole.premiumConcierge,
    PlatformRole.vipManager,
  ];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Premium Concierge Dashboard',
      route: SupportRoutes.premiumConciergeDashboard,
      builder: (context) => const PremiumConciergeDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'VIP Manager Dashboard',
      route: SupportRoutes.vipManagerDashboard,
      builder: (context) => const VipManagerDashboardScreen(),
    ),
  ];
}

class SupportItAdminModule extends PlatformModule {
  @override
  String get moduleId => 'support_it_admin';

  @override
  String get name => 'Support IT Admin';

  @override
  IconData get icon => Icons.admin_panel_settings;

  @override
  List<PlatformRole> get allowedRoles => [
        PlatformRole.itAdmin,
      ];

  @override
  List<PrimeCareScreen> get screens => [
        PrimeCareScreen(
          title: 'IT Administrator Dashboard',
          route: SupportRoutes.itAdminDashboard,
          builder: (context) => const ItAdministratorDashboardScreen(),
        ),
      ];
}

class SupportTrainingModule extends PlatformModule {
  @override
  String get moduleId => 'support_training';

  @override
  String get name => 'Support Training';

  @override
  IconData get icon => Icons.school;

  @override
  List<PlatformRole> get allowedRoles => [
        PlatformRole.trainingCoordinator,
      ];

  @override
  List<PrimeCareScreen> get screens => [
        PrimeCareScreen(
          title: 'Training Coordinator Dashboard',
          route: SupportRoutes.trainingCoordinatorDashboard,
          builder: (context) => const TrainingCoordinatorDashboardScreen(),
        ),
      ];
}

class SupportQaModule extends PlatformModule {
  @override
  String get moduleId => 'support_qa';

  @override
  String get name => 'Support QA';

  @override
  IconData get icon => Icons.assignment_turned_in;

  @override
  List<PlatformRole> get allowedRoles => [
        PlatformRole.qaSpecialist,
      ];

  @override
  List<PrimeCareScreen> get screens => [
        PrimeCareScreen(
          title: 'QA Specialist Dashboard',
          route: SupportRoutes.qaSpecialistDashboard,
          builder: (context) => const QualityAssuranceDashboardScreen(),
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
        PlatformRoleDefinition(
          role: PlatformRole.premiumConcierge,
          dashboardRoute: SupportRoutes.premiumConciergeDashboard,
          modules: [SupportManagementModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.vipManager,
          dashboardRoute: SupportRoutes.vipManagerDashboard,
          modules: [SupportManagementModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.itAdmin,
          dashboardRoute: SupportRoutes.itAdminDashboard,
          modules: [SupportItAdminModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.trainingCoordinator,
          dashboardRoute: SupportRoutes.trainingCoordinatorDashboard,
          modules: [SupportTrainingModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.qaSpecialist,
          dashboardRoute: SupportRoutes.qaSpecialistDashboard,
          modules: [SupportQaModule()],
        ),
      ];
}
