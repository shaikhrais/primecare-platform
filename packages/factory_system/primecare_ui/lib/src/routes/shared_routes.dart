import 'package:go_router/go_router.dart';
import 'package:primecare_core/flutter_core.dart';
import '../screens/common/global_profile.dart';
import '../screens/common/global_settings.dart';
import '../screens/common/messaging_hub.dart';
import '../screens/common/notification_center.dart';
import '../screens/common/document_vault.dart';
import '../screens/common/user_management.dart';
import '../screens/dashboards/architectural_planning_dashboard.dart';

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
