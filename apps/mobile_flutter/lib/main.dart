import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:primecare_mobile/l10n/app_localizations.dart';

// Core Imports
import 'package:primecare_ui/primecare_ui.dart';
import 'core/theme_provider.dart';
import 'core/locale_provider.dart';
import 'core/network/offline_sync_manager.dart';
import 'core/api_client.dart';
import 'core/widgets/global_top_bar.dart';
import 'core/widgets/universal_role_sidebar.dart';

// Authenticated UX Verified Screens (Audited)
import 'features/auth/login_screen.dart';
import 'features/auth/forgot_password_screen.dart';

import 'features/psw/psw_home_screen.dart';
import 'features/psw/psw_live_visit_screen.dart';
import 'features/psw/psw_timesheet_screen.dart';
import 'features/psw/psw_earnings_screen.dart';

import 'features/rn/rn_patients_screen.dart';
import 'features/rn/rn_care_plan_screen.dart';
import 'features/rn/rn_med_recon_screen.dart';

import 'features/coordinator/coordinator_hub_screen.dart';
import 'features/coordinator/coordinator_approvals_screen.dart';
import 'features/coordinator/coordinator_callin_screen.dart';
import 'features/coordinator/coordinator_visit_adjustment_screen.dart';

import 'features/manager/manager_reports_screen.dart';
import 'features/manager/manager_teams_screen.dart';
import 'features/manager/manager_payroll_screen.dart';
import 'features/manager/manager_incidents_screen.dart';

import 'features/admin/admin_telemetry_screen.dart';

import 'features/client/client_wellness_pulse_screen.dart';
import 'features/client/client_care_team_screen.dart';
import 'features/client/client_dispatch_tracker_screen.dart';
import 'features/client/client_payments_screen.dart';
import 'features/client/client_inbox_screen.dart';

import 'features/gm/gm_executive_dashboard_screen.dart';
import 'features/gm/gm_pnl_screen.dart';
import 'features/mt/mt_analytics_hub_screen.dart';
import 'features/mt/mt_surge_config_screen.dart';
import 'features/scrum_master/scrum_master_ops_screen.dart';
import 'features/scrum_master/tracking_matrix_screen.dart';
import 'features/superuser/superuser_control_screen.dart';
import 'features/superuser/superuser_registry_sync_screen.dart';

