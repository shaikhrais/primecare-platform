import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../services/auth_service.dart';
import 'app_routes.dart';
import '../screens/login_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/forgot_password_screen.dart';
import '../components/layouts/master_layout.dart';

import 'groups/corporate_routes.dart';
import 'groups/business_development_routes.dart';
import 'groups/franchise_routes.dart';
import 'groups/marketing_routes.dart';
import 'groups/clinic_routes.dart';
import 'groups/support_routes.dart';
import 'groups/client_routes.dart';
import 'groups/shared_routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: authListenable,
    redirect: (BuildContext context, GoRouterState state) {
      final isLoggingIn =
          state.matchedLocation == AppRoutes.login ||
          state.matchedLocation == AppRoutes.signup ||
          state.matchedLocation == AppRoutes.forgotPassword;
      final isSplash = state.matchedLocation == AppRoutes.splash;

      final isLoggedIn = authState.isAuthenticated;
      final role = authState.role ?? '';

      if (isSplash) return null;

      if (!isLoggedIn && !isLoggingIn) {
        return AppRoutes.login;
      }

      if (isLoggedIn && isLoggingIn) {
        return AuthNotifier.getDashboardRouteForRole(role);
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      ShellRoute(
        builder: (context, state, child) {
          final role = authState.role ?? '';
          AppShellType type = AppShellType.none;
          if (role == 'ceo' ||
              role.endsWith('manager') ||
              role == 'scrum_master' ||
              role.endsWith('director')) {
            type = AppShellType.admin;
          } else if (role == 'client' || role == 'family_member') {
            type = AppShellType.client;
          } else if (role.isNotEmpty) {
            type = AppShellType.provider;
          }
          return MasterLayout(shellType: type, child: child);
        },
        routes: [
          ...sharedRoutes,
          ...corporateRoutes,
          ...businessDevelopmentRoutes,
          ...marketingRoutes,
          ...franchiseRoutes,
          ...clinicRoutes,
          ...supportRoutes,
          ...clientRoutes,
        ],
      ),
    ],
  );
});
