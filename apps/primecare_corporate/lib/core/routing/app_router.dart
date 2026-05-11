import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/flutter_core.dart';

import 'corporate_routes.dart';

final corporateApplicationProvider = Provider<CorporateApplication>((ref) {
  return CorporateApplication();
});

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);
  final application = ref.watch(corporateApplicationProvider);

  // Override the platformApplicationProvider with our concrete instance
  // This allows MasterLayout (in primecare_ui) to find the correct application metadata
  // Note: In a real app, you might do this in the root ProviderScope, 
  // but doing it here ensures the router and the layout stay in sync.
  ref.onDispose(() {}); // Dummy for now

  // Provide a safe fallback role for public/unauthenticated access
  final activeRole = authState.isAuthenticated
      ? PlatformRole.fromName(authState.role)
      : PlatformRole.guest;

  return GovernanceRouter.buildZeroTrustRouter(
    application: application,
    activeRole: activeRole,
    initialLocation: activeRole == PlatformRole.guest
        ? CommonRoutes.login
        : AuthNotifier.getDashboardRouteForRole(authState.role ?? ''),
    refreshListenable: authListenable,
    redirect: (context, state) {
      final requestedRoute = state.uri.toString();

      final isAtLanding =
          requestedRoute == '/' || requestedRoute == CommonRoutes.login;

      if (authState.isAuthenticated && isAtLanding) {
        final role = authState.role ?? '';
        final destination = AuthNotifier.getDashboardRouteForRole(role);
        return destination;
      }

      if (!authState.isAuthenticated && !isAtLanding) {
        // Enforce login for unauthorized users
        return CommonRoutes.login;
      }

      return null;
    },
  );
});
