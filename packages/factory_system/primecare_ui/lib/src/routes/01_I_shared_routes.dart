// Layer: 01_INFRASTRUCTURE
import 'package:go_router/go_router.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/src/screens/common/05_U_user_management.dart';

/// Central registry for routes that are available across all PrimeCare portals.
/// These routes are typically hosted within a ShellRoute.
final List<RouteBase> sharedCommonRoutes = [
  GoRoute(
    path: CommonRoutes.globalProfile,
    builder: (context, state) => const GlobalProfileScreen(),
  ),
  GoRoute(
    path: CommonRoutes.globalSettings,
    builder: (context, state) => const GlobalSettingsScreen(),
  ),
  GoRoute(
    path: CommonRoutes.notificationCenter,
    builder: (context, state) => const NotificationCenterScreen(),
  ),
  GoRoute(
    path: CommonRoutes.messagingHub,
    builder: (context, state) => const MessagingHubScreen(),
  ),
  GoRoute(
    path: CommonRoutes.documentVault,
    builder: (context, state) => const DocumentVaultScreen(),
  ),
  GoRoute(
    path: CommonRoutes.userManagement,
    builder: (context, state) => const UserManagementScreen(),
  ),
  GoRoute(
    path: CommonRoutes.architecturalPlanning,
    builder: (context, state) => const ArchitecturalPlanningDashboard(),
  ),
];
