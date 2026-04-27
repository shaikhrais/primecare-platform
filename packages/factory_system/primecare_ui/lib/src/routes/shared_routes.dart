// Layer: 01_INFRASTRUCTURE
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/screens/common/user_management.dart';

/// Central registry for routes that are available across all PrimeCare portals.
/// These routes are typically hosted within a ShellRoute.
final List<RouteBase> sharedCommonRoutes = [
  GoRoute(
    path: CommonRoutes.error500,
    builder: (context, state) => Error500PageViewScreen(),
  ),
  GoRoute(
    path: CommonRoutes.error404,
    builder: (context, state) => Error404PageViewScreen(),
  ),
  GoRoute(
    path: CommonRoutes.globalProfile,
    builder: (context, state) => GlobalProfileScreen(),
  ),
  GoRoute(
    path: CommonRoutes.globalSettings,
    builder: (context, state) => GlobalSettingsScreen(),
  ),
  GoRoute(
    path: CommonRoutes.notificationCenter,
    builder: (context, state) => NotificationCenterScreen(),
  ),
  GoRoute(
    path: CommonRoutes.messagingHub,
    builder: (context, state) => MessagingHubScreen(),
  ),
  GoRoute(
    path: CommonRoutes.documentVault,
    builder: (context, state) => DocumentVaultScreen(),
  ),
  GoRoute(
    path: CommonRoutes.userManagement,
    builder: (context, state) => UserManagementScreen(),
  ),
  GoRoute(
    path: CommonRoutes.architecturalPlanning,
    builder: (context, state) => ArchitecturalPlanningDashboard(),
  ),
];
