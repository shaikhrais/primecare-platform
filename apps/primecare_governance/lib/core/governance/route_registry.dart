// Governance - Category: middleware | Purpose: Routing definition mapping client endpoints, paths, layouts, and access guards.
import 'package:primecare_ui/primecare_ui.dart' show PrimeIconButton;
import 'package:go_router/go_router.dart';
import 'package:flutter_core/src/network/api_client.dart';
import 'governance_route_access.dart';
import 'native_application_access.dart';
import 'package:primecare_ui/src/features/tenant_applications/tenant_application_screen.dart';
import 'package:primecare_ui/src/features/tenant_applications/tenant_application_catalog.g.dart' show nativeTenantApplicationRoute;
import 'package:primecare_ui/src/features/workspace/governed_workspace_screen.dart';
import 'package:primecare_ui/src/features/workspace/workspace_routes_generated.dart';
import 'package:flutter_core/models/screen_manager.dart';
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

// Presentation registrations only. The router's redirect remains responsible
// for authentication and exact server-filtered route grants. APIs retain data authorization.
const governanceNativeScreenRoutes = <String>{
  nativeTenantApplicationRoute,
  '/admin/screen-health', '/admin/reality-check', '/admin/role-screen-carousel',
  '/admin/screenshot-gallery', '/generated/audit-dashboard',
  '/generated/compliance-reviews', '/generated/incident-reports',
  '/generated/quality-metrics', '/governance/audit', '/governance/monitoring',
  '/governance/tickets', '/governance/screen-status', '/governance/device-security',
  '/governance/security', '/verification', '/governance/clinical-reference',
  '/generated/corporate/ceo/growth-pipeline',
  '/generated/corporate/ceo/region-performance',
  '/generated/corporate/ceo/leadership-reports', '/governance/hud',
  '/governance/control-center', '/proposals', '/governance/placeholder',
};

// Existing governance-only registry paths absent from the shared presentation
// catalogs. Keep this explicit: newly loaded metadata must not register itself.
// These entries preserve rendering only; they do not supply role/API grants.
const governanceRegistryScreenRoutes = <String>{
  '/reconciled/screen_common_dashboard_labels',
  '/roles/customer_support/dashboard',
  '/roles/family_member/dashboard',
  '/roles/guest/dashboard',
  '/roles/patient/dashboard',
  '/roles/portal/dashboard',
  '/roles/premium_concierge/dashboard',
  '/roles/vip_manager/dashboard',
};

ScreenManager buildGovernanceScreenManager() =>
    primeCareScreenManager.withAdditionalRoutes([
      ...governanceNativeScreenRoutes,
      ...governanceRegistryScreenRoutes,
    ]);