// Verified Universal Screens
import 'features/shared/universal_home_screen.dart';
import 'features/shared/universal_inbox_screen.dart';
import 'features/shared/universal_chat_thread_screen.dart';
import 'features/shared/universal_call_screen.dart';
import 'features/shared/universal_daily_tasks_screen.dart';
import 'features/shared/universal_timeline_screen.dart';
import 'features/shared/role_mentor_screen.dart';
import 'features/shared/universal_thin_hub_screen.dart';
import 'features/coordinator/jane_scheduler_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  OfflineSyncManager().initializeSyncListener();
  runApp(const ProviderScope(child: PrimeCareApp()));
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) async {
      final prefs = await SharedPreferences.getInstance();
      final hasToken = prefs.containsKey('auth_token');
      final isLoggingIn = state.uri.toString() == '/login';
      final isRoot = state.uri.toString() == '/';

      if (!hasToken && !isLoggingIn) return '/login';

      if (hasToken && (isLoggingIn || isRoot)) {
        final role = prefs.getString('user_role') ?? 'psw';
        switch (role) {
          case 'rn':
            return '/rn/home';
          case 'coordinator':
            return '/coordinator/home';
          case 'manager':
            return '/manager/home';
          case 'admin':
            return '/admin/home';
          case 'client':
            return '/client/home';
          case 'gm':
            return '/gm/home';
          case 'mt':
            return '/mt/home';
          case 'scrum':
            return '/scrum_master/home';
          case 'superuser':
            return '/superuser/home';
          default:
            return '/psw/home';
        }
      }
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => ForgotPasswordScreen(),
      ),

      ShellRoute(
        builder: (context, state, child) {
          return Scaffold(
            appBar: GlobalTopBar(
              title: 'PrimeCare Native',
              onLogout: () async {
                await apiClient.logout();
                context.go('/login');
              },
            ),
            body: UniversalRoleSidebar(
              currentPath: state.uri.toString(),
              child: child,
            ),
          );
        },
        routes: [
          // ================== NARROW PATH (THIN VIEW) ==================
          GoRoute(
            path: '/thin-hub',
            builder: (context, state) => const UniversalThinHubScreen(),
          ),

          // ================== PSW ==================
          GoRoute(
            path: '/psw/home',
            builder: (context, state) => const PswHomeScreen(),
          ),
          GoRoute(
            path: '/psw/live-visit/:id',
            builder: (context, state) => const PswLiveVisitScreen(),
          ),
          GoRoute(
            path: '/psw/timesheets',
            builder: (context, state) => const PswTimesheetScreen(),
          ),
          GoRoute(
            path: '/psw/earnings',
            builder: (context, state) => const PswEarningsScreen(),
          ),

          // ================== RN ==================
          GoRoute(
            path: '/rn/home',
            builder: (context, state) => const RnPatientsScreen(),
          ),
          GoRoute(
            path: '/rn/care-plan',
            builder: (context, state) => const RnCarePlanScreen(),
          ),
          GoRoute(
            path: '/rn/med-recon/:id',
            builder: (context, state) => RnMedReconScreen(patientId: state.pathParameters['id'] ?? ''),
          ),

          // ================== COORDINATOR ==================
          GoRoute(
            path: '/coordinator/home',
            builder: (context, state) => const CoordinatorHubScreen(),
          ),
          GoRoute(
            path: '/coordinator/approvals',
            builder: (context, state) => const CoordinatorApprovalsScreen(),
          ),
          GoRoute(
            path: '/coordinator/callin',
            builder: (context, state) => const CoordinatorCallinScreen(),
          ),
          GoRoute(
            path: '/coordinator/visit-adjust',
            builder: (context, state) => const CoordinatorVisitAdjustmentScreen(),
          ),
          GoRoute(
            path: '/coordinator/scheduler',
            builder: (context, state) => const InteractiveJaneSchedulerScreen(),
          ),

          // ================== MANAGER ==================
          GoRoute(
            path: '/manager/home',
            builder: (context, state) => const ManagerReportsScreen(),
          ),
          GoRoute(
            path: '/manager/teams',
            builder: (context, state) => const ManagerTeamsScreen(),
          ),
          GoRoute(
            path: '/manager/payroll',
            builder: (context, state) => const ManagerPayrollScreen(),
          ),
          GoRoute(
            path: '/manager/incidents',
            builder: (context, state) => const ManagerIncidentsScreen(),
          ),

          // ================== ADMIN ==================
          GoRoute(
            path: '/admin/home',
            builder: (context, state) => const AdminTelemetryScreen(),
          ),

          // ================== CLIENT ==================
          GoRoute(
            path: '/client/home',
            builder: (context, state) => const ClientCareTeamScreen(),
          ),
          GoRoute(
            path: '/client/pulse',
            builder: (context, state) => const ClientWellnessPulseScreen(),
          ),
          GoRoute(
            path: '/client/dispatch',
            builder: (context, state) => const ClientDispatchTrackerScreen(),
          ),
          GoRoute(
            path: '/client/payments',
            builder: (context, state) => const ClientPaymentsScreen(),
          ),
          GoRoute(
            path: '/universal/client/inbox',
            builder: (context, state) => const ClientInboxScreen(),
          ),

          // ================== GM ==================
          GoRoute(
            path: '/scrum_master/tracking',
            builder: (context, state) => const TrackingMatrixScreen(),
          ),
          GoRoute(
            path: '/gm_home',
            builder: (context, state) => const GmExecutiveDashboardScreen(),
          ),
          GoRoute(
            path: '/gm/pnl',
            builder: (context, state) => const GmPnlScreen(),
          ),

          // ================== MT ==================
          GoRoute(
            path: '/mt/home',
            builder: (context, state) => const MtAnalyticsHubScreen(),
          ),
          GoRoute(
            path: '/mt/surge-config',
            builder: (context, state) => const MtSurgeConfigScreen(),
          ),

          // ================== SCRUM MASTER ==================
          GoRoute(
            path: '/scrum_master/home',
            builder: (context, state) => const ScrumMasterOpsScreen(),
          ),

          // ================== SUPERUSER ==================
          GoRoute(
            path: '/superuser/home',
            builder: (context, state) => const SuperuserControlScreen(),
          ),
          GoRoute(
            path: '/superuser/registry',
            builder: (context, state) => const SuperuserRegistrySyncScreen(),
          ),

          // ================== UNIVERSAL (Fallback) ==================
          GoRoute(
            path: '/universal/:role/inbox',
            builder: (context, state) => UniversalInboxScreen(
              rolePrefix: state.pathParameters['role'] ?? 'psw',
            ),
          ),
          GoRoute(
            path: '/universal/:role/dailyTasks',
            builder: (context, state) => UniversalDailyTasksScreen(
              rolePrefix: state.pathParameters['role'] ?? 'psw',
            ),
          ),
          GoRoute(
            path: '/universal/:role/activities',
            builder: (context, state) => UniversalTimelineScreen(
              rolePrefix: state.pathParameters['role'] ?? 'psw',
            ),
          ),
          GoRoute(
            path: '/universal/:role/mentor',
            builder: (context, state) => RoleMentorScreen(
              rolePrefix: state.pathParameters['role'] ?? 'psw',
            ),
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
    final appRouter = ref.watch(routerProvider);
    final locale = ref.watch(localeProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) =>
          AppLocalizations.of(context)!.primecareMobile,
      theme: AppTheme.lightTheme,

      themeMode: ref.watch(themeProvider),
      routerConfig: appRouter,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
