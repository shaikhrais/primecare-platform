/* 
PRIME:SCREEN=consent
PRIME:DESIGN=DESIGN_STARTED
PRIME:HTML=HTML_LAYOUT_DONE
PRIME:COMP=COMP_MISSING
PRIME:LOGIC=LOGIC_NONE
PRIME:API=API_NONE
PRIME:DB=DB_NONE
PRIME:VALIDATION=VALIDATION_NONE
PRIME:QA=QA_NOT_STARTED
PRIME:FINAL=FINAL_NOT_READY
PRIME:PROGRESS=20
PRIME:BLOCKER=Placeholder detected: return null in build
PRIME:NEXT_ACTION=Remediate placeholder elements with real visual widgets
*/
// Governance - Category: app_entry | Purpose: System-level main entrypoint
// PRIME:SCREEN=consent
// PRIME:SCREEN=success_profile
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/theme/theme_config_generated.dart';
import 'package:web/web.dart' as web;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/semantics.dart';

import 'success_profile/success_profile_screen.dart';
import 'consent/consent_screen.dart';

class AuthTenant extends PlatformTenant {
  @override
  String get tenantId => 'primecare_hq';

  @override
  String get name => 'PrimeCare';

  PrimeThemeData get primeThemeData => PrimeThemeData(
        colors: PrimeColors.fromPalette(ThemeConfig.getAppPalette('auth')),
      );

  @override
  ThemeData get branding => primeThemeData.toThemeData();
}

class AuthApplication extends PlatformApplication {
  @override
  String get appId => 'primecare_auth';

  @override
  String get name => 'PrimeCare Identity Portal';

  @override
  PlatformTenant get tenant => AuthTenant();

  @override
  List<PlatformRoleDefinition> get roleDefinitions => [];
}

void main() {
  configureUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    SemanticsBinding.instance.ensureSemantics();
  }

  PrimeCareAppRunner.run(
    appWidget: const PrimeCareAuthApp(),
    overrides: [
      platformApplicationProvider.overrideWithValue(AuthApplication()),
    ],
  );
}

class PrimeCareAuthApp extends ConsumerWidget {
  const PrimeCareAuthApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(authRouterProvider);
    final tenant = AuthTenant();
    final primeTheme = tenant.primeThemeData;

    return AppShellBoundary(
      child: PrimeTheme(
        data: primeTheme,
        child: MaterialApp.router(
          title: 'PrimeCare Identity Portal',
          theme: primeTheme.toThemeData(),
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        ),
      ),
    );
  }
}



final loginSuccessRedirectProvider = StateProvider<bool>((ref) => false);

// Memory-safe guard to ensure force_login is only evaluated once per page mount
bool _hasForcedLogout = false;

final authRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    refreshListenable: authListenable,
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      if (!authState.isInitialized) {
        return null;
      }
      final isAtLogin = state.uri.path == '/login';
      final isAtLanguage = state.uri.path == '/language';
      // Reset the flag when we leave the login page
      if (!isAtLogin) {
        Future.microtask(() {
          ref.read(loginSuccessRedirectProvider.notifier).state = false;
        });
      }

      // Redirection: Check if a language has ever been persistently selected
      final prefs = ref.read(sharedPreferencesProvider);
      final hasSelectedLanguage = prefs?.getBool('auth_language_selected') ?? false;

      if (!hasSelectedLanguage && !isAtLanguage) {
        final query = state.uri.query;
        return '/language${query.isNotEmpty ? '?$query' : ''}';
      }

      final justLoggedIn = ref.read(loginSuccessRedirectProvider);

      // Force logout if the user directly accesses the login route to ensure credentials entry is shown
      if (isAtLogin && authState.isAuthenticated && !justLoggedIn) {
        Future.microtask(() {
          ref.read(authProvider.notifier).logout();
        });
        return null;
      }

      final forceLogin = state.uri.queryParameters['force_login'] == 'true';
      if (forceLogin && !_hasForcedLogout) {
        _hasForcedLogout = true;
        if (authState.isAuthenticated) {
          Future.microtask(() {
            ref.read(authProvider.notifier).logout();
          });
        }
        if (kIsWeb) {
          try {
            final uri = Uri.parse(web.window.location.href);
            final params = Map<String, String>.from(uri.queryParameters)..remove('force_login');
            final newUri = uri.replace(queryParameters: params.isEmpty ? null : params);
            web.window.history.replaceState(null, '', newUri.toString());
          } catch (_) {}
        }
        final query = state.uri.query;
        return '/login${query.isNotEmpty ? '?$query' : ''}';
      }

      if (!forceLogin) {
        _hasForcedLogout = false;
      }

      // If authenticated and trying to log in (or just logged in)
      if (authState.isAuthenticated) {

        // If not redirecting, show App Hub success route
        if (state.uri.path == '/success') {
          return null;
        }
        return '/success';
      }

      if (!authState.isAuthenticated && !isAtLogin && !isAtLanguage) {
        final query = state.uri.query;
        return '/login${query.isNotEmpty ? '?$query' : ''}';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/language',
        builder: (context, state) => const LanguageSelectionView(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginViewWrapper(),
      ),
      GoRoute(
        path: '/success',
        builder: (context, state) => const SuccessProfileScreen(),
      ),
      GoRoute(
        path: '/consent',
        builder: (context, state) {
          final redirectUri = state.uri.queryParameters['redirect_uri'] ?? '';
          return ConsentScreen(redirectUri: redirectUri);
        },
      ),
    ],
  );
});

class LoginViewWrapper extends ConsumerWidget {
  const LoginViewWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.isAuthenticated && !(previous?.isAuthenticated ?? false)) {
        ref.read(loginSuccessRedirectProvider.notifier).state = true;
        context.go('/success');
      }
    });

    return const LoginView();
  }
}

