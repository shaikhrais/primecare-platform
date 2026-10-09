// Governance - Category: middleware | Purpose: Layer: 01_INFRASTRUCTURE A factory class to construct strict "Zero-Trust" routing configurations. Builds a strictly-g...
// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/domain_governance.dart';
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
              builder: governedScreenBuilder ?? ((context, state) => screen.build(context)),
            ),
          );
        }
      }
    }

    for (final path in additionalGovernedRoutes) {
      if (!authorizedRoutes.any((route) => route.path == path) && governedScreenBuilder != null) {
        authorizedRoutes.add(GoRoute(path: path, builder: governedScreenBuilder));
      }
    }
    if (authorizedRoutes.isEmpty) {
      final fallbackPath = (initialLocation == CommonRoutes.login ||
                             initialLocation == CommonRoutes.authCallback ||
                             publicRoutes.any((r) => r.path == initialLocation))
          ? '/unauthorized_fallback'
          : initialLocation;
      authorizedRoutes.add(
        GoRoute(
          path: fallbackPath,
          builder: (context, state) => Scaffold(
            body: Center(child: Text(tr('governance.unauthorized_route_message'))),
          ),
        ),
      );
    }

    // 3. Build GoRouter with strict shell
    return GoRouter(
      initialLocation: initialLocation,
      refreshListenable: refreshListenable,
      redirect: redirect,
      routes: [
        GoRoute(
          path: CommonRoutes.authCallback,
          builder: (context, state) => AuthCallbackView(
            queryParameters: state.uri.queryParameters,
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
            return guestErrorBuilder(context, state);
          }

        }

        return GovernanceMasterLayout(
          application: application,
          activeRole: activeRole,
          child: Scaffold(
            appBar: AppBar(title: Text(tr('governance.access_denied'))),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tr('governance.unauthorized_route_message'),
                    style: const TextStyle(color: Colors.red, fontSize: 18),
                  ),
                  if (state.error != null) ...[
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
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
        );
      },
    );
  }
}
