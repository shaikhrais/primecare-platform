import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'features/auth/login_screen.dart';
import 'features/auth/forgot_password_screen.dart';
import 'features/psw/psw_shell_screen.dart';
import 'features/psw/psw_dashboard_screen.dart';
import 'features/psw/psw_clients_screen.dart';
import 'features/psw/psw_timesheet_screen.dart';
import 'features/psw/psw_profile_screen.dart';
import 'features/psw/psw_messages_screen.dart';
import 'features/psw/psw_training_screen.dart';
import 'features/psw/psw_live_visit_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/theme.dart';

import 'features/client/client_shell_screen.dart';
import 'features/client/client_dashboard_screen.dart';
import 'features/rn/rn_shell_screen.dart';
import 'features/rn/rn_dashboard_screen.dart';
import 'features/coordinator/coordinator_shell_screen.dart';
import 'features/coordinator/coordinator_dashboard_screen.dart';
import 'features/manager/manager_shell_screen.dart';
import 'features/manager/manager_dashboard_screen.dart';

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
      
      if (hasToken && (isLoggingIn || isGenericDashboard)) {
        final role = prefs.getString('user_role') ?? 'psw';
        switch (role) {
          case 'rn': return '/rn/dashboard';
          case 'coordinator': return '/coordinator/dashboard';
          case 'manager':
          case 'admin': return '/manager/dashboard';
          case 'client': return '/client/dashboard';
          default: return '/psw/dashboard';
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/psw/messages',
        builder: (context, state) => const PswMessagesScreen(),
      ),
      GoRoute(
        path: '/psw/training',
        builder: (context, state) => const PswTrainingScreen(),
      ),
      GoRoute(
        path: '/psw/live-visit/:id',
        builder: (context, state) => PswLiveVisitScreen(visitId: state.pathParameters['id']!),
      ),
      // PSW Role Route
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return PswShellScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(routes: [GoRoute(path: '/psw/dashboard', builder: (context, state) => const PswDashboardScreen())]),
          StatefulShellBranch(routes: [GoRoute(path: '/psw/clients', builder: (context, state) => const PswClientsScreen())]),
          StatefulShellBranch(routes: [GoRoute(path: '/psw/timesheet', builder: (context, state) => const PswTimesheetScreen())]),
          StatefulShellBranch(routes: [GoRoute(path: '/psw/profile', builder: (context, state) => const PswProfileScreen())]),
        ],
      ),
      // Client Role Route
      ShellRoute(
        builder: (context, state, child) => ClientShellScreen(child: child),
        routes: [
          GoRoute(path: '/client/dashboard', builder: (context, state) => const ClientDashboardScreen()),
        ],
      ),
      // RN Role Route
      ShellRoute(
        builder: (context, state, child) => RnShellScreen(child: child),
        routes: [
          GoRoute(path: '/rn/dashboard', builder: (context, state) => const RnDashboardScreen()),
        ],
      ),
      // Coordinator Role Route
      ShellRoute(
        builder: (context, state, child) => CoordinatorShellScreen(child: child),
        routes: [
          GoRoute(path: '/coordinator/dashboard', builder: (context, state) => const CoordinatorDashboardScreen()),
        ],
      ),
      // Manager Role Route
      ShellRoute(
        builder: (context, state, child) => ManagerShellScreen(child: child),
        routes: [
          GoRoute(path: '/manager/dashboard', builder: (context, state) => const ManagerDashboardScreen()),
        ],
      ),
    ],
  );
});

class PrimeCareApp extends ConsumerWidget {
  const PrimeCareApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(routerProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'PrimeCare Mobile',
      theme: PrimeCareTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}