final appRouterProvider = Provider<GoRouter>((ref) {
  final screenManager = buildGovernanceScreenManager();
  final existingPaths = {
    ...governanceNativeScreenRoutes,
    ...ScreenRegistry.screens.values.map((screen) => screen.routePath),
    ...SharedAuthRoutes.publicPaths,
    CommonRoutes.authCallback, '/consent', '/success', '/',
  };
  // Reuse exact generated workspace paths, not aliases for legacy native paths.
  // Registration supplies presentation only; the redirect still requires the
  // authenticated server projection for every navigation.
  final workspacePaths = governedWorkspaceRoutes.keys
      .where((path) => !existingPaths.contains(path)).toSet();
  final sessionRefresh = ValueNotifier<int>(0);
  ref.listen(authProvider.select((session) => (session.isAuthenticated,
      session.userId, session.tenantId, session.token, session.role)),
      (previous, next) {sessionRefresh.value++;});
  ref.onDispose(sessionRefresh.dispose);
  return GoRouter(
    initialLocation: '/login',
    // Unknown deep links must not enter the global error/restart loop.
    onException: (context, state, router) {
      router.go(ref.read(authProvider).isAuthenticated
          ? CommonRoutes.authError
          : CommonRoutes.login);
    },
    refreshListenable: Listenable.merge([authListenable, sessionRefresh]),
    redirect: (context, state) async {
      final session = ref.read(authProvider);
      if (!session.isInitialized) {
        return SharedAuthRoutes.publicPaths.contains(state.uri.path)
            ? null
            : CommonRoutes.login;
      }
      if (!session.isAuthenticated && state.uri.path == CommonRoutes.authCallback) {
        return CommonRoutes.login;
      }
      final nativeEntry = state.uri.path == nativeTenantApplicationRoute;
      final nativeLanding = session.isAuthenticated && session.role == 'tenant_admin' &&
          {'/', '/login', '/auth/callback'}.contains(state.uri.path);
      if (nativeEntry || nativeLanding) {
        if (!session.isAuthenticated) return '/login';
        final captured = (session.userId, session.tenantId, session.token, session.role);
        bool current() {
          try {
            if (!ref.mounted) return false;
            final latest = ref.read(authProvider);
            return latest.isAuthenticated &&
                (latest.userId, latest.tenantId, latest.token, latest.role) == captured;
          } catch (_) { return false; }
        }
        if (captured.$3 == null || captured.$3!.isEmpty) return CommonRoutes.authError;
        final allowed = await authorizeNativeApplicationRoute(
          userId: captured.$1, tenantId: captured.$2, role: captured.$4,
          isCurrent: current, loadDashboard: () async {
            final response = await ref.read(apiClientProvider).get(
              '/v1/governance/tenant-dashboard', queryParameters: {'dataset': 'live'});
            return response.statusCode == 200 ? response.data : null;
          });
        return allowed ? (nativeLanding ? nativeTenantApplicationRoute : null) : CommonRoutes.authError;
      }
      final isAuth = session.isAuthenticated;
      final isLoggingIn = state.matchedLocation == '/login' || 
                          state.matchedLocation == '/' ||
                          state.matchedLocation == '/auth/callback';
      
      if (!isAuth && !isLoggingIn &&
          !SharedAuthRoutes.publicPaths.contains(state.uri.path)) return '/login';
      if (isAuth && (isLoggingIn ||
          (!SharedAuthRoutes.publicPaths.contains(state.uri.path) &&
           !{'/consent', '/success'}.contains(state.uri.path)))) {
        final scope = (session.userId, session.tenantId, session.token, session.role);
        bool current() {
          final latest = ref.read(authProvider);
          return latest.isAuthenticated &&
              (latest.userId, latest.tenantId, latest.token, latest.role) == scope;
        }
        if (scope.$1 == null || scope.$1!.isEmpty || scope.$2 == null ||
            scope.$2!.isEmpty || scope.$3 == null || scope.$3!.isEmpty ||
            scope.$4 == null || scope.$4!.isEmpty) return CommonRoutes.authError;
        final destination = await authorizeGovernanceRoute(
          path: state.fullPath ?? state.uri.path,
          landing: isLoggingIn,
          userId: scope.$1!, role: scope.$4!,
          availableRoutes: {
            ...governanceNativeScreenRoutes,
            ...workspacePaths,
            ...ScreenRegistry.screens.values.map((screen) => screen.routePath),
          }.where((path) => screenManager.lookup(path) != null).toSet(),
          isCurrent: current,
          loadWorkspace: () async {
            final response = await ref.read(apiClientProvider).get('/v1/governance/workspace');
            return response.statusCode == 200 ? response.data : null;
          },
        );
        // A changed account must never consume a response for the old session.
        if (!current()) return ref.read(authProvider).isAuthenticated
            ? CommonRoutes.authError : CommonRoutes.login;
        if (destination == null) return CommonRoutes.authError;
        return isLoggingIn ? destination : null;
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

          return PrimeScaffold(
            appBar: PrimeAppBar(
              title: PrimeText(title),
              actions: [
                const LanguageSelector(),
                const SizedBox(width: 8),
                Builder(
                  builder: (context) => PrimeIconButton(
                    key: const Key('route_registry_iconbutton_button_1'),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    icon: const PrimeIcon(LucideIcons.search),
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
            body: AppShellBoundary(child: ManagedScreenBoundary(
              manager: screenManager,
              // Use the registered route pattern for parameterized paths.
              screenId: state.fullPath ?? matchedLocation,
              builder: (_) => child,
            )),
          );
        },
        routes: [
          GoRoute(path: nativeTenantApplicationRoute, builder: (context, state) => const TenantApplicationScreen(),
            onExit:(context,state)=>canLeaveNativeApplicationTasks(ref.read(authProvider),
              (identity)=>ref.read(nativeTaskLeaveBlockProvider(identity)))),
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

          // Existing canonical workspace routes absent from the legacy registry.
          // Dedicated/auth routes are excluded by the generated catalog or above.
          ...workspacePaths.map((path) => GoRoute(
            path: path,
            builder: (context, state) => GovernedWorkspaceScreen(route: path),
          )),

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
            builder: (context, state) => const PrimeScaffold(
              body: Center(child: PrimeText('Initializing Registry...')),
            ),
          ),
        ],
      ),
    ],
  );
});
