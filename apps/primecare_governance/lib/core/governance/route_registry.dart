import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart' hide ScreenRegistry;
import 'screen_registry.dart';
import '../ui/dynamic_screen_view.dart';
import '../ui/language_selector.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    refreshListenable: authListenable,
    redirect: (context, state) {
      final isAuth = ref.read(authProvider).isAuthenticated;
      final isLoggingIn = state.matchedLocation == '/login' || state.matchedLocation == '/';
      
      if (!isAuth && !isLoggingIn) return '/login';
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
        path: ScreenRegistry.getById('LOGIN')?.routePath ?? '/login',
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: ScreenRegistry.getById('FORGOT_PASSWORD')?.routePath ?? '/forgot-password',
        builder: (context, state) => const ForgotPasswordView(),
      ),
      GoRoute(
        path: ScreenRegistry.getById('MFA')?.routePath ?? '/mfa',
        builder: (context, state) => const MfaView(),
      ),
      GoRoute(
        path: ScreenRegistry.getById('RESET_PASSWORD')?.routePath ?? '/reset-password',
        builder: (context, state) => const ResetPasswordView(),
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
          ...ScreenRegistry.screens.values
              .where((screen) => !['LOGIN', 'FORGOT_PASSWORD', 'MFA', 'RESET_PASSWORD'].contains(screen.id))
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
