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
      static final Map<String, List<String>> _defaultRolePermissions = {
    'admin': ['/offices/franchise', '/common', '/offices/support', '/dynamic', '/roles', '/offices/governance', '/clinic', '/offices/clinical'],
    'billing_admin': ['/offices/franchise', '/common'],
    'bus_dev': ['/common', '/offices/business_development', '/offices', '/offices/corporate'],
    'caregiver': ['/offices/clinical', '/clinic', '/common', '/dynamic', '/offices'],
    'ceo': ['/offices/corporate', '/common', '/executive', '/offices'],
    'cfo': ['/offices/corporate', '/common', '/executive', '/offices'],
    'chiro': ['/offices/clinical', '/clinic', '/common', '/dynamic'],
    'chiropractor': ['/offices/clinical', '/clinic', '/common', '/dynamic', '/offices'],
    'ciso': ['/executive', '/common', '/offices/corporate', '/offices'],
    'client': ['/offices/client', '/common'],
    'clinic': ['/offices/clinical', '/clinic', '/common', '/dynamic'],
    'clinical_director': ['/offices', '/common', '/offices/clinical', '/clinic', '/dynamic'],
    'clinicaldirector': ['/offices/clinical', '/clinic', '/common', '/dynamic'],
    'cns': ['/offices/clinical', '/clinic', '/common', '/dynamic', '/clinical'],
    'community_outreach': ['/management', '/common', '/offices/marketing', '/offices'],
    'compliance': ['/management', '/common', '/offices/governance', '/offices', '/offices/corporate'],
    'compliance_manager': ['/offices/corporate', '/common'],
    'coo': ['/offices/corporate', '/common', '/executive', '/offices'],
    'coordinator': ['/offices/franchise', '/common'],
    'corporate_developer': ['/offices/corporate', '/common'],
    'cto': ['/offices/corporate', '/common', '/offices'],
    'customer_support': ['/offices/support', '/offices/clinical', '/dynamic', '/common', '/offices'],
    'cx_director': ['/executive', '/common', '/offices/corporate', '/offices'],
    'dynamic': ['/common', '/offices/support', '/dynamic', '/roles', '/offices/governance'],
    'employee': ['/staff', '/common', '/offices/support', '/dynamic', '/roles', '/offices/governance'],
    'family': ['/offices/client', '/common', '/offices'],
    'finance_director': ['/offices/corporate', '/common', '/executive', '/offices'],
    'founder': ['/offices/corporate', '/common'],
    'franchise_owner': ['/offices/franchise', '/common'],
    'franchise_sales': ['/management', '/common', '/offices/franchise', '/offices', '/offices/business_development'],
    'franchise_sales_manager': ['/offices/business_development', '/common'],
    'general_manager': ['/offices/business_development', '/common'],
    'gm': ['/management', '/common', '/offices/support', '/dynamic', '/offices', '/offices/business_development'],
    'governance': ['/common', '/offices/governance', '/roles'],
    'guest': ['/common', '/offices/client', '/offices'],
    'head_of_bus_dev': ['/offices/corporate', '/common'],
    'head_of_marketing': ['/offices/corporate', '/common'],
    'hr_director': ['/executive', '/common', '/offices/corporate', '/offices'],
    'hr_hiring': ['/offices/franchise', '/common', '/staff', '/offices/support', '/dynamic', '/offices'],
    'hsw': ['/offices/clinical', '/clinic', '/common', '/dynamic', '/clinical'],
    'infrastructure': ['/common', '/offices/governance', '/roles'],
    'intake': ['/offices/support', '/offices/clinical', '/dynamic', '/common', '/offices', '/clinic'],
    'intake_coordinator': ['/offices/support', '/offices/clinical', '/dynamic', '/common'],
    'intakecoordinator': ['/offices/support', '/offices/clinical', '/dynamic', '/common'],
    'legal': ['/executive', '/common', '/offices/corporate', '/offices'],
    'local_marketing': ['/offices/marketing', '/common', '/management', '/offices'],
    'lpn': ['/offices/clinical', '/clinic', '/clinical', '/common', '/dynamic', '/rpn'],
    'marketing': ['/management', '/common', '/offices/marketing', '/offices', '/offices/corporate'],
    'np': ['/offices/clinical', '/clinic', '/clinical', '/common', '/dynamic', '/rn', '/management'],
    'operations_manager': ['/offices/franchise', '/common'],
    'ops_manager': ['/management', '/common', '/offices/support', '/dynamic', '/offices', '/offices/franchise'],
    'outreach': ['/offices/marketing', '/common'],
    'owner': ['/common', '/offices/franchise', '/offices'],
    'partnership': ['/management', '/common', '/offices/business_development', '/offices'],
    'partnership_manager': ['/offices/business_development', '/common'],
    'patient': ['/common', '/offices/client', '/offices'],
    'pediatric': ['/offices/clinical', '/clinic', '/clinical', '/common', '/dynamic'],
    'physician': ['/offices/clinical', '/clinic', '/clinical', '/common', '/dynamic'],
    'physio': ['/offices/clinical', '/clinic', '/common', '/dynamic', '/offices'],
    'physiotherapist': ['/offices/clinical', '/clinic', '/common', '/dynamic'],
    'portal': ['/common', '/offices/client', '/offices'],
    'premium_concierge': ['/management', '/common', '/offices/support', '/dynamic'],
    'psw': ['/offices/clinical', '/clinic', '/common', '/dynamic', '/debug', '/offices'],
    'qa_specialist': ['/offices/clinical', '/clinic', '/common', '/dynamic', '/offices/support', '/offices'],
    'quality_assurance': ['/offices/support', '/offices/clinical', '/dynamic', '/common'],
    'qualityassurance': ['/offices/support', '/offices/clinical', '/dynamic', '/common'],
    'receptionist': ['/offices/support', '/offices/clinical', '/dynamic', '/common'],
    'regional_bdm': ['/management', '/common', '/offices/business_development', '/offices'],
    'regional_manager_ontario': ['/offices/business_development', '/common'],
    'regional_manager_usa': ['/offices/business_development', '/common', '/management', '/offices/support', '/dynamic', '/offices'],
    'rmt': ['/offices/clinical', '/clinic', '/common', '/dynamic', '/offices'],
    'rn': ['/offices/clinical', '/clinic', '/common', '/dynamic', '/rn', '/management', '/offices'],
    'rn_field_supervisor': ['/rn', '/common', '/offices/clinical', '/clinic', '/dynamic'],
    'rpn': ['/offices/clinical', '/clinic', '/common', '/dynamic', '/rpn', '/offices'],
    'scheduler': ['/offices/franchise', '/offices/clinical', '/common', '/staff', '/offices/support', '/dynamic', '/offices'],
    'scrum_master': ['/management', '/common', '/offices/support', '/dynamic', '/roles', '/offices/governance'],
    'shareholder': ['/executive', '/common', '/offices/corporate', '/offices'],
    'social_worker': ['/offices/clinical', '/clinic', '/common', '/dynamic', '/offices'],
    'system_verification': ['/common', '/offices/governance', '/roles'],
    'territory_expansion': ['/management', '/common', '/offices/business_development', '/offices'],
    'territory_expansion_manager': ['/offices/business_development', '/common'],
    'territory_sales': ['/offices/marketing', '/common', '/management', '/offices/business_development', '/offices'],
    'therapist': ['/offices/clinical', '/clinic', '/common', '/dynamic', '/offices'],
    'training': ['/common', '/offices/governance', '/roles'],
    'training_coordinator': ['/offices/support', '/offices/clinical', '/dynamic', '/common', '/staff', '/offices/governance', '/roles'],
    'training_director': ['/offices/corporate', '/common', '/offices'],
    'trainingcoordinator': ['/offices/support', '/offices/clinical', '/dynamic', '/common'],
    'vip_manager': ['/offices/clinical', '/clinic', '/common', '/dynamic', '/management', '/offices/support'],
    'volunteer': ['/staff', '/common', '/offices/support', '/dynamic', '/roles', '/offices/governance'],
    'volunteer_coordinator': ['/staff', '/common', '/offices/support', '/dynamic', '/offices', '/offices/corporate'],
  };

  static Map<String, List<String>> _rolePermissions = Map.from(
    _defaultRolePermissions,
  );

  static Map<String, List<String>> get defaultPermissions =>
      _defaultRolePermissions;

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
        requestedRoute == CommonRoutes.authCallback ||
        requestedRoute == CommonRoutes.language ||
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
          externalRedirectUrl:
              '$ssoPortalUrl/login?redirect_uri=$redirectUri&force_login=true',
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
          externalRedirectUrl:
              '$ssoPortalUrl/login?redirect_uri=$redirectUri&force_login=true',
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
    if (_rolePermissions.containsKey(normalizedRole)) {
      allowedPrefixes = _rolePermissions[normalizedRole]!;
    } else {
      for (final role in _rolePermissions.keys) {
        if (normalizedRole.contains(role)) {
          allowedPrefixes = _rolePermissions[role]!;
          break;
        }
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
