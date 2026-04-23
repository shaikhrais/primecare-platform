import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'routes/groups/marketing_routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/',
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
    errorBuilder: (context, state) => MasterLayout(
      shellType: AppShellType.admin,
      child: NotFoundScreen(message: state.error?.message),
    ),
    routes: [
      GoRoute(
        path: CommonRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => MasterLayout(
          shellType: AppShellType.admin, // marketing uses admin shell
          child: child,
        ),
        routes: [...marketingRoutes, ...sharedCommonRoutes],
      ),
    ],
  );
});
