import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';

class ScreenConfig {
  final String routePath;
  final String titleKey;

  const ScreenConfig({
    required this.routePath,
    required this.titleKey,
  });
}

final List<ScreenConfig> corporateScreenRegistry = [
  const ScreenConfig(
    routePath: CorporateRoutes.ceoDashboard,
    titleKey: 'CEO Dashboard',
  ),
  const ScreenConfig(
    routePath: CorporateRoutes.cooDashboard,
    titleKey: 'COO Dashboard',
  ),
  const ScreenConfig(
    routePath: CorporateRoutes.cfoDashboard,
    titleKey: 'CFO Dashboard',
  ),
  const ScreenConfig(
    routePath: CorporateRoutes.ctoDashboard,
    titleKey: 'CTO Dashboard',
  ),
  const ScreenConfig(
    routePath: CorporateRoutes.ctoVerificationHub,
    titleKey: 'CTO Verification Hub',
  ),
];

final List<RouteBase> corporateRoutes = [
  ...corporateScreenRegistry.map(
    (config) => GoRoute(
      path: config.routePath,
      builder: (context, state) => Scaffold(
        body: Center(
          child: Text('Not Implemented: ${config.titleKey}'),
        ),
      ),
    ),
  ),
  // Fallback for role-based dynamic routes
  GoRoute(
    path: '/offices/:officeId/roles/:role/dashboard',
    builder: (context, state) {
      final role = state.pathParameters['role'] ?? 'guest';
      return Scaffold(
        body: Center(
          child: Text('Not Implemented: $role Dashboard'),
        ),
      );
    },
  ),
];
