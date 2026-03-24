import 'features/shared/universal_dashboard_screen.dart';
import 'features/shared/universal_inbox_screen.dart';
import 'features/rn/rn_patients_screen.dart';
import 'features/shared/universal_daily_tasks_screen.dart';
import 'package:primecare_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/locale_provider.dart';
import 'package:go_router/go_router.dart';
import 'features/auth/login_screen.dart';
import 'features/dashboard/dashboard_screen.dart';
import 'features/auth/forgot_password_screen.dart';
import 'features/psw/psw_home_screen.dart';
import 'features/psw/psw_dashboard_screen.dart';
import 'features/psw/psw_daily_schedule_screen.dart';
import 'features/psw/psw_clients_screen.dart';
import 'features/psw/psw_timesheet_screen.dart';
import 'features/psw/psw_profile_screen.dart';
import 'features/psw/psw_messages_screen.dart';
import 'features/psw/psw_training_screen.dart';
import 'features/shared/screens/universal_host_screen.dart';
import 'features/psw/psw_live_visit_screen.dart';
import 'features/psw/psw_live_video_triage_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/theme.dart';
import 'core/theme_provider.dart';

import 'features/admin/admin_network_screen.dart';
import 'features/admin/admin_audit_screen.dart';
import 'features/admin/admin_telemetry_screen.dart';

