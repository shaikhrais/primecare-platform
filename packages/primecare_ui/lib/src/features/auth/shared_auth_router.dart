// Shared in-app authentication routing for every governed PrimeCare app.
import 'package:flutter_core/flutter_core.dart';
import 'package:go_router/go_router.dart';
import 'login_view.dart';
import '../maintenance/maintenance_configuration_screen.dart';
import '../workspace/governed_workspace_screen.dart';
import '../workspace/workspace_routes_generated.dart';
import 'auth_experience.dart';
import 'language_selection_view.dart';
import 'forgot_password_view.dart';
import 'reset_password_view.dart';
import 'mfa_view.dart';
import 'signup_access_view.dart';
import 'shared_account/consent/consent_screen.dart' as consent;
import 'shared_account/success_profile/success_profile_screen.dart' as account;

class SharedAuthRouter {
  static GoRouter build({
    required Ref ref,
    required PlatformApplication application,
    required PlatformRole activeRole,
    List<GoRoute> additionalPublicRoutes = const [],
  }) {
    final auth = ref.watch(authProvider);
    final workspaceRoutes = governedWorkspaceRoleRoutes[auth.role] ?? const <String>[];
    final dashboard = auth.isAuthenticated && auth.role == 'maintenance' ? '/maintenance/configuration' : !auth.isAuthenticated
        ? CommonRoutes.login
        : governedWorkspaceLandings[auth.role] ?? application.getDefinition(activeRole)?.dashboardRoute ??
            AuthNotifier.getDashboardRouteForRole(auth.role ?? '');
    return GovernanceRouter.buildZeroTrustRouter(
      application: application,
      activeRole: activeRole,
      initialLocation: dashboard,
      refreshListenable: authListenable,
      additionalGovernedRoutes: workspaceRoutes,
      governedScreenBuilder: (context, state) => GovernedWorkspaceScreen(route: state.uri.path),
      guestErrorBuilder: (context, state) => const AppShellBoundary(
        child: LoginView(),
      ),
      redirect: (context, state) {
        final session = ref.read(authProvider);
        if (!session.isInitialized) return null;
        final path = state.uri.path;
        final landing = path == '/' ||
            path == CommonRoutes.login ||
            path == CommonRoutes.authCallback;
        if (path == '/maintenance/configuration') {
          if (!session.isAuthenticated) return '/login?returnUrl=/maintenance/configuration';
          return ['ceo', 'maintenance'].contains(session.role) ? null : '/success';
        }
        if (session.isAuthenticated && landing) {
          final target = validateAppReturnUrl(
            state.uri.queryParameters['returnUrl'],
          );
          if (target != null &&
              RouteGuard.verify(
                requestedRoute: Uri.parse(target).path,
                isLoggedIn: true,
                userRole: session.role,
              ).isAllowed) {
            return target;
          }
          return dashboard;
        }
        if (session.isAuthenticated && (path == '/consent' || path == '/success')) return null;
        if (path == CommonRoutes.authCallback) return CommonRoutes.login;
        if (path == CommonRoutes.login ||
            path == CommonRoutes.language ||
            path == CommonRoutes.ssoRedirect ||
            path == CommonRoutes.authError ||
            path == CommonRoutes.signup ||
            path == CommonRoutes.forgotPassword ||
            path == '/reset-password' ||
            path == '/mfa') {
          return null;
        }
        if (!session.isAuthenticated) {
          return Uri(
            path: CommonRoutes.login,
            queryParameters: {'returnUrl': state.uri.toString()},
          ).toString();
        }
        final result = RouteGuard.verify(
          requestedRoute: path,
          isLoggedIn: true,
          userRole: session.role,
        );
        return result.isAllowed || workspaceRoutes.contains(path)
            ? null
            : result.redirectRoute ?? CommonRoutes.globalSettings;
      },
      publicRoutes: [
        GoRoute(path: '/maintenance/configuration', builder: (context, state) => const AppShellBoundary(child: MaintenanceConfigurationScreen())),
        ...SharedAuthRoutes.routes(),
        ...SharedAuthRoutes.protectedRoutes(),
        ...additionalPublicRoutes,
      ],
    );
  }
}

class SharedAuthRoutes {
  static const publicPaths = <String>{
    '/login', '/signup', '/forgot-password', '/reset-password', '/mfa',
    '/language', '/sso-redirect', '/auth/error',
  };

  static List<GoRoute> protectedRoutes() => [
    GoRoute(path: '/consent', builder: (context, state) => const AppShellBoundary(
      child: consent.ConsentScreen(redirectUri: ''))),
    GoRoute(path: '/success', builder: (context, state) => const AppShellBoundary(
      child: account.SuccessProfileScreen())),
  ];

  static List<GoRoute> routes() => [
        GoRoute(path: CommonRoutes.authError,
          builder: (context, state) => const AppShellBoundary(child: PrimeAuthExperience(page: AuthPage.error))),
        GoRoute(
          path: CommonRoutes.login,
          builder: (context, state) => const AppShellBoundary(
            child: LoginView(),
          ),
        ),
        GoRoute(path: CommonRoutes.signup,
          builder: (context, state) => const AppShellBoundary(child: SignUpAccessView())),
        GoRoute(path: CommonRoutes.forgotPassword,
          builder: (context, state) => const AppShellBoundary(child: ForgotPasswordView())),
        GoRoute(path: '/reset-password',
          builder: (context, state) => const AppShellBoundary(child: ResetPasswordView())),
        GoRoute(path: '/mfa',
          builder: (context, state) => const AppShellBoundary(child: MfaView())),
        GoRoute(
          path: CommonRoutes.language,
          builder: (context, state) => const AppShellBoundary(
            child: LanguageSelectionView(),
          ),
        ),
        GoRoute(
          path: CommonRoutes.ssoRedirect,
          redirect: (context, state) {
            final target = validateAppReturnUrl(
              state.uri.queryParameters['returnUrl'] ??
                  state.uri.queryParameters['target'],
            );
            return Uri(
              path: CommonRoutes.login,
              queryParameters: {if (target != null) 'returnUrl': target},
            ).toString();
          },
        ),
  ];
}
