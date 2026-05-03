import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import '../../features/support_operations/support_operations_view.dart';

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

final List<ScreenConfig> supportScreenRegistry = [
  const ScreenConfig(
    routePath: SupportRoutes.customerSupportDashboard,
    titleKey: 'Customer Support Dashboard',
    subtitleKey: 'Ticketing and support hub.',
    providerId: 'supportDashboard',
    customView: const SupportOperationsView(),
  ),
  const ScreenConfig(
    routePath: SupportRoutes.qualityAssuranceDashboard,
    titleKey: 'Quality Assurance Dashboard',
    subtitleKey: 'QA and Compliance overview.',
    providerId: 'qaDashboard',
    customView: const SupportOperationsView(),
  ),
  const ScreenConfig(
    routePath: SupportRoutes.customerSupportTickets,
    titleKey: 'Customer Support Tickets',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'customerSupportTickets',
  ),
];

final List<RouteBase> supportRoutes = [
  ...supportScreenRegistry.map((config) => GoRoute(
        path: config.routePath,
        builder: (context, state) => config.customView ?? const SupportOperationsView(),
      )),
];

