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

final List<ScreenConfig> businessDevelopmentScreenRegistry = [
  const ScreenConfig(
    routePath: BusinessDevelopmentRoutes.regionalManagerOntarioDashboard,
    titleKey: 'Regional Manager Ontario Dashboard',
    subtitleKey: 'Ontario market oversight.',
    providerId: 'regionalManagerOntarioDashboard',
  ),
  const ScreenConfig(
    routePath: BusinessDevelopmentRoutes.regionalManagerUsaDashboard,
    titleKey: 'Regional Manager USA Dashboard',
    subtitleKey: 'USA market oversight.',
    providerId: 'regionalManagerUsaDashboard',
  ),
  const ScreenConfig(
    routePath: BusinessDevelopmentRoutes.franchiseSalesManagerDashboard,
    titleKey: 'Franchise Sales Manager Dashboard',
    subtitleKey: 'Sales and pipeline tracking.',
    providerId: 'franchiseSalesManagerDashboard',
  ),
];

final List<RouteBase> businessDevelopmentRoutes = [
  ...businessDevelopmentScreenRegistry.map(
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
