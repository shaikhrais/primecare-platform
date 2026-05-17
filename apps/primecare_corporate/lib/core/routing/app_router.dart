import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter/foundation.dart';

import 'corporate_routes.dart';

final corporateApplicationProvider = Provider<CorporateApplication>((ref) {
  return CorporateApplication();
});

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);
  final application = ref.watch(corporateApplicationProvider);

  // Override the platformApplicationProvider with our concrete instance
  // This allows MasterLayout (in primecare_ui) to find the correct application metadata
  // Note: In a real app, you might do this in the root ProviderScope, 
  // but doing it here ensures the router and the layout stay in sync.
  ref.onDispose(() {}); // Dummy for now

  // Provide a safe fallback role for public/unauthenticated access
  final activeRole = authState.isAuthenticated
      ? PlatformRole.fromName(authState.role)
      : PlatformRole.guest;

  return GovernanceRouter.buildZeroTrustRouter(
    application: application,
    activeRole: activeRole,
    initialLocation: activeRole == PlatformRole.guest
        ? CommonRoutes.login
        : AuthNotifier.getDashboardRouteForRole(authState.role ?? ''),
    refreshListenable: authListenable,
    redirect: (context, state) {
      final requestedRoute = state.uri.toString();

      // Ensure SSO Portal URL is configured
      RouteGuard.ssoPortalUrl ??= const String.fromEnvironment('SSO_PORTAL_URL', defaultValue: 'http://localhost:3000');

      final result = RouteGuard.verify(
        requestedRoute: requestedRoute,
        isLoggedIn: authState.isAuthenticated,
        userRole: authState.role,
      );

      if (!result.isAllowed) {
        if (result.externalRedirectUrl != null) {
          return '${CommonRoutes.ssoRedirect}?url=${Uri.encodeComponent(result.externalRedirectUrl!)}';
        }
        return result.redirectRoute;
      }

      final isAtLanding =
          requestedRoute == '/' || requestedRoute == CommonRoutes.login;

      if (authState.isAuthenticated && isAtLanding) {
        final role = authState.role ?? '';
        final destination = AuthNotifier.getDashboardRouteForRole(role);
        return destination;
      }

      return null;
    },
    publicRoutes: [
      GoRoute(
        path: CommonRoutes.ssoRedirect,
        builder: (context, state) {
          final url = state.uri.queryParameters['url'] ?? 'http://localhost:3000';
          return SsoRedirectView(redirectUrl: url);
        },
      ),
      GoRoute(
        path: CommonRoutes.login,
        redirect: (context, state) {
          RouteGuard.ssoPortalUrl ??= const String.fromEnvironment('SSO_PORTAL_URL', defaultValue: 'http://localhost:3000');
          final defaultRedirectUri = const String.fromEnvironment('APP_BASE_URL', defaultValue: 'http://localhost:3002');
          final redirectUri = kIsWeb ? defaultRedirectUri : 'primecare://auth/callback';
          final target = '${RouteGuard.ssoPortalUrl}/login?redirect_uri=${Uri.encodeComponent(redirectUri)}';
          return '${CommonRoutes.ssoRedirect}?url=${Uri.encodeComponent(target)}';
        },
      ),
    ],
  );
});
