import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/flutter_core.dart';
import 'franchise_routes.dart';
import 'package:flutter/foundation.dart';

final franchiseApplicationProvider = Provider<FranchiseApplication>((ref) {
  return FranchiseApplication();
});

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);
  final application = ref.watch(franchiseApplicationProvider);

  // Provide a safe fallback role for public/unauthenticated access
  final activeRole = authState.isAuthenticated
      ? (PlatformRole.values.cast<PlatformRole?>().firstWhere(
              (r) => r?.name == authState.role,
              orElse: () => PlatformRole.guest,
            ) ??
            PlatformRole.guest)
      : PlatformRole.guest;

  final dashboardRoute = activeRole == PlatformRole.guest ? CommonRoutes.login : application.getDefinition(activeRole)?.dashboardRoute ?? CommonRoutes.login;

  return GovernanceRouter.buildZeroTrustRouter(
    application: application,
    activeRole: activeRole,
    initialLocation: dashboardRoute,
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

      // If allowed and trying to hit root/login while authenticated, go to dashboard
      final isAtLanding = requestedRoute == '/' || requestedRoute == CommonRoutes.login;
      if (authState.isAuthenticated && isAtLanding) {
        return dashboardRoute;
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
          // If a user hits /login directly, force them to the SSO redirect
          RouteGuard.ssoPortalUrl ??= const String.fromEnvironment('SSO_PORTAL_URL', defaultValue: 'http://localhost:3000');
          final defaultRedirectUri = const String.fromEnvironment('APP_BASE_URL', defaultValue: 'http://localhost:3005');
          final redirectUri = kIsWeb ? defaultRedirectUri : 'primecare://auth/callback';
          final target = '${RouteGuard.ssoPortalUrl}/login?redirect_uri=${Uri.encodeComponent(redirectUri)}';
          return '${CommonRoutes.ssoRedirect}?url=${Uri.encodeComponent(target)}';
        },
      ),
    ],
  );
});
