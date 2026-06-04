import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';

import 'clinic_routes.dart';

import '../../features/shared/screens/clinic_incident_report_screen.dart';
import '../../features/shared/screens/clinic_history_logs_screen.dart';
import '../../features/rn/screens/rn_messaging_screen.dart';

final clinicApplicationProvider = Provider<ClinicApplication>((ref) {
  return ClinicApplication();
});

final activeRoleProvider = Provider<PlatformRole>((ref) {
  final authState = ref.watch(authProvider);
  if (!authState.isInitialized || !authState.isAuthenticated) {
    return PlatformRole.guest;
  }
  return PlatformRole.fromName(authState.role);
});

final appRouterProvider = Provider<GoRouter>((ref) {
  final activeRole = ref.watch(activeRoleProvider);
  final application = ref.read(clinicApplicationProvider);

  final dashboardRoute = activeRole == PlatformRole.guest
      ? CommonRoutes.login
      : application.getDefinition(activeRole)?.dashboardRoute ??
            CommonRoutes.login;

  return GovernanceRouter.buildZeroTrustRouter(
    application: application,
    activeRole: activeRole,
    initialLocation: dashboardRoute,
    refreshListenable: authListenable,
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      
      // If the authentication system has not completed its initial session restoration check yet,
      // DO NOT redirect the user! Prevent early redirects and let the startup check finalize.
      if (!authState.isInitialized) {
        return null;
      }

      final requestedRoute = state.uri.path;

      // Ensure SSO Portal URL is configured (this normally goes in app initialization)
      RouteGuard.ssoPortalUrl ??= const String.fromEnvironment(
        'SSO_PORTAL_URL',
        defaultValue: 'https://primecare-auth.pages.dev',
      );

      // If trying to hit root/login/callback while authenticated, redirect to dashboard immediately
      final isAtLanding =
          requestedRoute == '/' ||
          requestedRoute == CommonRoutes.login ||
          requestedRoute == CommonRoutes.authCallback;
      if (authState.isAuthenticated && isAtLanding) {
        return dashboardRoute;
      }

      final result = RouteGuard.verify(
        requestedRoute: requestedRoute,
        isLoggedIn: authState.isAuthenticated,
        userRole: authState.role,
      );

      if (!result.isAllowed) {
        if (result.externalRedirectUrl != null) {
          return '${CommonRoutes.ssoRedirect}?url=${Uri.encodeComponent(result.externalRedirectUrl!)}';
        }
        return result.redirectRoute;
      }

      return null;
    },
    publicRoutes: [
      GoRoute(
        path: '/clinic/dashboard',
        builder: (context, state) => const PswDashboardScreen(),
      ),
      GoRoute(
        path: '/clinic/care-plan',
        builder: (context, state) => const PswCarePlanScreen(),
      ),
      GoRoute(
        path: '/clinic/daily-notes',
        builder: (context, state) => const PswVisitNotesScreen(),
      ),
      GoRoute(
        path: '/clinic/client-profile',
        builder: (context, state) => const PswClientProfileScreen(),
      ),
      GoRoute(
        path: '/clinic/my-shifts',
        builder: (context, state) => const PswMyShiftsScreen(),
      ),
      GoRoute(
        path: '/clinic/messaging',
        builder: (context, state) => const PswMessagesScreen(),
      ),

      GoRoute(
        path: '/clinic/rn-dashboard',
        builder: (context, state) => const RnDashboardScreen(),
      ),
      GoRoute(
        path: '/clinic/rn-medications',
        builder: (context, state) => const RnMedicationsScreen(),
      ),
      GoRoute(
        path: '/clinic/rn-vitals',
        builder: (context, state) => const RnVitalsScreen(),
      ),
      GoRoute(
        path: '/clinic/rn-charting',
        builder: (context, state) => const RnPatientChartingScreen(),
      ),
      GoRoute(
        path: '/clinic/rn-messaging',
        builder: (context, state) => const RnMessagingScreen(),
      ),

      GoRoute(
        path: '/clinic/incident-report',
        builder: (context, state) => const ClinicIncidentReportScreen(),
      ),
      GoRoute(
        path: '/clinic/history-logs',
        builder: (context, state) => const ClinicHistoryLogsScreen(),
      ),

      GoRoute(
        path: CommonRoutes.ssoRedirect,
        builder: (context, state) {
          final url =
              state.uri.queryParameters['url'] ??
              'https://primecare-auth.pages.dev';
          return SsoRedirectView(redirectUrl: url);
        },
      ),
      GoRoute(
        path: CommonRoutes.login,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: CommonRoutes.globalSettings,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Settings / Safe Landing Area')),
        ),
      ),
    ],
  );
});
