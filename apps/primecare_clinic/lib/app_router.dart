
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'routes/groups/clinic_routes.dart';

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
        // Automatically redirect to their specific dashboard based on role
        return AuthNotifier.getDashboardRouteForRole(authState.role ?? '');
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
