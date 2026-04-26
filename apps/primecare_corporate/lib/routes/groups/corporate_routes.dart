import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';

final List<RouteBase> corporateRoutes = [
  // The universal route handler for all registered screens
  GoRoute(
    path: '/offices/:officeId/roles/:role/dashboard',
    builder: (context, state) {
      final role = state.pathParameters['role'] ?? 'guest';
      return ScreenRegistry.buildScreen(context, role);
    },
  ),

  // Generic handler for sub-screens
  GoRoute(
    path: '/offices/:officeId/roles/:role/:subPath',
    builder: (context, state) {
      final fullPath = state.uri.path;
      return ScreenRegistry.buildScreen(context, fullPath);
    },
  ),

  // Specific sub-routes that might not follow the pattern but are registered
  GoRoute(
    path: CorporateRoutes.ceoDashboard,
    builder: (context, state) =>
        ScreenRegistry.buildScreen(context, CorporateRoutes.ceoDashboard),
  ),
  GoRoute(
    path: CorporateRoutes.cooDashboard,
    builder: (context, state) =>
        ScreenRegistry.buildScreen(context, CorporateRoutes.cooDashboard),
  ),
  GoRoute(
    path: CorporateRoutes.cfoDashboard,
    builder: (context, state) =>
        ScreenRegistry.buildScreen(context, CorporateRoutes.cfoDashboard),
  ),
  GoRoute(
    path: CorporateRoutes.ctoDashboard,
    builder: (context, state) =>
        ScreenRegistry.buildScreen(context, CorporateRoutes.ctoDashboard),
  ),

  // Legacy support for common dashboards
  GoRoute(
    path: CommonRoutes.receptionistDashboard,
    builder: (context, state) =>
        ScreenRegistry.buildScreen(context, 'receptionist'),
  ),
  GoRoute(
    path: CommonRoutes.clinicalDashboard,
    builder: (context, state) =>
        ScreenRegistry.buildScreen(context, 'clinical'),
  ),

  GoRoute(
    path: CommonRoutes.institutionalScheduler,
    builder: (context, state) => const InstitutionalSchedulerScreen(),
  ),
  GoRoute(
    path: CorporateRoutes.ctoVerificationHub,
    builder: (context, state) => VerificationHub(),
  ),
];
