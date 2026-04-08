import 'package:go_router/go_router.dart';
import '../app_routes.dart';
import '../../components/generic_feature_screen.dart';

import '../../offices/shared_screens/global_settings.dart';
import '../../offices/shared_screens/global_profile.dart';
import '../../offices/shared_screens/notification_center.dart';
import '../../offices/shared_screens/messaging_hub.dart';
import '../../offices/shared_screens/document_vault.dart';

final List<RouteBase> sharedRoutes = [
  GoRoute(
    path: AppRoutes.globalSettings,
    builder: (context, state) => const GlobalSettingsScreen(),
  ),
  GoRoute(
    path: AppRoutes.globalProfile,
    builder: (context, state) => const GlobalProfileScreen(),
  ),
  GoRoute(
    path: AppRoutes.notificationCenter,
    builder: (context, state) => const NotificationCenterScreen(),
  ),
  GoRoute(
    path: AppRoutes.messagingHub,
    builder: (context, state) => const MessagingHubScreen(),
  ),
  GoRoute(
    path: AppRoutes.documentVault,
    builder: (context, state) => const DocumentVaultScreen(),
  ),
];
