import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'routes/groups/clinic_routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: CommonRoutes.login,
    refreshListenable: authListenable,
    redirect: (context, state) {
      final requestedRoute = state.uri.toString();
      final guard = RouteGuard.verify(
        requestedRoute: requestedRoute,
        isLoggedIn: authState.isAuthenticated,
        userRole: authState.role,
      );

      if (!guard.isAllowed && guard.redirectRoute != null) {
        return guard.redirectRoute;
      }

      final isAtLanding =
          requestedRoute == '/' || requestedRoute == CommonRoutes.login;
      if (authState.isAuthenticated && isAtLanding) {
        return AuthNotifier.getDashboardRouteForRole(authState.role ?? '');
      }

      if (!authState.isAuthenticated && !isAtLanding) {
        return CommonRoutes.login;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: CommonRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => MasterLayout(
          shellType: AppShellType.provider, // clinic uses provider shell
          child: child,
        ),
        routes: clinicRoutes,
      ),
    ],
  );
});
