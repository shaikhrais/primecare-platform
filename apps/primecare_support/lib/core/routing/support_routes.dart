import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';

class SupportRoutes {
  static const String helpDeskDashboard = '/helpdesk';
  static const String escalationDashboard = '/escalation';
}

class ScreenConfig {
  final String routePath;
  final String titleKey;

  const ScreenConfig({
    required this.routePath,
    required this.titleKey,
  });
}

final List<ScreenConfig> supportScreenRegistry = [
  const ScreenConfig(
    routePath: SupportRoutes.helpDeskDashboard,
    titleKey: 'Help Desk Dashboard',
  ),
  const ScreenConfig(
    routePath: SupportRoutes.escalationDashboard,
    titleKey: 'Escalation Dashboard',
  ),
];

final List<RouteBase> supportRoutes = [
  ...supportScreenRegistry.map(
    (config) => GoRoute(
      path: config.routePath,
      builder: (context, state) => Scaffold(
        body: Center(
          child: Text('Not Implemented: ${config.titleKey}'),
        ),
      ),
    ),
  ),
];
