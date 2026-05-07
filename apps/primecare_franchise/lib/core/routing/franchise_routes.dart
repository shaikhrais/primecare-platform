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

final List<ScreenConfig> franchiseScreenRegistry = [
  const ScreenConfig(
    routePath: FranchiseRoutes.franchiseOwnerDashboard,
    titleKey: 'Franchise Owner Dashboard',
    subtitleKey: 'Real-time business overview.',
    providerId: 'franchiseOwnerDashboard',
  ),
  const ScreenConfig(
    routePath: FranchiseRoutes.operationsManagerDashboard,
    titleKey: 'Operations Manager Dashboard',
    subtitleKey: 'Daily operational management.',
    providerId: 'operationsManagerDashboard',
  ),
  const ScreenConfig(
    routePath: FranchiseRoutes.billingAdminDashboard,
    titleKey: 'Billing Admin Dashboard',
    subtitleKey: 'Financial reconciliation and invoicing.',
    providerId: 'billingAdminDashboard',
  ),
  const ScreenConfig(
    routePath: FranchiseRoutes.hrHiringDashboard,
    titleKey: 'Hr Hiring Dashboard',
    subtitleKey: 'Staff onboarding and credentialing.',
    providerId: 'hrHiringDashboard',
  ),
  const ScreenConfig(
    routePath: FranchiseRoutes.schedulerDashboard,
    titleKey: 'Scheduler Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'schedulerDashboard',
  ),
];

final List<RouteBase> franchiseRoutes = [
  ...franchiseScreenRegistry.map(
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
