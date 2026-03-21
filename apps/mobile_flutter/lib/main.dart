import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'features/auth/login_screen.dart';
import 'features/auth/forgot_password_screen.dart';
import 'features/psw/psw_shell_screen.dart';
import 'features/psw/psw_home_screen.dart';
import 'features/psw/psw_dashboard_screen.dart';
import 'features/psw/psw_daily_schedule_screen.dart';
import 'features/psw/psw_clients_screen.dart';
import 'features/psw/psw_timesheet_screen.dart';
import 'features/psw/psw_profile_screen.dart';
import 'features/psw/psw_messages_screen.dart';
import 'features/psw/psw_training_screen.dart';
import 'features/rn/rn_shell_screen.dart';
import 'features/shared/screens/universal_host_screen.dart';
import 'features/psw/psw_live_visit_screen.dart';
import 'features/psw/psw_live_video_triage_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/theme.dart';

import 'features/client/client_shell_screen.dart';
import 'features/client/client_dashboard_screen.dart';
import 'features/client/client_dashboard_screen.dart';
import 'features/coordinator/coordinator_shell_screen.dart';
import 'features/coordinator/coordinator_dashboard_screen.dart';
import 'features/coordinator/coordinator_jane_matrix_screen.dart';
import 'features/coordinator/coordinator_live_map_screen.dart';
import 'features/coordinator/coordinator_jane_scheduler_screen.dart';
import 'features/manager/manager_shell_screen.dart';
import 'features/manager/manager_dashboard_screen.dart';
import 'features/scrum_master/scrum_master_shell_screen.dart';
import 'features/scrum_master/scrum_master_dashboard_screen.dart';
import 'features/scrum_master/scrum_master_users_screen.dart';
import 'features/scrum_master/scrum_master_diagnostic_screen.dart';
import 'features/scrum_master/scrum_master_security_screen.dart';
import 'features/scrum_master/scrum_master_settings_screen.dart';
import 'features/gm/gm_shell_screen.dart';
import 'features/gm/gm_dashboard_screen.dart';
import 'features/gm/gm_marketing_hub_screen.dart';
import 'features/gm/gm_cost_reduction_screen.dart';
import 'features/gm/gm_expansion_wizard.dart';
import 'features/mt/mt_shell_screen.dart';
import 'features/mt/mt_dashboard_screen.dart';
import 'features/mt/mt_client_profile_screen.dart';
import 'features/mt/mt_soap_notes_screen.dart';
import 'features/mt/mt_intake_forms_screen.dart';
import 'features/mt/mt_invoice_screen.dart';
import 'features/mt/mt_earnings_screen.dart';
import 'features/mt/mt_availability_screen.dart';
import 'features/mt/mt_credentials_screen.dart';
import 'core/network/offline_sync_manager.dart';

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
          case 'manager':
          case 'admin': return '/manager/dashboard';
          case 'client': return '/client/dashboard';
          default: return '/psw/home';
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
      GoRoute(
        path: '/psw/live-video-triage/:id',
        builder: (context, state) => PswLiveVideoTriageScreen(incidentId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/psw/daily-timeline',
        builder: (context, state) => const PswDailyScheduleScreen(),
      ),
      // RN Hub Shell (Phase 23)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return RnShellScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/rn/dashboard',
                builder: (context, state) => const UniversalHostScreen(endpoint: '/v1/sdui/dashboard'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/rn/patients',
                builder: (context, state) => const PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText('RN Patients Scope Active'))),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/rn/inbox',
                builder: (context, state) => const PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText('RN Inbox Thread Active'))),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/rn/profile',
                builder: (context, state) => const PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText('RN Profile Active'))),
              ),
            ],
          ),
        ],
      ),

      // PSW Role Route
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return PswShellScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(routes: [GoRoute(path: '/psw/home', builder: (context, state) => const PswHomeScreen())]),
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
      GoRoute(
        path: '/coordinator/live-map',
        builder: (context, state) => const CoordinatorLiveMapScreen(),
      ),
      GoRoute(
        path: '/coordinator/fleet-matrix',
        builder: (context, state) => const CoordinatorJaneSchedulerScreen(),
      ),
      // Removing the top-level route because it gets mapped INSIDE the Shell now.
      // Coordinator Hub Shell (Phase 24)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return CoordinatorShellScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/coordinator/dashboard',
                builder: (context, state) => const CoordinatorJaneMatrixScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/coordinator/staff',
                builder: (context, state) => const PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText('Coordinator Staff Active'))),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/coordinator/approvals',
                builder: (context, state) => const PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText('Coordinator Approvals Active'))),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/coordinator/profile',
                builder: (context, state) => const PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText('Coordinator Profile Active'))),
              ),
            ],
          ),
        ],
      ),
      // Manager Hub Shell (Phase 25)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ManagerShellScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/manager/dashboard',
                builder: (context, state) => const ManagerDashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/manager/directory',
                builder: (context, state) => const PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText('Manager Directory Active'))),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/manager/system',
                builder: (context, state) => const PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText('Manager System Active'))),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/manager/execute',
                builder: (context, state) => const PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText('Manager Execute Active'))),
              ),
            ],
          ),
        ],
      ),
      // Scrum Master Hub Shell (Phase 43)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScrumMasterShellScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/scrum-master/dashboard',
                builder: (context, state) => const ScrumMasterDashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/scrum-master/diagnostic',
                builder: (context, state) => const ScrumMasterDiagnosticScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/scrum-master/tenants',
                builder: (context, state) => const ScrumMasterUsersScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/scrum-master/security',
                builder: (context, state) => const ScrumMasterSecurityScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/scrum-master/settings',
                builder: (context, state) => const ScrumMasterSettingsScreen(),
              ),
            ],
          ),
        ],
      ),
      // --- MASSAGE THERAPIST (MT) CLINICAL ROUTES ---
      GoRoute(path: '/mt/client-profile', builder: (context, state) => const MtClientProfileScreen()),
      GoRoute(path: '/mt/soap-notes', builder: (context, state) => const MtSoapNotesScreen()),
      GoRoute(path: '/mt/intake-forms', builder: (context, state) => const MtIntakeFormsScreen()),
      GoRoute(path: '/mt/invoice', builder: (context, state) => const MtInvoiceScreen()),
      GoRoute(path: '/mt/earnings', builder: (context, state) => const MtEarningsScreen()),
      GoRoute(path: '/mt/availability', builder: (context, state) => const MtAvailabilityScreen()),
      GoRoute(path: '/mt/credentials', builder: (context, state) => const MtCredentialsScreen()),

      // General Manager (GM) Executive Shell (Phase 45)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return GmShellScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/gm/dashboard',
                builder: (context, state) => const GmDashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/gm/marketing',
                builder: (context, state) => const GmMarketingHubScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/gm/revenue',
                builder: (context, state) => const GmCostReductionScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/gm/expand',
                builder: (context, state) => const GmExpansionWizardScreen(),
              ),
            ],
          ),
        ],
      ),
      // Massage Therapist (MT) Shell
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MtShellScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/mt/dashboard',
                builder: (context, state) => const MtDashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/mt/clients',
                builder: (context, state) => const PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText('MT Clients Active'))),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/mt/messages',
                builder: (context, state) => const PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText('MT Messages Active'))),
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
    final appRouter = ref.watch(routerProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'PrimeCare Mobile',
      theme: PrimeCareTheme.lightTheme,
      darkTheme: PrimeCareTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
