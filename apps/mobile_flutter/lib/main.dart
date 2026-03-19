import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'features/auth/login_screen.dart';
import 'features/psw/psw_shell_screen.dart';
import 'features/psw/psw_dashboard_screen.dart';
import 'features/psw/psw_clients_screen.dart';
import 'features/psw/psw_timesheet_screen.dart';
import 'features/psw/psw_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const ProviderScope(child: PrimeCareApp()));
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) async {
      final prefs = await SharedPreferences.getInstance();
      final hasToken = prefs.containsKey('auth_token');
      final isLoggingIn = state.uri.toString() == '/login';
      final isGenericDashboard = state.uri.toString() == '/dashboard';

      if (!hasToken && !isLoggingIn) return '/login';
      if (hasToken && isLoggingIn) return '/psw/dashboard';
      if (hasToken && isGenericDashboard) return '/psw/dashboard';
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return PswShellScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/psw/dashboard',
                builder: (context, state) => const PswDashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/psw/clients',
                builder: (context, state) => const PswClientsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/psw/timesheet',
                builder: (context, state) => const PswTimesheetScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/psw/profile',
                builder: (context, state) => const PswProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});

class PrimeCareApp extends ConsumerWidget {
  const PrimeCareApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'PrimeCare Mobile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0EA5E9)),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
