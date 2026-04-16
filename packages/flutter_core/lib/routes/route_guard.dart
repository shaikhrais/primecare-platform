import 'package:flutter/foundation.dart';
import 'package:primecare_core/routes/groups/common_routes.dart';

/// Represents the decision of the RouteGuard for a given navigation event.
class GuardResult {
  final bool isAllowed;
  final String? redirectRoute;

  GuardResult(this.isAllowed, {this.redirectRoute});
}

/// A centralized Guard Mechanism Layer that validates navigation BEFORE screen loads.
class RouteGuard {
  /// Maps a user role to a list of allowed route prefixes.
  /// This acts as our centralized permissions map.
  static Map<String, List<String>> _rolePermissions = {
    // Corporate Leadership
    'ceo': ['/corporate', '/common'],
    'founder': ['/corporate', '/common'],
    'coo': ['/corporate', '/common'],
    'cfo': ['/corporate', '/common'],
    'cto': ['/corporate', '/common'],
    'compliance_manager': ['/corporate', '/common'],
    'corporate_developer': ['/corporate', '/common'],

    // Business Development
    'regional_manager': ['/bd', '/common'],
    'franchise_sales': ['/bd', '/common'],

    // Franchise Tier
    'franchise_owner': ['/franchise', '/common'],
    'operations_manager': ['/franchise', '/common'],
    'admin': ['/franchise', '/common'],

    // Clinical Execution
    'clinical_director': ['/clinic', '/common', '/dynamic'],
    'rn': ['/clinic', '/common', '/dynamic'],
    'rpn': ['/clinic', '/common', '/dynamic'],
    'rmt': ['/clinic', '/common', '/dynamic'],
    'psw': ['/clinic', '/common', '/dynamic'],
    'physio': ['/clinic', '/common', '/dynamic'],
    'chiro': ['/clinic', '/common', '/dynamic'],

    // Support
    'customer_support': ['/support', '/dynamic', '/common'],
    'intake': ['/clinic', '/support', '/dynamic', '/common'],
    'intake_coordinator': ['/clinic', '/support', '/dynamic', '/common'],
    'receptionist': ['/dynamic', '/common'],

    // Client Side
    'client': ['/client', '/common'],
    'family': ['/client', '/common'],
  };

  /// Dynamically synchronizes permissions from the backend payload.
  static void synchronizePermissions(
    Map<String, List<String>> dynamicPermissions,
  ) {
    if (dynamicPermissions.isNotEmpty) {
      _rolePermissions = dynamicPermissions;
    }
  }

  /// Verify if the navigation to [requestedRoute] is allowed.
  /// Acts as a middleware evaluating authentication state and role boundaries.
  static GuardResult verify({
    required String requestedRoute,
    required bool isLoggedIn,
    required String? userRole,
  }) {
    // 1. Allow unconditionally public routes.
    if (requestedRoute == CommonRoutes.login ||
        requestedRoute == CommonRoutes.signup ||
        requestedRoute == CommonRoutes.forgotPassword ||
        requestedRoute == '/') {
      // If logged in and trying to hit public unauthenticated routes, redirect to dashboard.
      if (isLoggedIn) {
        // Technically, the dashboard needs resolving. In the router integration,
        // we'll handle dashboard resolution. Here we return not allowed.
        _log(
          requestedRoute,
          userRole,
          isLoggedIn,
          'Blocked (Logged in user accessing public route)',
        );
        return GuardResult(
          false,
        ); // Router should pick this up and redirect to dashboard.
      }

      _log(requestedRoute, userRole, isLoggedIn, 'Allowed (Public Route)');
      return GuardResult(true);
    }

    // 2. Check if user is logged in
    if (!isLoggedIn) {
      _log(requestedRoute, userRole, isLoggedIn, 'Blocked (Unauthenticated)');
      return GuardResult(false, redirectRoute: CommonRoutes.login);
    }

    // If there is no specific specific role defined, deny access by default (Zero Trust).
    if (userRole == null || userRole.isEmpty) {
      _log(requestedRoute, userRole, isLoggedIn, 'Blocked (No Role Defined)');
      return GuardResult(false, redirectRoute: CommonRoutes.login);
    }

    // Normalize role string (lower-cased and replacing spaces)
    final normalizedRole = userRole
        .toLowerCase()
        .replaceAll(' ', '_')
        .replaceAll('/', '_');

    // Find the closest matching role prefix list
    List<String> allowedPrefixes = [];
    for (final role in _rolePermissions.keys) {
      if (normalizedRole.contains(role)) {
        allowedPrefixes = _rolePermissions[role]!;
        break;
      }
    }

    // 3. Prevent Unauthorized Role Access
    if (allowedPrefixes.isEmpty) {
      _log(requestedRoute, userRole, isLoggedIn, 'Blocked (Role Unregistered)');
      // You can redirect to an "unauthorized" fallback screen.
      return GuardResult(false, redirectRoute: CommonRoutes.login);
    }

    // 4. Validate bounds: Does the requested route fall within allowed prefixes?
    bool isAuthorizedForRoute = false;
    for (final prefix in allowedPrefixes) {
      if (requestedRoute.startsWith(prefix)) {
        isAuthorizedForRoute = true;
        break;
      }
    }

    if (isAuthorizedForRoute) {
      _log(requestedRoute, userRole, isLoggedIn, 'Allowed');
      return GuardResult(true);
    } else {
      _log(
        requestedRoute,
        userRole,
        isLoggedIn,
        'Blocked (Unauthorized Role Boundary)',
      );
      // For cross-boundary attempts, push back to a generic safe area or fail safe.
      return GuardResult(
        false,
        redirectRoute: '/common/settings',
      ); // Or an unauthorized screen
    }
  }

  /// Internal logger
  static void _log(String route, String? role, bool isLoggedIn, String result) {
    if (kDebugMode) {
      print(
        '🛡️ [RouteGuard] Auth: $isLoggedIn | Role: ${role ?? "None"} | Target: $route => $result',
      );
    }
  }
}
