import 'package:go_router/go_router.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

import 'clinic_routes.dart';


final clinicApplicationProvider = Provider<ClinicApplication>((ref) {
  return ClinicApplication();
});

final activeRoleProvider = Provider<PlatformRole>((ref) {
  final authState = ref.watch(authProvider);
  if (!authState.isInitialized || !authState.isAuthenticated) {
    return PlatformRole.guest;
  }
  return PlatformRole.fromName(authState.role);
});

final appRouterProvider = Provider<GoRouter>((ref) {
  final activeRole = ref.watch(activeRoleProvider);
  final application = ref.read(clinicApplicationProvider);

  final authState = ref.watch(authProvider);
  final dashboardRoute = !authState.isAuthenticated
      ? CommonRoutes.login
      : application.getDefinition(activeRole)?.dashboardRoute ??
            AuthNotifier.getDashboardRouteForRole(authState.role ?? '');

  return GovernanceRouter.buildZeroTrustRouter(
    application: application,
    activeRole: activeRole,
    initialLocation: dashboardRoute,
    refreshListenable: authListenable,
    guestErrorBuilder: (context, state) => const AppShellBoundary(
      child: LoginView(),
    ),
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      
      if (!authState.isInitialized) {
        return null;
      }

      final requestedRoute = state.uri.path;
      final requestedLocation = state.uri.toString();

      final publicRoutes = <String>{
        '/login',
        '/language',
        '/auth/callback',
        '/auth/error',
        '/sso-redirect',
        '/success',
        '/forgot-password',
        '/404',
        '/403',
        '/500',
        '/503',
        '/health',
        '/version',
      };

      if (publicRoutes.contains(requestedRoute)) {
        if (authState.isAuthenticated && (requestedRoute == '/login' || requestedRoute == '/auth/callback' || requestedRoute == '/')) {
          final target = validateClinicReturnUrl(state.uri.queryParameters['returnUrl']);
          if (target != null && RouteGuard.verify(
            requestedRoute: Uri.parse(target).path,
            isLoggedIn: true,
            userRole: authState.role,
          ).isAllowed) {
            return target;
          }
          return dashboardRoute;
        }
        return null;
      }

      if (!authState.isAuthenticated) {
        final encodedTarget = Uri.encodeQueryComponent(requestedLocation);
        return '/login?returnUrl=$encodedTarget';
      }

      // Check boundary permissions for authenticated users
      final result = RouteGuard.verify(
        requestedRoute: requestedRoute,
        isLoggedIn: authState.isAuthenticated,
        userRole: authState.role,
      );

      if (!result.isAllowed) {
        return result.redirectRoute ?? '/common/settings';
      }

      return null;
    },
    publicRoutes: [
      GoRoute(
        path: CommonRoutes.ssoRedirect,
        redirect: (context, state) => Uri(
          path: CommonRoutes.login,
          queryParameters: {
            if (validateClinicReturnUrl(state.uri.queryParameters['returnUrl'] ??
                state.uri.queryParameters['target']) case final String target)
              'returnUrl': target,
          },
        ).toString(),
      ),
      GoRoute(
        path: CommonRoutes.language,
        builder: (context, state) => const AppShellBoundary(
          child: LanguageSelectionView(),
        ),
      ),
      GoRoute(
        path: CommonRoutes.login,
        builder: (context, state) => const AppShellBoundary(
          child: LoginView(),
        ),
      ),
      GoRoute(
        path: CommonRoutes.globalSettings,
        builder: (context, state) => const AppShellBoundary(
          child: GlobalSettingsScreen(),
        ),
      ),
      GoRoute(
        path: CommonRoutes.authError,
        builder: (context, state) => AppShellBoundary(
          child: AuthErrorView(
            returnUrl: state.uri.queryParameters['returnUrl'],
          ),
        ),
      ),
    ],
  );
});
