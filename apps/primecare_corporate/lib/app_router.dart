import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_core/primecare_core.dart';
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
    routes: [
      GoRoute(
        path: CommonRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) =>
            MasterLayout(shellType: AppShellType.admin, child: child),
        routes: corporateRoutes,
      ),
    ],
  );
});
