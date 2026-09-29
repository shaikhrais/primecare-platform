// Governance - Category: middleware | Purpose: Routing definition mapping client endpoints, paths, layouts, and access guards.
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import '../ui/dynamic_screen_view.dart';
import '../ui/language_selector.dart';
import '../ui/app_drawer.dart';
import '../../features/qa/screens/audit_dashboard_screen.dart';
import '../../features/qa/screens/compliance_reviews_screen.dart';
import '../../features/qa/screens/incident_reports_screen.dart';
import '../../features/qa/screens/quality_metrics_screen.dart';
import '../../features/audit/screens/audit_log_screen.dart';
import '../../features/audit/screens/monitoring_screen.dart';
import '../../features/audit/screens/ticket_center_screen.dart';
import '../../features/audit/screens/screen_status_screen.dart';
import '../../features/security/screens/security_hub_screen.dart';
import '../../features/security/screens/security_sentinel_screen.dart';
import '../../features/security/screens/verification_center_screen.dart';
import '../../features/reference/screens/clinical_reference_screen.dart';
import '../../features/executive/screens/growth_pipeline_screen.dart';
import '../../features/executive/screens/regional_performance_screen.dart';
import '../../features/executive/screens/leadership_reports_screen.dart';
import '../../features/executive/screens/governance_hud_screen.dart';
import '../../features/executive/screens/control_center_screen.dart';
import '../../features/executive/screens/proposals_screen.dart';


