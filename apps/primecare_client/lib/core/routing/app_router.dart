import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/flutter_core.dart';
import 'client_routes.dart';

final clientApplicationProvider = Provider<ClientApplication>((ref) {
  return ClientApplication();
});

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);
  final application = ref.watch(clientApplicationProvider);

  // Provide a safe fallback role for public/unauthenticated access
  final activeRole = authState.isAuthenticated
      ? (PlatformRole.values.cast<PlatformRole?>().firstWhere(
              (r) => r?.name == authState.role,
              orElse: () => PlatformRole.guest,
            ) ??
            PlatformRole.guest)
      : PlatformRole.guest;

  return GovernanceRouter.buildZeroTrustRouter(
    application: application,
    activeRole: activeRole,
    initialLocation: ClientRoutes
        .patientDashboard, // Default starting location, will redirect based on role
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
