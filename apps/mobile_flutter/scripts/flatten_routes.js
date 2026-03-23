const fs = require('fs');
const path = require('path');

const mainDartPath = path.join(__dirname, '../lib/main.dart');
let content = fs.readFileSync(mainDartPath, 'utf8');

// Ensure import for UniversalRoleSidebar
if (!content.includes("import 'core/widgets/universal_role_sidebar.dart';")) {
  content = content.replace("import 'core/widgets/global_top_bar.dart';", "import 'core/widgets/global_top_bar.dart';\nimport 'core/widgets/universal_role_sidebar.dart';");
}

// 1. Locate the Universal Master Shell Route
const masterShellRegex = /\/\/ UNIVERSAL MASTER SHELL ROUTE[\s\S]*?ShellRoute\([\s\S]*?builder:\s*\(context,\s*state,\s*child\)\s*\{[\s\S]*?return\s*PrimeCareScaffold\([\s\S]*?body:\s*child,[\s\S]*?\)\]/g;

// Wait, doing an exact static rebuild of the router is much safer and guarantees perfectly formatted Dart.
// We will replace from `final routerProvider = Provider<GoRouter>((ref) {` down to `});` before `class PrimeCareApp`

const routerStart = content.indexOf('final routerProvider = Provider<GoRouter>((ref) {');
const appStart = content.indexOf('class PrimeCareApp extends ConsumerWidget {');

if (routerStart === -1 || appStart === -1) {
  console.error("Could not find boundaries.");
  process.exit(1);
}

const beforeRouter = content.substring(0, routerStart);
const afterRouter = content.substring(appStart);

const newRouter = `final routerProvider = Provider<GoRouter>((ref) {
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
          GoRoute(path: '/psw/dashboard', builder: (context, state) => PswDashboardScreen()),
          GoRoute(path: '/psw/clients', builder: (context, state) => PswClientsScreen()),
          GoRoute(path: '/psw/timesheet', builder: (context, state) => PswTimesheetScreen()),
          GoRoute(path: '/psw/profile', builder: (context, state) => PswProfileScreen()),
          GoRoute(path: '/psw/messages', builder: (context, state) => PswMessagesScreen()),
          GoRoute(path: '/psw/training', builder: (context, state) => PswTrainingScreen()),
          GoRoute(path: '/psw/live-visit/:id', builder: (context, state) => PswLiveVisitScreen(visitId: state.pathParameters['id']!)),
          GoRoute(path: '/psw/live-video-triage/:id', builder: (context, state) => PswLiveVideoTriageScreen(incidentId: state.pathParameters['id']!)),
          GoRoute(path: '/psw/daily-timeline', builder: (context, state) => PswDailyScheduleScreen()),
          
          // ======================= RN ========================
          GoRoute(path: '/rn/dashboard', builder: (context, state) => UniversalHostScreen(endpoint: '/v1/sdui/dashboard')),
          GoRoute(path: '/rn/patients', builder: (context, state) => PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText(AppLocalizations.of(context)!.rnPatientsScopeActive)))),
          GoRoute(path: '/rn/inbox', builder: (context, state) => PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText(AppLocalizations.of(context)!.rnInboxThreadActive)))),
          GoRoute(path: '/rn/profile', builder: (context, state) => PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText(AppLocalizations.of(context)!.rnProfileActive)))),

          // ======================= CLIENT ====================
          GoRoute(path: '/client/dashboard', builder: (context, state) => ClientDashboardScreen()),
          GoRoute(path: '/client/pulse', builder: (context, state) => PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText('Wellness Pulse View')))),
          GoRoute(path: '/client/profile', builder: (context, state) => PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText('Client Family Settings')))),

          // ======================= ADMIN =====================
          GoRoute(path: '/dashboard', builder: (context, state) => DashboardScreen()),
          GoRoute(path: '/admin/network', builder: (context, state) => PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText('Network Operations Dashboard')))),
          GoRoute(path: '/admin/audit', builder: (context, state) => PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText('Compliance Log View')))),
          GoRoute(path: '/admin/settings', builder: (context, state) => PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText('Global Environment Variables')))),

          // ======================= COORDINATOR ===============
          GoRoute(path: '/coordinator/dashboard', builder: (context, state) => CoordinatorJaneMatrixScreen()),
          GoRoute(path: '/coordinator/staff', builder: (context, state) => PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText(AppLocalizations.of(context)!.coordinatorStaffActive)))),
          GoRoute(path: '/coordinator/approvals', builder: (context, state) => PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText(AppLocalizations.of(context)!.coordinatorApprovalsActive)))),
          GoRoute(path: '/coordinator/profile', builder: (context, state) => PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText(AppLocalizations.of(context)!.coordinatorProfileActive)))),
          GoRoute(path: '/coordinator/live-map', builder: (context, state) => CoordinatorLiveMapScreen()),
          GoRoute(path: '/coordinator/fleet-matrix', builder: (context, state) => CoordinatorJaneSchedulerScreen()),

          // ======================= MANAGER ===================
          GoRoute(path: '/manager/dashboard', builder: (context, state) => ManagerDashboardScreen()),
          GoRoute(path: '/manager/reports', builder: (context, state) => PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText(AppLocalizations.of(context)!.managerReportsActive)))),
          GoRoute(path: '/manager/teams', builder: (context, state) => PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText(AppLocalizations.of(context)!.managerTeamsActive)))),
          GoRoute(path: '/manager/profile', builder: (context, state) => PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText(AppLocalizations.of(context)!.managerProfileActive)))),

          // ======================= MT ========================
          GoRoute(path: '/mt/dashboard', builder: (context, state) => MtDashboardScreen()),
          GoRoute(path: '/mt/clients', builder: (context, state) => PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText(AppLocalizations.of(context)!.mtClientsActive)))),
          GoRoute(path: '/mt/messages', builder: (context, state) => PrimeCareScaffold(body: PrimeCareCenter(child: PrimeCareText(AppLocalizations.of(context)!.mtMessagesActive)))),
        ],
      ),
    ],
  );
});

`;

fs.writeFileSync(mainDartPath, beforeRouter + newRouter + afterRouter, 'utf8');
console.log("SUCCESS: Flat architecture configured!");
