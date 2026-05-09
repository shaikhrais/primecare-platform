import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'client_routes.dart';

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
      shellType: AppShellType.patient,
      child: const ScreenNotImplementedView(),
    ),
    routes: [
      GoRoute(
        path: CommonRoutes.login,
        builder: (context, state) => const SignInView(),
      ),
      ShellRoute(
        builder: (context, state, child) => MasterLayout(
          shellType: AppShellType.patient, // client uses patient shell
          child: child,
        ),
        routes: [...clientRoutes, ...sharedCommonRoutes],
      ),
    ],
  );
});
