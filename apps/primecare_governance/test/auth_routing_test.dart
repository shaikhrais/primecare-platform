import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_core/models/screen_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_governance/core/governance/route_registry.dart';
import 'package:primecare_governance/core/governance/registries/index.dart';

import 'package:primecare_governance/core/routing/governance_application.dart' as registered_app;

class GuestAuth extends AuthNotifier {
  @override
  AuthState build() => AuthState(isInitialized: true);
}

class StartupAuth extends AuthNotifier {
  @override
  AuthState build() => AuthState(isInitialized: false);
}

class AuthTranslations extends AssetLoader {
  const AuthTranslations();
  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async =>
      jsonDecode(File('$path/${locale.languageCode}.json').readAsStringSync()) as Map<String, dynamic>;
}

void main() {
  test('governance module routes have explicit presentation registrations', () {
    for (final module in registered_app.GovernanceApplication().modules) {
      for (final screen in module.screens) {
        expect(SharedAuthRoutes.screenManager.lookup(screen.route), isNotNull,
          reason: '${screen.title}: ${screen.route}');
      }
    }
  });

  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    Registry.registerAll();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });
  test('static dashboard report cannot bypass app authentication', () {
    expect(File('web/dashboard.html').existsSync(), isFalse);
  });
  test('governance shell routes are registered', () {
    final container = ProviderContainer(overrides: [authProvider.overrideWith(GuestAuth.new)]);
    addTearDown(container.dispose);
    final router = container.read(appRouterProvider);
    final shell = router.configuration.routes.whereType<ShellRoute>().single;
    final manager = buildGovernanceScreenManager();
    for (final route in shell.routes.whereType<GoRoute>()) {
      expect(manager.lookup(route.path), isNotNull, reason: route.path);
    }
  });
  for (final initialized in [false, true]) {
    for (final path in ['/dashboard', '/missing-deep-link', '/auth/callback', '/consent']) {
      testWidgets('guest deep link $path reaches local login; initialized=$initialized', (tester) async {
        tester.binding.platformDispatcher.defaultRouteNameTestValue = '$path?enable-semantics=true';
        addTearDown(tester.binding.platformDispatcher.clearDefaultRouteNameTestValue);
        final container = ProviderContainer(overrides: [
          authProvider.overrideWith(initialized ? GuestAuth.new : StartupAuth.new),
        ]);
        addTearDown(container.dispose);
        final router = container.read(appRouterProvider);
        await tester.pumpWidget(UncontrolledProviderScope(container: container,
          child: EasyLocalization(supportedLocales: const [Locale('en')],
            path: 'assets/translations', startLocale: const Locale('en'),
            assetLoader: const AuthTranslations(),
            child: PrimeTheme(data: const PrimeThemeData(), child: Builder(builder: (context) => MaterialApp.router(
              locale: context.locale, supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              routerConfig: router,
            ))),
          ),
        ));
        await tester.pumpAndSettle();
        expect(router.routeInformationProvider.value.uri.path, '/login');
        expect(find.byType(LoginView), findsOneWidget);
        expect(tester.takeException(), isNull);
        await tester.pumpWidget(const SizedBox.shrink());
      });
    }
  }

  testWidgets('governance login renders shared form without SSO bridge', (tester) async {
    final container = ProviderContainer(overrides: [
      authProvider.overrideWith(GuestAuth.new),
    ]);
    addTearDown(container.dispose);
    final router = container.read(appRouterProvider);
    final paths = router.configuration.routes.whereType<GoRoute>().map((route) => route.path);
    expect(paths, containsAll(SharedAuthRoutes.publicPaths));
    final route = router.configuration.routes.whereType<GoRoute>()
        .singleWhere((route) => route.path == CommonRoutes.login);
    late BuildContext context;
    await tester.pumpWidget(MaterialApp(home: Builder(builder: (value) {
      context = value;
      return const SizedBox.shrink();
    })));
    final state = GoRouterState(router.configuration,
      uri: Uri.parse('/login?enable-semantics=true'),
      matchedLocation: '/login',
      fullPath: '/login',
      pathParameters: const {},
      pageKey: const ValueKey('login'),
    );
    final boundary = route.builder!(context, state) as AppShellBoundary;
    final managed = boundary.child as ManagedScreenBoundary;
    expect(managed.screenId, CommonRoutes.login);
    expect(managed.builder(context), isA<LoginView>());
    final legacy = router.configuration.routes.whereType<GoRoute>()
        .singleWhere((route) => route.path == CommonRoutes.ssoRedirect);
    final location = await legacy.redirect!(context, state);
    expect(Uri.parse(location!).path, '/login');
    expect(Uri.parse(location).hasAuthority, isFalse);
  });

  test('return paths remain local and preserve encoded query values', () {
    expect(validateClinicReturnUrl('https://example.test/path'), isNull);
    expect(validateClinicReturnUrl('//example.test/path'), isNull);
    expect(validateClinicReturnUrl('/login'), isNull);
    expect(validateClinicReturnUrl('/auth/callback'), isNull);
    expect(validateClinicReturnUrl('relative/path'), isNull);
    expect(validateClinicReturnUrl('/clinic/care-plan?q=a%26b'),
      '/clinic/care-plan?q=a%26b');
  });
}
