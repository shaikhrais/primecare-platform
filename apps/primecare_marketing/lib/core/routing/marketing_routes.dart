import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import '../../features/marketing_operations/marketing_operations_view.dart';

class ScreenConfig {
  final String routePath;
  final String titleKey;
  final String subtitleKey;
  final String providerId;
  final Widget? customView;

  const ScreenConfig({
    required this.routePath,
    required this.titleKey,
    required this.subtitleKey,
    required this.providerId,
    this.customView,
  });
}

final List<ScreenConfig> marketingScreenRegistry = [
  const ScreenConfig(
    routePath: MarketingRoutes.localMarketingManagerDashboard,
    titleKey: 'Marketing Dashboard',
    subtitleKey: 'Local campaign oversight.',
    providerId: 'marketingDashboard',
    customView: MarketingDashboardView(),
  ),
  const ScreenConfig(
    routePath: MarketingRoutes.communityOutreachDashboard,
    titleKey: 'Outreach Dashboard',
    subtitleKey: 'Community engagement hub.',
    providerId: 'outreachDashboard',
    customView: OutreachDashboardView(),
  ),
];

final List<RouteBase> marketingRoutes = [
  ...marketingScreenRegistry.map((config) => GoRoute(
        path: config.routePath,
        builder: (context, state) => config.customView ?? GenericMarketingView(
          title: config.titleKey,
          subtitle: config.subtitleKey,
          providerId: config.providerId,
        ),
      )),
];

