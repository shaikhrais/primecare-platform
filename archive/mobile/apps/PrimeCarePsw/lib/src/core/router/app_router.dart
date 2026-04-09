
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_psw/src/core/providers/auth_provider.dart';
import 'package:primecare_psw/src/features/auth/login_screen.dart';
import 'package:primecare_psw/src/features/home/home_shell.dart';
import 'package:primecare_psw/src/features/schedule/schedule_screen.dart';
import 'package:primecare_psw/src/features/visits/visit_checkin_screen.dart';
import 'package:primecare_psw/src/features/incidents/sos_screen.dart';
import 'package:primecare_psw/src/features/profile/profile_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isLoggedIn = authState.isAuthenticated;
      final isLoginRoute = state.matchedLocation == '/login';

      if (!isLoggedIn && !isLoginRoute) return '/login';
      if (isLoggedIn && isLoginRoute) return '/';
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => HomeShell(child: child),
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const ScheduleScreen(),
          ),
          GoRoute(
            path: '/visit/:visitId',
            builder: (context, state) => VisitCheckinScreen(
              visitId: state.pathParameters['visitId']!,
            ),
          ),
          GoRoute(
            path: '/sos',
            builder: (context, state) => const SOSScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
    ],
  );
});
