// Governance - Category: middleware | Purpose: Routing definition mapping client endpoints, paths, layouts, and access guards.
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart'
    hide
        PatientDashboardScreen,
        FamilyDashboardScreen,
        PatientBookAppointmentScreen,
        PatientMyAppointmentsScreen,
        PatientCareTeamScreen,
        PatientTreatmentHistoryScreen,
        PatientPaymentsScreen,
        PatientProfileScreen,
        FamilyLovedOneScheduleScreen,
        FamilyCareUpdatesScreen,
        FamilyBillingScreen,
        FamilyEmergencyContactsScreen,
        FamilyProfileScreen;
import 'package:flutter_core/flutter_core.dart';
import 'client_routes.dart';
import '../../features/patient/screens/patient_dashboard_screen.dart';
import '../../features/patient/screens/patient_book_appointment_screen.dart';
import '../../features/patient/screens/patient_my_appointments_screen.dart';
import '../../features/patient/screens/patient_care_team_screen.dart';
import '../../features/patient/screens/patient_treatment_history_screen.dart';
import '../../features/patient/screens/patient_payments_screen.dart';
import '../../features/patient/screens/patient_profile_screen.dart';
import '../../features/family/screens/family_dashboard_screen.dart';
import '../../features/family/screens/family_loved_one_schedule_screen.dart';
import '../../features/family/screens/family_care_updates_screen.dart';
import '../../features/family/screens/family_billing_screen.dart';
import '../../features/family/screens/family_emergency_contacts_screen.dart';
import '../../features/family/screens/family_profile_screen.dart';

import 'package:flutter/foundation.dart';

final clientApplicationProvider = Provider<ClientApplication>((ref) {
  return ClientApplication();
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
  final application = ref.read(clientApplicationProvider);

  final authState = ref.watch(authProvider);
  final dashboardRoute = !authState.isAuthenticated
      ? CommonRoutes.login
      : application.getDefinition(activeRole)?.dashboardRoute ??
            AuthNotifier.getDashboardRouteForRole(authState.role ?? '');

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
          requestedRoute == CommonRoutes.language ||
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
        path: CommonRoutes.language,
        builder: (context, state) => const AppShellBoundary(
          child: LanguageSelectionView(),
        ),
      ),
      GoRoute(
        path: CommonRoutes.ssoRedirect,
        builder: (context, state) {
          final url =
              state.uri.queryParameters['url'] ??
              'https://primecare-auth.pages.dev';
          return AppShellBoundary(child: SsoRedirectView(redirectUrl: url));
        },
      ),
      GoRoute(
        path: CommonRoutes.login,
        redirect: (context, state) {
          // If a user hits /login directly, force them to the SSO redirect
          RouteGuard.ssoPortalUrl ??= const String.fromEnvironment(
            'SSO_PORTAL_URL',
            defaultValue: 'https://primecare-auth.pages.dev',
          );
          final defaultRedirectUri = const String.fromEnvironment(
            'APP_BASE_URL',
            defaultValue: 'https://primecare-client.pages.dev',
          );
          final redirectUri = kIsWeb
              ? defaultRedirectUri
              : 'primecare://auth/callback';
          final target =
              '${RouteGuard.ssoPortalUrl}/login?redirect_uri=${Uri.encodeComponent(redirectUri)}';
          return '${CommonRoutes.ssoRedirect}?url=${Uri.encodeComponent(target)}';
        },
      ),
    ],
  );
});
