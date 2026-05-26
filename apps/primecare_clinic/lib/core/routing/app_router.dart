// Governance - Category: middleware | Purpose: Routing definition mapping client endpoints, paths, layouts, and access guards.
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart' hide PhysicianDashboardScreen, RnDashboardScreen, RnMedicationsScreen, RnVitalsScreen, RnChartingScreen, RnMessagingScreen, PswDashboardScreen, PswCarePlanScreen, PswDailyNotesScreen, PswClientProfileScreen, PswMyShiftsScreen, PswMessagingScreen, IntakeCoordinatorDashboardScreen, QualityAssuranceDashboardScreen, TrainingCoordinatorDashboardScreen, ReceptionistDashboardScreen, RmtDashboardScreen, ChiropractorDashboardScreen, PhysiotherapistDashboardScreen, SocialWorkerDashboardScreen, ClinicalDirectorDashboardScreen, PswMessagesScreen, PswVisitNotesScreen, QaDashboardScreen, PswShiftTrackerScreen, PswDocumentsScreen;

import 'clinic_routes.dart';

import '../../features/psw/screens/psw_dashboard_screen.dart';
import '../../features/psw/screens/psw_care_plan_screen.dart';
import '../../features/psw/screens/psw_daily_notes_screen.dart';
import '../../features/psw/screens/psw_client_profile_screen.dart';
import '../../features/psw/screens/psw_my_shifts_screen.dart';
import '../../features/psw/screens/psw_messaging_screen.dart';

import '../../features/rn/screens/rn_dashboard_screen.dart';
import '../../features/rn/screens/rn_medications_screen.dart';
import '../../features/rn/screens/rn_vitals_screen.dart';
import '../../features/rn/screens/rn_charting_screen.dart';
import '../../features/rn/screens/rn_messaging_screen.dart';

import '../../features/shared/screens/clinic_incident_report_screen.dart';
import '../../features/shared/screens/clinic_history_logs_screen.dart';
import '../../features/psw/screens/psw_care_dashboard_screen.dart';
import '../../features/psw/screens/psw_shift_tracker_screen.dart';
import '../../features/psw/screens/psw_my_clients_screen.dart';
import '../../features/psw/screens/psw_task_list_screen.dart';
import '../../features/psw/screens/psw_messages_screen.dart';
import '../../features/psw/screens/psw_visit_notes_screen.dart';
import '../../features/psw/screens/psw_profile_screen.dart';
import '../../features/psw/screens/psw_reports_screen.dart';
import '../../features/psw/screens/psw_documents_screen.dart';
import '../../features/psw/screens/psw_check_in_screen.dart';
import '../../features/psw/screens/psw_system_logs_screen.dart';
import '../../features/psw/screens/psw_notifications_screen.dart';
import '../../features/psw/screens/psw_help_support_screen.dart';
import '../../features/shared/screens/clinical_director_dashboard_screen.dart';
import '../../features/physician/screens/physician_dashboard_screen.dart';
import '../../features/shared/screens/intake_coordinator_dashboard_screen.dart';
import '../../features/shared/screens/qa_dashboard_screen.dart';
import '../../features/shared/screens/training_coordinator_dashboard_screen.dart';
import '../../features/shared/screens/receptionist_dashboard_screen.dart';
import '../../features/shared/screens/rmt_dashboard_screen.dart';
import '../../features/shared/screens/chiropractor_dashboard_screen.dart';
import '../../features/shared/screens/physiotherapist_dashboard_screen.dart';
import '../../features/shared/screens/social_worker_dashboard_screen.dart';






