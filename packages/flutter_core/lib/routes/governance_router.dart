// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/domain_governance.dart';
import '../registry/platform_role.dart';
import '../registry/widgets/governance_master_layout.dart';

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
  }) {
    // 1. Determine authorized modules
    final authorizedModules = application.getAuthorizedModules(activeRole);

    // 2. Extract authorized screens
    final authorizedRoutes = <GoRoute>[];
    for (final module in authorizedModules) {
      for (final screen in module.screens) {
        // Enforce per-screen role verification
        if (screen.requiredRole == null || screen.requiredRole == activeRole) {
          authorizedRoutes.add(
            GoRoute(
              path: screen.route,
              builder: (context, state) => screen.build(context),
            ),
          );
        }
      }
    }

    // 3. Build GoRouter with strict shell
    return GoRouter(
      initialLocation: initialLocation,
      refreshListenable: refreshListenable,
      redirect: redirect,
      routes: [
        ShellRoute(
          builder: (context, state, child) => GovernanceMasterLayout(
            application: application,
            activeRole: activeRole,
            child: child,
          ),
          routes: authorizedRoutes,
        ),
      ],
      errorBuilder: (context, state) => GovernanceMasterLayout(
        application: application,
        activeRole: activeRole,
        child: Scaffold(
          appBar: AppBar(title: Text(tr('governance.access_denied'))),
          body: Center(
            child: Text(
              tr('governance.unauthorized_route_message'),
              style: const TextStyle(color: Colors.red, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
