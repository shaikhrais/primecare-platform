import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart' hide ScreenRegistry;
import 'screen_registry.dart';
import '../ui/dynamic_screen_view.dart';
import '../../features/auth/login_view.dart';
import '../ui/language_selector.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
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
              .where((screen) => screen.id != 'LOGIN')
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
          if (ScreenRegistry.screens.isEmpty)
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
