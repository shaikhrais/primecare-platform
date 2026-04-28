// Layer: 01_INFRASTRUCTURE
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/screens/common/shared_screen_stubs.dart';

/// Central registry for routes that are available across all PrimeCare portals.
/// These routes are typically hosted within a ShellRoute.
final List<RouteBase> sharedCommonRoutes = [
  GoRoute(
    path: CommonRoutes.error500,
    builder: (context, state) => CommonUiError500PageViewScreen(),
  ),
  GoRoute(
    path: CommonRoutes.error404,
    builder: (context, state) => CommonUiError404PageViewScreen(),
  ),
  GoRoute(
    path: CommonRoutes.globalProfile,
    builder: (context, state) => CommonGlobalProfileScreen(),
  ),
  GoRoute(
    path: CommonRoutes.globalSettings,
    builder: (context, state) => CommonGlobalSettingsScreen(),
  ),
  GoRoute(
    path: CommonRoutes.notificationCenter,
    builder: (context, state) => CommonNotificationCenterScreen(),
  ),
  GoRoute(
    path: CommonRoutes.messagingHub,
    builder: (context, state) => CommonMessagingHubScreen(),
  ),
  GoRoute(
    path: CommonRoutes.documentVault,
    builder: (context, state) => CommonDocumentVaultScreen(),
  ),
  GoRoute(
    path: CommonRoutes.userManagement,
    builder: (context, state) => CommonUserManagementScreen(),
  ),
  GoRoute(
    path: CommonRoutes.architecturalPlanning,
    builder: (context, state) => DashboardsArchitecturalPlanningDashboard(),
  ),
];
