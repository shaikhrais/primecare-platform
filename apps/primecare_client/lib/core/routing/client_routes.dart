import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';

class ScreenConfig {
  final String routePath;
  final String titleKey;
  final String subtitleKey;
  final String providerId;

  const ScreenConfig({
    required this.routePath,
    required this.titleKey,
    required this.subtitleKey,
    required this.providerId,
  });
}

final List<ScreenConfig> clientScreenRegistry = [
  const ScreenConfig(
    routePath: ClientRoutes.patientDashboard,
    titleKey: 'Patient Dashboard',
    subtitleKey: 'Manage your care plan.',
    providerId: 'patientDashboard',
  ),
  const ScreenConfig(
    routePath: ClientRoutes.familyMemberDashboard,
    titleKey: 'Family Dashboard',
    subtitleKey: 'Loved one care updates.',
    providerId: 'familyDashboard',
  ),
];

final List<RouteBase> clientRoutes = [
  ...clientScreenRegistry.map(
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
