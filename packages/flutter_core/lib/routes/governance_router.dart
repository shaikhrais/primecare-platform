// Governance - Category: middleware | Purpose: Layer: 01_INFRASTRUCTURE A factory class to construct strict "Zero-Trust" routing configurations. Builds a strictly-g...
// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeText;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/domain_governance.dart';
import '../models/screen.dart' show AppShellBoundary;
import '../models/screen_manager.dart';
import '../registry/governance_registry.dart';
import '../registry/platform_role.dart';
import '../registry/widgets/governance_master_layout.dart';
import 'groups/common_routes.dart';
import 'auth_callback_view.dart';


/// A factory class to construct strict "Zero-Trust" routing configurations.
class GovernanceRouter {
  /// Builds a strictly-governed GoRouter instance.
  /// Only screens belonging to modules authorized for the [activeRole] will be physically registered.
  /// This makes navigating to unauthorized routes mathematically impossible at the routing layer.
  static GoRouter buildZeroTrustRouter({
    required PlatformApplication application,
    required PlatformRole activeRole,
    required String initialLocation,
    required ScreenManager screenManager,
    GlobalKey<NavigatorState>? navigatorKey,
    Listenable? refreshListenable,
    GoRouterRedirect? redirect,
    GoRouterWidgetBuilder? guestErrorBuilder,
    List<GoRoute> publicRoutes = const [],
    GoRouterWidgetBuilder? governedScreenBuilder,
    List<String> additionalGovernedRoutes = const [],
  }) {
    // 0. Register all screens of the application in GovernanceRegistry for domain integrity tracking
    for (final module in application.modules) {
      for (final screen in module.screens) {
        GovernanceRegistry.register(screen, role: screen.requiredRole?.nameSnake);
      }
    }

    // 1. Determine authorized modules
    final authorizedModules = activeRole == PlatformRole.guest
        ? <PlatformModule>[]
        : application.getAuthorizedModules(activeRole);

    // 2. Extract authorized screens
    final authorizedRoutes = <GoRoute>[];
    for (final module in authorizedModules) {
      for (final screen in module.screens) {
        // Enforce per-screen role verification
        if (screen.requiredRole == null || screen.requiredRole == activeRole) {
          authorizedRoutes.add(
            GoRoute(
              path: screen.route,
              builder: (context, state) => ManagedScreenBoundary(
                manager: screenManager,
                screenId: screen.route,
                builder: (context) => governedScreenBuilder == null
                    ? screen.build(context)
                    : governedScreenBuilder(context, state),
              ),
            ),
          );
        }
      }
    }

    for (final path in additionalGovernedRoutes) {
      if (!authorizedRoutes.any((route) => route.path == path) && governedScreenBuilder != null) {
        authorizedRoutes.add(GoRoute(
          path: path,
          builder: (context, state) => ManagedScreenBoundary(
            manager: screenManager,
            screenId: path,
            builder: (context) => governedScreenBuilder(context, state),
          ),
        ));
      }
    }
    if (authorizedRoutes.isEmpty) {
      final initialPath = Uri.parse(initialLocation).path;
      final fallbackPath = (initialPath == CommonRoutes.login ||
                             initialPath == CommonRoutes.authCallback ||
                             publicRoutes.any((r) => r.path == initialPath))
          ? '/unauthorized_fallback'
          : initialPath;
      authorizedRoutes.add(
        GoRoute(
          path: fallbackPath,
          builder: (context, state) => ManagedScreenBoundary(
            manager: screenManager,
            screenId: '/internal/unauthorized-fallback',
            builder: (_) => Scaffold(
              body: Center(child: PrimeText(tr('governance.unauthorized_route_message'))),
            ),
          ),
        ),
      );
    }

    // 3. Build GoRouter with strict shell
    return GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: initialLocation,
      refreshListenable: refreshListenable,
      redirect: redirect,
      routes: [
        GoRoute(
          path: CommonRoutes.authCallback,
          builder: (context, state) => AppShellBoundary(
            child: ManagedScreenBoundary(
              manager: screenManager,
              screenId: CommonRoutes.authCallback,
              builder: (_) => AuthCallbackView(queryParameters: state.uri.queryParameters),
            ),
          ),
        ),
        ...publicRoutes,
        ShellRoute(
          builder: (context, state, child) => GovernanceMasterLayout(
            application: application,
            activeRole: activeRole,
            child: child,
          ),
          routes: authorizedRoutes,
        ),
      ],
      errorBuilder: (context, state) {
        if (activeRole == PlatformRole.guest) {
          if (guestErrorBuilder != null) {
            return AppShellBoundary(child: ManagedScreenBoundary(
              manager: screenManager,
              screenId: '/internal/guest-error',
              builder: (context) => guestErrorBuilder(context, state),
            ));
          }

        }

        return GovernanceMasterLayout(
          application: application,
          activeRole: activeRole,
          child: ManagedScreenBoundary(
            manager: screenManager,
            screenId: '/internal/access-denied',
            builder: (_) => Scaffold(
            appBar: AppBar(title: PrimeText(tr('governance.access_denied'))),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimeText(
                    tr('governance.unauthorized_route_message'),
                    style: const TextStyle(color: Colors.red, fontSize: 18),
                  ),
                  if (state.error != null) ...[
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: PrimeText(
                        'Error: ${state.error}',
                        style: const TextStyle(color: Colors.orange, fontFamily: 'monospace'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            ),
          ),
        );
      },
    );
  }
}
