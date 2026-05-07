import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';

class MarketingRoutes {
  static const String localMarketingManagerDashboard = '/local-marketing';
  static const String communityOutreachDashboard = '/outreach';
}

class ScreenConfig {
  final String routePath;
  final String titleKey;

  const ScreenConfig({
    required this.routePath,
    required this.titleKey,
  });
}

final List<ScreenConfig> marketingScreenRegistry = [
  const ScreenConfig(
    routePath: MarketingRoutes.localMarketingManagerDashboard,
    titleKey: 'Marketing Dashboard',
  ),
  const ScreenConfig(
    routePath: MarketingRoutes.communityOutreachDashboard,
    titleKey: 'Outreach Dashboard',
  ),
];

final List<RouteBase> marketingRoutes = [
  ...marketingScreenRegistry.map(
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
