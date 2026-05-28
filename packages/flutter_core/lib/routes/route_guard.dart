// Governance - Category: middleware | Purpose: Layer: 01_INFRASTRUCTURE Represents the decision of the RouteGuard for a given navigation event. A centralized Guard ...
// Layer: 01_INFRASTRUCTURE
import 'package:flutter/foundation.dart';
import 'package:flutter_core/routes/groups/common_routes.dart';

/// Represents the decision of the RouteGuard for a given navigation event.
class GuardResult {
  final bool isAllowed;
  final String? redirectRoute;
  final String? externalRedirectUrl;

  GuardResult(this.isAllowed, {this.redirectRoute, this.externalRedirectUrl});
}

/// A centralized Guard Mechanism Layer that validates navigation BEFORE screen loads.
class RouteGuard {
  /// Base URL for the Centralized SSO Portal (e.g., https://auth.primecare.com)
  /// If set, unauthenticated users will be redirected here via [externalRedirectUrl].
  static String? ssoPortalUrl;
  /// Maps a user role to a list of allowed route prefixes.
  /// This acts as our centralized permissions map.
  static Map<String, List<String>> _rolePermissions = {
    // Corporate Leadership
    'ceo': ['/offices/corporate', '/common'],
    'founder': ['/offices/corporate', '/common'],
    'coo': ['/offices/corporate', '/common'],
    'cfo': ['/offices/corporate', '/common'],
    'cto': ['/offices/corporate', '/common'],
    'compliance_manager': ['/offices/corporate', '/common'],
    'corporate_developer': ['/offices/corporate', '/common'],
    'finance_director': ['/offices/corporate', '/common'],
    'head_of_bus_dev': ['/offices/corporate', '/common'],
    'head_of_marketing': ['/offices/corporate', '/common'],
    'training_director': ['/offices/corporate', '/common'],

    // Business Development
    'regional_manager_ontario': ['/offices/business_development', '/common'],
    'regional_manager_usa': ['/offices/business_development', '/common'],
    'franchise_sales_manager': ['/offices/business_development', '/common'],
    'partnership_manager': ['/offices/business_development', '/common'],
    'territory_expansion_manager': ['/offices/business_development', '/common'],
    'general_manager': ['/offices/business_development', '/common'],

    // Franchise Tier
    'franchise_owner': ['/offices/franchise', '/common'],
    'operations_manager': ['/offices/franchise', '/common'],
    'admin': ['/offices/franchise', '/common'],
    'billing_admin': ['/offices/franchise', '/common'],
    'hr_hiring': ['/offices/franchise', '/common'],
    'scheduler': ['/offices/franchise', '/common'],
    'coordinator': ['/offices/franchise', '/common'],

    // Clinical Execution
    'clinical_director': ['/offices/clinical', '/clinic', '/common', '/dynamic'],
    'clinicaldirector': ['/offices/clinical', '/clinic', '/common', '/dynamic'],
    'rn': ['/offices/clinical', '/clinic', '/common', '/dynamic'],
    'rpn': ['/offices/clinical', '/clinic', '/common', '/dynamic'],
    'rmt': ['/offices/clinical', '/clinic', '/common', '/dynamic'],
    'psw': ['/offices/clinical', '/clinic', '/common', '/dynamic', '/debug'],
    'physio': ['/offices/clinical', '/clinic', '/common', '/dynamic'],
    'chiro': ['/offices/clinical', '/clinic', '/common', '/dynamic'],
    'clinic': ['/offices/clinical', '/clinic', '/common', '/dynamic'],

    // Support & Institutional
    'customer_support': ['/offices/support', '/dynamic', '/common'],
    'intake_coordinator': ['/offices/support', '/dynamic', '/common'],
    'intakecoordinator': ['/offices/support', '/dynamic', '/common'],
    'quality_assurance': ['/offices/support', '/dynamic', '/common'],
    'qualityassurance': ['/offices/support', '/dynamic', '/common'],
    'receptionist': ['/offices/support', '/dynamic', '/common'],

    // Marketing & Growth
    'local_marketing': ['/offices/marketing', '/common'],
    'outreach': ['/offices/marketing', '/common'],
    'territory_sales': ['/offices/marketing', '/common'],

    // Client Side
    'client': ['/offices/client', '/common'],
    'family': ['/offices/client', '/common'],
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
        requestedRoute == CommonRoutes.ssoRedirect ||
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

    // Helper to get correct redirect URI based on platform
    String getRedirectUri(String requestedRoute) {
      if (kIsWeb) {
        // If web, we return the absolute URL (origin + path) so the SSO portal knows where to redirect back
        return Uri.parse(Uri.base.origin).resolve(requestedRoute).toString();
      } else {
        // For Windows/APK, we must use the deep link custom scheme
        return 'primecare://auth/callback?route=${Uri.encodeComponent(requestedRoute)}';
      }
    }

    // 2. Check if user is logged in
    if (!isLoggedIn) {
      _log(requestedRoute, userRole, isLoggedIn, 'Blocked (Unauthenticated)');
      
      if (ssoPortalUrl != null) {
        final redirectUri = Uri.encodeComponent(getRedirectUri(requestedRoute));
        return GuardResult(
          false, 
          externalRedirectUrl: '$ssoPortalUrl/login?redirect_uri=$redirectUri',
        );
      }
      return GuardResult(false, redirectRoute: CommonRoutes.login);
    }

    // If there is no specific specific role defined, deny access by default (Zero Trust).
    if (userRole == null || userRole.isEmpty) {
      _log(requestedRoute, userRole, isLoggedIn, 'Blocked (No Role Defined)');
      if (ssoPortalUrl != null) {
        final redirectUri = Uri.encodeComponent(getRedirectUri(requestedRoute));
        return GuardResult(
          false, 
          externalRedirectUrl: '$ssoPortalUrl/login?redirect_uri=$redirectUri',
        );
      }
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
      if (ssoPortalUrl != null) {
        final redirectUri = Uri.encodeComponent(requestedRoute);
        return GuardResult(
          false, 
          externalRedirectUrl: '$ssoPortalUrl/login?redirect_uri=$redirectUri',
        );
      }
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
