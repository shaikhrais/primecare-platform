// Governance - Category: middleware | Purpose: Routing definition mapping client endpoints, paths, layouts, and access guards.
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart' hide PatientDashboardScreen, FamilyDashboardScreen, PatientBookAppointmentScreen, PatientMyAppointmentsScreen, PatientCareTeamScreen, PatientTreatmentHistoryScreen, PatientPaymentsScreen, PatientProfileScreen, FamilyLovedOneScheduleScreen, FamilyCareUpdatesScreen, FamilyBillingScreen, FamilyEmergencyContactsScreen, FamilyProfileScreen;
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

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);
  final application = ref.watch(clientApplicationProvider);

  // Provide a safe fallback role for public/unauthenticated access
  final activeRole = authState.isAuthenticated
      ? (PlatformRole.values.cast<PlatformRole?>().firstWhere(
              (r) => r?.name == authState.role,
              orElse: () => PlatformRole.guest,
            ) ??
            PlatformRole.guest)
      : PlatformRole.guest;

  final dashboardRoute = activeRole == PlatformRole.guest ? CommonRoutes.login : application.getDefinition(activeRole)?.dashboardRoute ?? CommonRoutes.login;

  return GovernanceRouter.buildZeroTrustRouter(
    application: application,
    activeRole: activeRole,
    initialLocation: dashboardRoute,
    refreshListenable: authListenable,
    redirect: (context, state) {
      final requestedRoute = state.uri.path;

      // Ensure SSO Portal URL is configured
      RouteGuard.ssoPortalUrl ??= const String.fromEnvironment('SSO_PORTAL_URL', defaultValue: 'https://primecare-auth.pages.dev');

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

      // If allowed and trying to hit root/login while authenticated, go to dashboard
      final isAtLanding = requestedRoute == '/' || requestedRoute == CommonRoutes.login;
      if (authState.isAuthenticated && isAtLanding) {
        return dashboardRoute;
      }

      return null;
    },
    publicRoutes: [
      GoRoute(path: '/offices/client/roles/client/dashboard', builder: (context, state) => const PatientDashboardScreen()),
      GoRoute(path: '/offices/client/roles/client/book-appointment', builder: (context, state) => const PatientBookAppointmentScreen()),
      GoRoute(path: '/offices/client/roles/client/my-appointments', builder: (context, state) => const PatientMyAppointmentsScreen()),
      GoRoute(path: '/offices/client/roles/client/care-team', builder: (context, state) => const PatientCareTeamScreen()),
      GoRoute(path: '/offices/client/roles/client/treatment-history', builder: (context, state) => const PatientTreatmentHistoryScreen()),
      GoRoute(path: '/offices/client/roles/client/payments', builder: (context, state) => const PatientPaymentsScreen()),
      GoRoute(path: '/offices/client/roles/client/profile', builder: (context, state) => const PatientProfileScreen()),
      GoRoute(path: '/offices/client/roles/family_member/dashboard', builder: (context, state) => const FamilyDashboardScreen()),
      GoRoute(path: '/offices/client/roles/family_member/loved-one-schedule', builder: (context, state) => const FamilyLovedOneScheduleScreen()),
      GoRoute(path: '/offices/client/roles/family_member/care-updates', builder: (context, state) => const FamilyCareUpdatesScreen()),
      GoRoute(path: '/offices/client/roles/family_member/billing', builder: (context, state) => const FamilyBillingScreen()),
      GoRoute(path: '/offices/client/roles/family_member/emergency-contacts', builder: (context, state) => const FamilyEmergencyContactsScreen()),
      GoRoute(path: '/offices/client/roles/family_member/profile', builder: (context, state) => const FamilyProfileScreen()),

      GoRoute(
        path: CommonRoutes.ssoRedirect,
        builder: (context, state) {
          final url = state.uri.queryParameters['url'] ?? 'https://primecare-auth.pages.dev';
          return SsoRedirectView(redirectUrl: url);
        },
      ),
      GoRoute(
        path: CommonRoutes.login,
        redirect: (context, state) {
          // If a user hits /login directly, force them to the SSO redirect
          RouteGuard.ssoPortalUrl ??= const String.fromEnvironment('SSO_PORTAL_URL', defaultValue: 'https://primecare-auth.pages.dev');
          final defaultRedirectUri = const String.fromEnvironment('APP_BASE_URL', defaultValue: 'https://primecare-client.pages.dev');
          final redirectUri = kIsWeb ? defaultRedirectUri : 'primecare://auth/callback';
          final target = '${RouteGuard.ssoPortalUrl}/login?redirect_uri=${Uri.encodeComponent(redirectUri)}';
          return '${CommonRoutes.ssoRedirect}?url=${Uri.encodeComponent(target)}';
        },
      ),
    ],
  );
});