import 'features/client/client_dashboard_screen.dart';
import 'features/coordinator/coordinator_jane_matrix_screen.dart';
import 'features/coordinator/coordinator_live_map_screen.dart';
import 'features/coordinator/coordinator_jane_scheduler_screen.dart';
import 'features/manager/manager_dashboard_screen.dart';
import 'features/scrum_master/scrum_master_dashboard_screen.dart';
import 'features/scrum_master/scrum_master_users_screen.dart';
import 'features/scrum_master/scrum_master_diagnostic_screen.dart';
import 'features/scrum_master/scrum_master_security_screen.dart';
import 'features/scrum_master/scrum_master_settings_screen.dart';
import 'features/gm/gm_dashboard_screen.dart';
import 'features/gm/gm_marketing_hub_screen.dart';
import 'features/gm/gm_cost_reduction_screen.dart';
import 'features/gm/gm_expansion_wizard.dart';
import 'features/mt/mt_dashboard_screen.dart';
import 'features/mt/mt_client_profile_screen.dart';
import 'features/mt/mt_soap_notes_screen.dart';
import 'features/mt/mt_intake_forms_screen.dart';
import 'features/mt/mt_invoice_screen.dart';
import 'features/mt/mt_earnings_screen.dart';
import 'features/mt/mt_availability_screen.dart';
import 'features/mt/mt_credentials_screen.dart';
import 'features/shared/role_mentor_screen.dart';
import 'features/shared/universal_timeline_screen.dart';
import 'core/network/offline_sync_manager.dart';
import 'core/api_client.dart';
import 'core/widgets/global_top_bar.dart';
import 'core/widgets/universal_role_sidebar.dart';
import 'package:primecare_ui/primecare_ui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  OfflineSyncManager().initializeSyncListener();
  
  runApp(ProviderScope(child: PrimeCareApp()));
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
          case 'mt': return '/mt/dashboard';
          case 'gm':
          case 'general_manager': return '/gm/dashboard';
          case 'scrum_master': return '/scrum-master/dashboard';
          case 'rn': return '/rn/dashboard';
          case 'coordinator': return '/coordinator/dashboard';
          case 'manager': return '/manager/dashboard';
          case 'admin':
          case 'super_admin': return '/dashboard';
          case 'client': return '/client/dashboard';
          default: return '/psw/home';
        }
      }
      return null;
    },
    routes: [
        GoRoute(path: '/:role/dashboard', builder: (context, state) => UniversalDashboardScreen(rolePrefix: state.pathParameters['role'] ?? 'psw')),

        GoRoute(path: '/:role/inbox', builder: (context, state) => UniversalInboxScreen(rolePrefix: state.pathParameters['role'] ?? 'psw')),

      GoRoute(
        path: '/login',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => ForgotPasswordScreen(),
      ),
      // UNIVERSAL MASTER SHELL ROUTE
      ShellRoute(
        builder: (context, state, child) {
          return PrimeCareScaffold(
            appBar: GlobalTopBar(
              title: 'PrimeCare Platform',
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
          // ======================= PSW =======================
          GoRoute(path: '/psw/home', builder: (context, state) => PswHomeScreen()),
          
          GoRoute(path: '/psw/clients', builder: (context, state) => PswClientsScreen()),
          GoRoute(path: '/psw/timesheet', builder: (context, state) => PswTimesheetScreen()),
          GoRoute(path: '/psw/profile', builder: (context, state) => PswProfileScreen()),
          GoRoute(path: '/psw/messages', builder: (context, state) => PswMessagesScreen()),
          GoRoute(path: '/psw/training', builder: (context, state) => PswTrainingScreen()),
          GoRoute(path: '/psw/live-visit/:id', builder: (context, state) => PswLiveVisitScreen(visitId: state.pathParameters['id']!)),
          GoRoute(path: '/psw/live-video-triage/:id', builder: (context, state) => PswLiveVideoTriageScreen(incidentId: state.pathParameters['id']!)),
          GoRoute(path: '/psw/dailyTasks', builder: (context, state) => const UniversalDailyTasksScreen(rolePrefix: 'psw')),
          GoRoute(path: '/psw/activities', builder: (context, state) => const UniversalTimelineScreen(rolePrefix: 'psw')),
          GoRoute(path: '/psw/dailyTasks', builder: (context, state) => const UniversalTimelineScreen(rolePrefix: 'psw')),
          GoRoute(path: '/psw/mentor', builder: (context, state) => const RoleMentorScreen(rolePrefix: 'psw')),
          GoRoute(path: '/psw/daily-timeline', builder: (context, state) => PswDailyScheduleScreen()),
          
          // ======================= RN ========================
          
          GoRoute(path: '/rn/patients', builder: (context, state) => const RnPatientsScreen()),
          GoRoute(path: '/rn/inbox', builder: (context, state) => PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText(AppLocalizations.of(context)!.rnInboxThreadActive)))),
          GoRoute(path: '/rn/dailyTasks', builder: (context, state) => const UniversalDailyTasksScreen(rolePrefix: 'rn')),
          GoRoute(path: '/rn/activities', builder: (context, state) => const UniversalTimelineScreen(rolePrefix: 'rn')),
          GoRoute(path: '/rn/dailyTasks', builder: (context, state) => const UniversalTimelineScreen(rolePrefix: 'rn')),
          GoRoute(path: '/rn/mentor', builder: (context, state) => const RoleMentorScreen(rolePrefix: 'rn')),
          GoRoute(path: '/rn/profile', builder: (context, state) => PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText(AppLocalizations.of(context)!.rnProfileActive)))),

          // ======================= CLIENT ====================
          
          GoRoute(path: '/client/pulse', builder: (context, state) => PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText('Wellness Pulse View')))),
          GoRoute(path: '/client/dailyTasks', builder: (context, state) => const UniversalDailyTasksScreen(rolePrefix: 'client')),
          GoRoute(path: '/client/activities', builder: (context, state) => const UniversalTimelineScreen(rolePrefix: 'client')),
          GoRoute(path: '/client/dailyTasks', builder: (context, state) => const UniversalTimelineScreen(rolePrefix: 'client')),
          GoRoute(path: '/client/mentor', builder: (context, state) => const RoleMentorScreen(rolePrefix: 'client')),
          GoRoute(path: '/client/profile', builder: (context, state) => PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText('Client Family Settings')))),

          // ======================= ADMIN =====================
          GoRoute(path: '/dashboard', builder: (context, state) => DashboardScreen()),
          GoRoute(path: '/admin/network', builder: (context, state) => AdminNetworkScreen()),
          GoRoute(path: '/admin/telemetry', builder: (context, state) => const AdminTelemetryScreen()),
          GoRoute(path: '/admin/audit', builder: (context, state) => AdminAuditScreen()),
          GoRoute(path: '/admin/dailyTasks', builder: (context, state) => const UniversalDailyTasksScreen(rolePrefix: 'admin')),
          GoRoute(path: '/admin/activities', builder: (context, state) => const UniversalTimelineScreen(rolePrefix: 'admin')),
          GoRoute(path: '/admin/dailyTasks', builder: (context, state) => const UniversalTimelineScreen(rolePrefix: 'admin')),
          GoRoute(path: '/admin/mentor', builder: (context, state) => const RoleMentorScreen(rolePrefix: 'admin')),
          GoRoute(path: '/admin/settings', builder: (context, state) => PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText('Global Environment Variables')))),

          // ======================= COORDINATOR ===============
          
          GoRoute(path: '/coordinator/staff', builder: (context, state) => PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText(AppLocalizations.of(context)!.coordinatorStaffActive)))),
          GoRoute(path: '/coordinator/approvals', builder: (context, state) => PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText(AppLocalizations.of(context)!.coordinatorApprovalsActive)))),
          GoRoute(path: '/coordinator/profile', builder: (context, state) => PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText(AppLocalizations.of(context)!.coordinatorProfileActive)))),
          GoRoute(path: '/coordinator/live-map', builder: (context, state) => CoordinatorLiveMapScreen()),
          GoRoute(path: '/coordinator/dailyTasks', builder: (context, state) => const UniversalDailyTasksScreen(rolePrefix: 'coordinator')),
          GoRoute(path: '/coordinator/activities', builder: (context, state) => const UniversalTimelineScreen(rolePrefix: 'coordinator')),
          GoRoute(path: '/coordinator/dailyTasks', builder: (context, state) => const UniversalTimelineScreen(rolePrefix: 'coordinator')),
          GoRoute(path: '/coordinator/mentor', builder: (context, state) => const RoleMentorScreen(rolePrefix: 'coordinator')),
          GoRoute(path: '/coordinator/fleet-matrix', builder: (context, state) => CoordinatorJaneSchedulerScreen()),

          // ======================= MANAGER ===================
          
          GoRoute(path: '/manager/reports', builder: (context, state) => PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText('Manager Reports Active')))),
          GoRoute(path: '/manager/teams', builder: (context, state) => PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText('Manager Teams Active')))),
          GoRoute(path: '/manager/dailyTasks', builder: (context, state) => const UniversalDailyTasksScreen(rolePrefix: 'manager')),
          GoRoute(path: '/manager/activities', builder: (context, state) => const UniversalTimelineScreen(rolePrefix: 'manager')),
          GoRoute(path: '/manager/dailyTasks', builder: (context, state) => const UniversalTimelineScreen(rolePrefix: 'manager')),
          GoRoute(path: '/manager/mentor', builder: (context, state) => const RoleMentorScreen(rolePrefix: 'manager')),
          GoRoute(path: '/manager/profile', builder: (context, state) => PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText('Manager Profile Active')))),

          // ======================= MT ========================
          
          GoRoute(path: '/mt/clients', builder: (context, state) => PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText(AppLocalizations.of(context)!.mtClientsActive)))),
          GoRoute(path: '/mt/messages', builder: (context, state) => PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText(AppLocalizations.of(context)!.mtMessagesActive)))),
          GoRoute(path: '/mt/dailyTasks', builder: (context, state) => const UniversalDailyTasksScreen(rolePrefix: 'mt')),
          GoRoute(path: '/mt/activities', builder: (context, state) => const UniversalTimelineScreen(rolePrefix: 'mt')),
          GoRoute(path: '/mt/dailyTasks', builder: (context, state) => const UniversalTimelineScreen(rolePrefix: 'mt')),
          GoRoute(path: '/mt/mentor', builder: (context, state) => const RoleMentorScreen(rolePrefix: 'mt')),
          // ======================= GM =======================
          
          GoRoute(path: '/gm/dailyTasks', builder: (context, state) => const UniversalDailyTasksScreen(rolePrefix: 'gm')),
          GoRoute(path: '/gm/activities', builder: (context, state) => const UniversalTimelineScreen(rolePrefix: 'gm')),
          GoRoute(path: '/gm/dailyTasks', builder: (context, state) => const UniversalTimelineScreen(rolePrefix: 'gm')),
          GoRoute(path: '/gm/mentor', builder: (context, state) => const RoleMentorScreen(rolePrefix: 'gm')),
          // ======================= SCRUM MASTER ===========
          
          GoRoute(path: '/scrum-master/dailyTasks', builder: (context, state) => const UniversalDailyTasksScreen(rolePrefix: 'scrum_master')),
          GoRoute(path: '/scrum-master/activities', builder: (context, state) => const UniversalTimelineScreen(rolePrefix: 'scrum_master')),
          GoRoute(path: '/scrum-master/dailyTasks', builder: (context, state) => const UniversalTimelineScreen(rolePrefix: 'scrum_master')),
          GoRoute(path: '/scrum-master/mentor', builder: (context, state) => const RoleMentorScreen(rolePrefix: 'scrum_master')),
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
      onGenerateTitle: (context) => AppLocalizations.of(context)!.primecareMobile,
      theme: PrimeCareTheme.lightTheme,
      darkTheme: PrimeCareTheme.darkTheme,
      themeMode: ref.watch(themeProvider),
      routerConfig: appRouter,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
