import 'package:flutter_core/routes/app_routes.dart';
import 'package:flutter_core/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_ui/primecare_ui.dart';
import 'routes/groups/clinic_routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: AppRoutes.login,
    refreshListenable: authListenable,
    redirect: (context, state) {
      final isLoggingIn = state.uri.toString() == AppRoutes.login;
      
      if (!authState.isAuthenticated) {
        return isLoggingIn ? null : AppRoutes.login;
      }

      if (isLoggingIn || state.uri.toString() == '/') {
        // Automatically redirect to their specific dashboard based on role
        return AuthNotifier.getDashboardRouteForRole(authState.role ?? '');
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      ...clinicRoutes,
    ],
  );
});
