import 'package:go_router/go_router.dart';

import 'routes/groups/corporate_routes.dart';
import 'package:primecare_ui/primecare_ui.dart';

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

      // 1. Enforce Guard Redirections (Security boundaries)
      if (!guard.isAllowed && guard.redirectRoute != null) {
        return guard.redirectRoute;
      }

      // 2. Dashboard Resolution (Logged in users on home/login)
      final isAtLanding = requestedRoute == '/' || requestedRoute == CommonRoutes.login;
      if (authState.isAuthenticated && isAtLanding) {
        final role = authState.role ?? '';
        final destination = AuthNotifier.getDashboardRouteForRole(role);
        
        // Safety: If for some reason the role isn't corporate, don't trap them in a loop
        // if they are in the corporate app.
        return destination;
      }

      // 3. Prevent unauthenticated access to non-public routes (already handled by Guard but as a fallback)
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
        builder: (context, state, child) =>
            MasterLayout(shellType: AppShellType.admin, child: child),
        routes: [
          ...corporateRoutes,
          ...sharedCommonRoutes,
          GoRoute(
            path: '/:segment1/:segment2',
            builder: (context, state) => NotFoundScreen(
              message:
                  'God Mode Preview:\n\n${state.uri.toString()} belongs to a different frontend application in the monolithic PrimeCare system.',
            ),
          ),
          GoRoute(
            path: '/:segment1/:segment2/:segment3',
            builder: (context, state) => NotFoundScreen(
              message:
                  'God Mode Preview:\n\n${state.uri.toString()} belongs to a different frontend application in the monolithic PrimeCare system.',
            ),
          ),
        ],
      ),
    ],
  );
});
