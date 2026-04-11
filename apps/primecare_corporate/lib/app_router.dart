import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_core/flutter_core.dart';
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
        return AuthNotifier.getDashboardRouteForRole(authState.role ?? '');
      }

      return null;
    },
    routes: [
      GoRoute(
        path: CommonRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      ...corporateRoutes,
    ],
  );
});
