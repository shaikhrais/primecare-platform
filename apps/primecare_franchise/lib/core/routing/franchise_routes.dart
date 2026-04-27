import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import '../../features/franchise_operations/franchise_operations_view.dart';

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

final List<ScreenConfig> franchiseScreenRegistry = [
  const ScreenConfig(
    routePath: FranchiseRoutes.franchiseOwnerDashboard,
    titleKey: 'Franchise Owner Dashboard',
    subtitleKey: 'Real-time business overview.',
    providerId: 'franchiseOwnerDashboard',
    customView: FranchiseOwnerDashboardView(),
  ),
  const ScreenConfig(
    routePath: FranchiseRoutes.operationsManagerDashboard,
    titleKey: 'Operations Manager Dashboard',
    subtitleKey: 'Daily operational management.',
    providerId: 'operationsManagerDashboard',
    customView: OperationsManagerDashboardView(),
  ),
  const ScreenConfig(
    routePath: FranchiseRoutes.billingAdminDashboard,
    titleKey: 'Billing Admin Dashboard',
    subtitleKey: 'Financial reconciliation and invoicing.',
    providerId: 'billingAdminDashboard',
    customView: BillingAdminDashboardView(),
  ),
  const ScreenConfig(
    routePath: FranchiseRoutes.hrHiringDashboard,
    titleKey: 'Hr Hiring Dashboard',
    subtitleKey: 'Staff onboarding and credentialing.',
    providerId: 'hrHiringDashboard',
    customView: HrHiringDashboardView(),
  ),
  // ... other configs use GenericFranchiseView via the mapper below
  const ScreenConfig(
    routePath: FranchiseRoutes.schedulerDashboard,
    titleKey: 'Scheduler Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'schedulerDashboard',
  ),
];

final List<RouteBase> franchiseRoutes = [
  ...franchiseScreenRegistry.map((config) => GoRoute(
        path: config.routePath,
        builder: (context, state) => config.customView ?? GenericFranchiseView(
          title: config.titleKey,
          subtitle: config.subtitleKey,
          providerId: config.providerId,
        ),
      )),
];