final clinicApplicationProvider = Provider<ClinicApplication>((ref) {
  return ClinicApplication();
});

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);
  final application = ref.watch(clinicApplicationProvider);

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

      // Ensure SSO Portal URL is configured (this normally goes in app initialization)
      RouteGuard.ssoPortalUrl ??= const String.fromEnvironment('SSO_PORTAL_URL', defaultValue: 'http://localhost:3000');

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
      GoRoute(path: '/clinic/dashboard', builder: (context, state) => const PswDashboardScreen()),
      GoRoute(path: '/clinic/care-plan', builder: (context, state) => const PswCarePlanScreen()),
      GoRoute(path: '/clinic/daily-notes', builder: (context, state) => const PswDailyNotesScreen()),
      GoRoute(path: '/clinic/client-profile', builder: (context, state) => const PswClientProfileScreen()),
      GoRoute(path: '/clinic/my-shifts', builder: (context, state) => const PswMyShiftsScreen()),
      GoRoute(path: '/clinic/messaging', builder: (context, state) => const PswMessagingScreen()),

      GoRoute(path: '/clinic/rn-dashboard', builder: (context, state) => const RnDashboardScreen()),
      GoRoute(path: '/clinic/rn-medications', builder: (context, state) => const RnMedicationsScreen()),
      GoRoute(path: '/clinic/rn-vitals', builder: (context, state) => const RnVitalsScreen()),
      GoRoute(path: '/clinic/rn-charting', builder: (context, state) => const RnChartingScreen()),
      GoRoute(path: '/clinic/rn-messaging', builder: (context, state) => const RnMessagingScreen()),

      GoRoute(path: '/clinic/incident-report', builder: (context, state) => const ClinicIncidentReportScreen()),
      GoRoute(path: '/clinic/history-logs', builder: (context, state) => const ClinicHistoryLogsScreen()),
      GoRoute(path: '/offices/clinical/roles/psw/dashboard', builder: (context, state) => const PswCareDashboardScreen()),
      GoRoute(path: '/offices/clinical/roles/psw/schedule', builder: (context, state) => const PswShiftTrackerScreen()),
      GoRoute(path: '/offices/clinical/roles/psw/patient-profile', builder: (context, state) => const PswMyClientsScreen()),
      GoRoute(path: '/offices/clinical/roles/psw/visit-checklist', builder: (context, state) => const PswTaskListScreen()),
      GoRoute(path: '/offices/clinical/roles/psw/messages', builder: (context, state) => const PswMessagesScreen()),
      GoRoute(path: '/offices/clinical/roles/psw/visit-notes', builder: (context, state) => const PswVisitNotesScreen()),
      GoRoute(path: '/offices/clinical/roles/psw/profile', builder: (context, state) => const PswProfileScreen()),
      GoRoute(path: '/offices/clinical/roles/psw/reports', builder: (context, state) => const PswReportsScreen()),
      GoRoute(path: '/offices/clinical/roles/psw/documents', builder: (context, state) => const PswDocumentsScreen()),
      GoRoute(path: '/offices/clinical/roles/psw/check-in', builder: (context, state) => const PswCheckInScreen()),
      GoRoute(path: '/offices/clinical/roles/psw/system-logs', builder: (context, state) => const PswSystemLogsScreen()),
      GoRoute(path: '/offices/clinical/roles/psw/notifications', builder: (context, state) => const PswNotificationsScreen()),
      GoRoute(path: '/offices/clinical/roles/psw/help-support', builder: (context, state) => const PswHelpSupportScreen()),
      GoRoute(path: '/offices/clinical/roles/physician/dashboard', builder: (context, state) => const PhysicianDashboardScreen()),
      GoRoute(path: '/offices/clinical/roles/clinical_director/dashboard', builder: (context, state) => const ClinicalDirectorDashboardScreen()),
      GoRoute(path: '/offices/clinical/roles/intake_coordinator/dashboard', builder: (context, state) => const IntakeCoordinatorDashboardScreen()),
      GoRoute(path: '/offices/support/roles/quality_assurance/dashboard', builder: (context, state) => const QaDashboardScreen()),
      GoRoute(path: '/offices/support/roles/training_coordinator/dashboard', builder: (context, state) => const TrainingCoordinatorDashboardScreen()),
      GoRoute(path: '/dynamic/receptionistDashboard', builder: (context, state) => const ReceptionistDashboardScreen()),
      GoRoute(path: '/offices/clinical/roles/rmt/dashboard', builder: (context, state) => const RmtDashboardScreen()),
      GoRoute(path: '/offices/clinical/roles/chiropractor/dashboard', builder: (context, state) => const ChiropractorDashboardScreen()),
      GoRoute(path: '/offices/clinical/roles/physiotherapist/dashboard', builder: (context, state) => const PhysiotherapistDashboardScreen()),
      GoRoute(path: '/offices/clinical/roles/social_worker/dashboard', builder: (context, state) => const SocialWorkerDashboardScreen()),


    
    
    
      GoRoute(
        path: CommonRoutes.ssoRedirect,
        builder: (context, state) {
          final url = state.uri.queryParameters['url'] ?? 'http://localhost:3000';
          return SsoRedirectView(redirectUrl: url);
        },
      ),
      GoRoute(
        path: CommonRoutes.login,
        builder: (context, state) => const LoginView(),
      ),
    ],
  );
});
