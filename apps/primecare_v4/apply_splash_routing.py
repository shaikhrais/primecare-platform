import os
import re

base_dir = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_v4\lib"
routes_file = os.path.join(base_dir, "routes", "app_routes.dart")

with open(routes_file, "r", encoding='utf-8') as f:
    routes_content = f.read()

if "static const String splash =" not in routes_content:
    routes_content = routes_content.replace(
        "class AppRoutes {\n  static const String login = '/';",
        "class AppRoutes {\n  static const String splash = '/';\n  static const String login = '/login';"
    )
elif "static const String splash = '/';" not in routes_content:
    routes_content = routes_content.replace(
        "static const String login = '/';",
        "static const String login = '/login';\n  static const String splash = '/';"
    )

with open(routes_file, "w", encoding='utf-8') as f:
    f.write(routes_content)

router_file = os.path.join(base_dir, "routes", "app_router.dart")
with open(router_file, "r", encoding='utf-8') as f:
    router_content = f.read()

if "import '../screens/splash_screen.dart';" not in router_content:
    router_content = router_content.replace("import '../screens/login_screen.dart';", "import '../screens/login_screen.dart';\nimport '../screens/splash_screen.dart';")

# Change initialLocation to AppRoutes.splash
router_content = router_content.replace("initialLocation: AppRoutes.login,", "initialLocation: AppRoutes.splash,")

# Intercept logic for redirect:
redirect_old = """    redirect: (BuildContext context, GoRouterState state) {
      final isLoggingIn = state.matchedLocation == AppRoutes.login || 
                           state.matchedLocation == AppRoutes.signup || 
                           state.matchedLocation == AppRoutes.forgotPassword;
      
      final isLoggedIn = authState.isAuthenticated;
      final role = authState.role ?? '';

      if (!isLoggedIn && !isLoggingIn) {
        return AppRoutes.login;
      }
      
      if (isLoggedIn && isLoggingIn) {
        return AuthNotifier.getDashboardRouteForRole(role);
      }
      
      return null;
    },"""

redirect_new = """    redirect: (BuildContext context, GoRouterState state) {
      final isLoggingIn = state.matchedLocation == AppRoutes.login || 
                           state.matchedLocation == AppRoutes.signup || 
                           state.matchedLocation == AppRoutes.forgotPassword;
      final isSplash = state.matchedLocation == AppRoutes.splash;
      
      final isLoggedIn = authState.isAuthenticated;
      final role = authState.role ?? '';

      // Allow splash to render unhindered
      if (isSplash) return null;

      if (!isLoggedIn && !isLoggingIn) {
        return AppRoutes.login;
      }
      
      if (isLoggedIn && isLoggingIn) {
        return AuthNotifier.getDashboardRouteForRole(role);
      }
      
      return null;
    },"""

if "final isSplash" not in router_content:
    router_content = router_content.replace(redirect_old, redirect_new)

# Add GoRoute for the Splash screen OUTSIDE the ShellRoute
if "GoRoute(path: AppRoutes.splash" not in router_content:
    router_content = router_content.replace(
        "    routes: [",
        "    routes: [\n      GoRoute(path: AppRoutes.splash, builder: (context, state) => const SplashScreen()),"
    )

with open(router_file, "w", encoding='utf-8') as f:
    f.write(router_content)

print("Router updated with splash screen mappings.")
