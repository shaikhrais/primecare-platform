import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Layout & Dynamic Routing Modules
import 'package:primecare_mobile/core/layouts/master_layout.dart';
import 'package:primecare_mobile/features/master/auth/login_screen.dart';
import 'package:primecare_mobile/features/master/auth/forgot_password_screen.dart';
import 'package:primecare_mobile/core/routing/screen_registry.dart';
import 'package:primecare_mobile/core/routing/app_routes.dart';

// Global Pointer for Database Routes (Phase 24)
List<GoRoute> globalDatabaseRoutes = [];

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.login,
    errorBuilder: (context, state) {
      return Scaffold(
        body: MasterLayout(
          currentPath: state.uri.toString(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.warning_amber_rounded, size: 80, color: Colors.orangeAccent),
                SizedBox(height: 24),
                Text('404 - Content Not Found', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo)),
                SizedBox(height: 8),
                Text('The requested page does not exist in the role matrix.', style: TextStyle(fontSize: 16, color: Colors.grey)),
              ],
            ),
          ),
        ),
      );
    },
    redirect: (context, state) async {
      final prefs = await SharedPreferences.getInstance();
      final hasToken = prefs.containsKey('auth_token');
      final isLoggingIn = state.uri.toString() == AppRoutes.login;
      final isRoot = state.uri.toString() == '/';

      if (!hasToken && !isLoggingIn) return AppRoutes.login;

      if (hasToken && (isLoggingIn || isRoot)) {
        final role = prefs.getString('user_role') ?? 'psw';
        switch (role) {
          case 'rn': return AppRoutes.rnHome;
          case 'coordinator': return AppRoutes.coordinatorHome;
          case 'manager': return AppRoutes.managerHome;
          case 'admin': return AppRoutes.adminHome;
          case 'client': return AppRoutes.clientHome;
          case 'gm': return AppRoutes.gmHome;
          case 'mt': return AppRoutes.mtHome;
          case 'scrum': return AppRoutes.scrumMasterHome;
          case 'superuser': return AppRoutes.superuserHome;
          default: return AppRoutes.pswHome;
        }
      }
      return null;
    },
    routes: [
      GoRoute(path: AppRoutes.login, builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => ForgotPasswordScreen(),
      ),

      // Immersive Communication Suites (Bypass Master Layout)
      GoRoute(
        path: AppRoutes.universalChat,
        builder: (context, state) => ScreenRegistry.resolveScreen('universal_chat', state.pathParameters)
      ),
      GoRoute(
        path: AppRoutes.universalTelehealth,
        builder: (context, state) => ScreenRegistry.resolveScreen('universal_telehealth', {
          'role': state.pathParameters['role'] ?? 'universal',
          'sessionType': state.uri.queryParameters['sessionType'] ?? 'audio',
          'peerId': state.uri.queryParameters['peerId'] ?? ''
        })
      ),

      ShellRoute(
        builder: (context, state, child) {
          return MasterLayout(
            currentPath: state.uri.toString(),
            child: child,
          );
        },
        routes: [
          // The static layout arrays have been entirely decoupled!
          ...globalDatabaseRoutes,
        ],
      ),
    ],
  );
});
