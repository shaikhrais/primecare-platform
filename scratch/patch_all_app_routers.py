import os
import re

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
APPS = [
    "primecare_business_development",
    "primecare_client",
    "primecare_corporate",
    "primecare_franchise",
    "primecare_marketing",
    "primecare_support"
]

def patch_app_router(app_name):
    filepath = os.path.join(PROJECT_ROOT, "apps", app_name, "lib", "core", "routing", "app_router.dart")
    if not os.path.exists(filepath):
        print(f"[-] File not found: {filepath}")
        return False
        
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Find the application provider name (e.g. businessDevelopmentApplicationProvider)
    prov_match = re.search(r"final\s+([a-zA-Z0-9]+Provider)\s*=\s*Provider<([a-zA-Z0-9]+)>", content)
    if not prov_match:
        print(f"[-] Could not find application provider in {app_name}")
        return False
        
    app_provider_name = prov_match.group(1)
    print(f"[+] Found provider name: {app_provider_name} for app: {app_name}")

    # We want to replace the entire appRouterProvider definition up to the 'publicRoutes:' or 'routes:' start.
    app_router_start_idx = content.find("final appRouterProvider = Provider<GoRouter>((ref) {")
    if app_router_start_idx == -1:
        print(f"[-] Could not find appRouterProvider start in {app_name}")
        return False
        
    public_routes_idx = content.find("publicRoutes:", app_router_start_idx)
    if public_routes_idx == -1:
        public_routes_idx = content.find("routes:", app_router_start_idx)
        
    if public_routes_idx == -1:
        print(f"[-] Could not find publicRoutes: or routes: in {app_name}")
        return False

    before_part = content[:app_router_start_idx]
    after_part = content[public_routes_idx:]

    new_app_router_definition = """final activeRoleProvider = Provider<PlatformRole>((ref) {
  final authState = ref.watch(authProvider);
  if (!authState.isInitialized || !authState.isAuthenticated) {
    return PlatformRole.guest;
  }
  return PlatformRole.fromName(authState.role);
});

final appRouterProvider = Provider<GoRouter>((ref) {
  final activeRole = ref.watch(activeRoleProvider);
  final application = ref.read(APP_PROVIDER_NAME);

  final dashboardRoute = activeRole == PlatformRole.guest
      ? CommonRoutes.login
      : application.getDefinition(activeRole)?.dashboardRoute ??
            CommonRoutes.login;

  return GovernanceRouter.buildZeroTrustRouter(
    application: application,
    activeRole: activeRole,
    initialLocation: dashboardRoute,
    refreshListenable: authListenable,
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      
      // If the authentication system has not completed its initial session restoration check yet,
      // DO NOT redirect the user! Prevent early redirects and let the startup check finalize.
      if (!authState.isInitialized) {
        return null;
      }

      final requestedRoute = state.uri.path;

      // Ensure SSO Portal URL is configured (this normally goes in app initialization)
      RouteGuard.ssoPortalUrl ??= const String.fromEnvironment(
        'SSO_PORTAL_URL',
        defaultValue: 'https://primecare-auth.pages.dev',
      );

      // If trying to hit root/login/callback while authenticated, redirect to dashboard immediately
      final isAtLanding =
          requestedRoute == '/' ||
          requestedRoute == CommonRoutes.login ||
          requestedRoute == CommonRoutes.authCallback;
      if (authState.isAuthenticated && isAtLanding) {
        return dashboardRoute;
      }

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

      return null;
    },
    """

    new_app_router_definition = new_app_router_definition.replace("APP_PROVIDER_NAME", app_provider_name)
    patched_content = before_part + new_app_router_definition + after_part
    
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(patched_content)
        
    print(f"[+] Successfully patched app_router.dart for {app_name}")
    return True

def main():
    for app in APPS:
        patch_app_router(app)

if __name__ == '__main__':
    main()
