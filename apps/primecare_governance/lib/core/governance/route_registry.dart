import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart' hide ScreenRegistry;
import 'screen_registry.dart';
import '../../features/system_governance/sidebar_mapping/role_sidebar_mapping_view.dart';
import '../ui/dynamic_screen_view.dart';
import '../ui/app_drawer.dart';
import '../../features/auth/login_view.dart';
import '../ui/language_selector.dart';
import '../../features/system_governance/screen_status_dashboard/screen_status_view.dart';
import '../../features/governance_dashboard/governance_dashboard_view.dart';
import '../../features/system_governance/monitoring/system_monitoring_view.dart';
import '../../features/clinical_reference/clinical_reference_view.dart';
import '../../features/clinical_reference/widgets/clinical_reference_drawer.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation:
        ScreenRegistry.getById('SCREEN_STATUS_DASHBOARD')?.routePath ??
        '/governance/screen-status',
    routes: [
      GoRoute(
        path: ScreenRegistry.getById('LOGIN')?.routePath ?? '/login',
        builder: (context, state) => const LoginView(),
      ),
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

          return MasterLayout(
            title: title,
            shellType: AppShellType.admin,
            drawer: const AppDrawer(),
            endDrawer: const ClinicalReferenceDrawer(),
            actions: [
              const LanguageSelector(),
              const SizedBox(width: 8),
              Builder(
                builder: (context) => IconButton(
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
            child: child,
          );
        },
        routes: [
          // Dynamic Registry-Driven Routes
          ...ScreenRegistry.screens.values.map((screen) {
            return GoRoute(
              path: screen.routePath,
              builder: (context, state) {
                // If not completed, show the Governance Status preview
                if (screen.lifecycleStatus != LifecycleStatus.completed) {
                  return DynamicScreenView(metadata: screen);
                }

                // Route to actual implementation if completed
                switch (screen.id) {
                  case 'SCREEN_STATUS_DASHBOARD':
                    return const ScreenStatusView();
                  case 'GOVERNANCE_DASHBOARD':
                  case 'SYSTEM_GOVERNANCE_DASHBOARD':
                    return const GovernanceDashboardView();
                  case 'MONITORING':
                    return const SystemMonitoringView();
                  case 'SIDEBAR_MAPPING':
                    return const RoleSidebarMappingView();
                  case 'CLINICAL_REFERENCE':
                    return const ClinicalReferenceView();
                  case 'DEBUG_THEME':
                  case 'DEBUG_KITCHEN_SINK':
                    return DynamicScreenView(metadata: screen);
                  default:
                    return DynamicScreenView(metadata: screen);
                }
              },
            );
          }),
        ],
      ),
    ],
  );
});