final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    // Unknown deep links must not enter the global error/restart loop.
    onException: (context, state, router) {
      router.go(ref.read(authProvider).isAuthenticated
          ? CommonRoutes.authError
          : CommonRoutes.login);
    },
    refreshListenable: authListenable,
    redirect: (context, state) {
      final session = ref.read(authProvider);
      if (!session.isInitialized) {
        return SharedAuthRoutes.publicPaths.contains(state.uri.path)
            ? null
            : CommonRoutes.login;
      }
      if (!session.isAuthenticated && state.uri.path == CommonRoutes.authCallback) {
        return CommonRoutes.login;
      }
      final isAuth = session.isAuthenticated;
      final isLoggingIn = state.matchedLocation == '/login' || 
                          state.matchedLocation == '/' ||
                          state.matchedLocation == '/auth/callback';
      
      if (!isAuth && !isLoggingIn &&
          !SharedAuthRoutes.publicPaths.contains(state.uri.path)) return '/login';
      if (isAuth && isLoggingIn) {
        final role = ref.read(authProvider).role ?? '';
        final targetRoute = AuthNotifier.getDashboardRouteForRole(role);
        
        final screenRoutes = ScreenRegistry.screens.values.map((s) => s.routePath).toList();
        
        // Exact match
        if (screenRoutes.contains(targetRoute)) return targetRoute;

        // Try matching the end of the path (Governance registry paths omit office prefixes)
        try {
          final matchingPath = screenRoutes.firstWhere((p) => targetRoute.endsWith(p));
          return matchingPath;
        } catch (_) {}

        // Fallback 1: Screen ID contains the role key
        final roleKey = role.toUpperCase().replaceAll(' ', '').replaceAll('_', '');
        try {
          final matchingScreen = ScreenRegistry.screens.values.firstWhere((s) => s.id.contains(roleKey));
          return matchingScreen.routePath;
        } catch (_) {}

        // Fallback 2: Admin/CEO fallback (prioritize a Dashboard)
        if (roleKey == 'ADMIN' || roleKey == 'SUPERADMIN' || roleKey == 'CEO') {
          try {
            final adminDashboard = ScreenRegistry.screens.values.firstWhere((s) => s.id.contains('DASHBOARD'));
            return adminDashboard.routePath;
          } catch (_) {}
        }

        // Fallback 3: Universal fallback for all other roles - first authorized screen
        try {
          final authorizedScreen = ScreenRegistry.screens.values.firstWhere((s) {
            return s.roles.contains(roleKey) || s.roles.contains('ALL');
          });
          return authorizedScreen.routePath;
        } catch (_) {}

        return '/governance/placeholder';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: CommonRoutes.authCallback,
        redirect: (context, state) => CommonRoutes.login,
      ),
      ...SharedAuthRoutes.routes(),
      ...SharedAuthRoutes.protectedRoutes(),
      ShellRoute(
        builder: (context, state, child) {
          final matchedLocation = state.matchedLocation;
          final screen = ScreenRegistry.screens.values
              .cast<ScreenMetadata?>()
              .firstWhere(
                (s) => s?.routePath == matchedLocation,
                orElse: () => null,
              );
          final title = screen?.title ?? 'Platform Governance';
          final screenId = screen?.id ?? 'UNKNOWN';

          return Scaffold(
            appBar: AppBar(
              title: Text(title),
              actions: [
                const LanguageSelector(),
                const SizedBox(width: 8),
                Builder(
                  builder: (context) => IconButton(
                    key: const Key('route_registry_iconbutton_button_1'),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    icon: const Icon(LucideIcons.search),
                  ),
                ),
                const CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    'https://api.dicebear.com/7.x/avataaars/png?seed=Admin',
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
            drawer: const AppDrawer(),
            endDrawer: AuraNexusConsoleDrawer(activeScreenId: screenId),
            body: child,
          );
        },
        routes: [
          // Native QA & Compliance Routes
          GoRoute(path: '/admin/screen-health', builder: (context, state) => const AdminScreenHealthScreen()),
          GoRoute(path: '/admin/reality-check', builder: (context, state) => const AdminRealityCheckScreen()),
          GoRoute(path: '/admin/role-screen-carousel', builder: (context, state) => const AdminRoleCarouselScreen()),
          GoRoute(path: '/admin/screenshot-gallery', builder: (context, state) => const AdminScreenshotGalleryScreen()),
          GoRoute(path: '/generated/audit-dashboard', builder: (context, state) => const AuditDashboardScreen()),
          GoRoute(path: '/generated/compliance-reviews', builder: (context, state) => const ComplianceReviewsScreen()),
          GoRoute(path: '/generated/incident-reports', builder: (context, state) => const IncidentReportsScreen()),
          GoRoute(path: '/generated/quality-metrics', builder: (context, state) => const QualityMetricsScreen()),
          GoRoute(path: '/governance/audit', builder: (context, state) => const AuditLogScreen()),
          GoRoute(path: '/governance/monitoring', builder: (context, state) => const MonitoringScreen()),
          GoRoute(path: '/governance/tickets', builder: (context, state) => const TicketCenterScreen()),
          GoRoute(path: '/governance/screen-status', builder: (context, state) => const ScreenStatusScreen()),
          GoRoute(path: '/governance/device-security', builder: (context, state) => const SecurityHubScreen()),
          GoRoute(path: '/governance/security', builder: (context, state) => const SecuritySentinelScreen()),
          GoRoute(path: '/verification', builder: (context, state) => const VerificationCenterScreen()),
          GoRoute(path: '/governance/clinical-reference', builder: (context, state) => const ClinicalReferenceScreen()),

          // Native Executive Routes
          GoRoute(path: '/generated/corporate/ceo/growth-pipeline', builder: (context, state) => const GrowthPipelineScreen()),
          GoRoute(path: '/generated/corporate/ceo/region-performance', builder: (context, state) => const RegionalPerformanceScreen()),
          GoRoute(path: '/generated/corporate/ceo/leadership-reports', builder: (context, state) => const LeadershipReportsScreen()),
          GoRoute(path: '/governance/hud', builder: (context, state) => const GovernanceHudScreen()),
          GoRoute(path: '/governance/control-center', builder: (context, state) => const ControlCenterScreen()),
          GoRoute(path: '/proposals', builder: (context, state) => const ProposalsScreen()),

          // Dynamic Registry-Driven Routes
          ...ScreenRegistry.screens.values
              .where((screen) => screen.routePath.isNotEmpty && !['LOGIN', 'FORGOT_PASSWORD', 'MFA', 'RESET_PASSWORD'].contains(screen.id))
              .map((screen) {
            return GoRoute(
              path: screen.routePath,
              builder: (context, state) {
                // In governance-only mode, all screens except LOGIN use DynamicScreenView
                // to show implementation status and audit metadata.
                return DynamicScreenView(metadata: screen);
              },
            );
          }),
          // Fallback route to ensure ShellRoute is never empty
          // This prevents the 'routes.isNotEmpty' assertion failure in go_router
          GoRoute(
            path: '/governance/placeholder',
            builder: (context, state) => const Scaffold(
              body: Center(child: Text('Initializing Registry...')),
            ),
          ),
        ],
      ),
    ],
  );
});
