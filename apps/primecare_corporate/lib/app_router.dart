import 'package:go_router/go_router.dart';

import 'routes/groups/corporate_routes.dart';
import 'package:primecare_ui/primecare_ui.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: CommonRoutes.login,
    refreshListenable: authListenable,
    redirect: (context, state) {
      final isLoggingIn = state.uri.toString() == CommonRoutes.login;

      if (!authState.isAuthenticated) {
        return isLoggingIn ? null : CommonRoutes.login;
      }

      if (isLoggingIn || state.uri.toString() == '/') {
        final role = authState.role ?? '';
        final destination = AuthNotifier.getDashboardRouteForRole(role);

        // Safety: Allow authorized institutional and enterprise routes.
        // Block raw /clinic path which is reserved for the clinical app build.
        if (destination == '/clinic/dashboard') {
          return CorporateRoutes.ceoDashboard;
        }
        return destination;
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
