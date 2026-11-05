import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:primecare_ui/src/features/auth/shared_auth_router.dart';
import 'package:flutter_core/models/screen.dart';
import 'package:flutter_core/models/screen_manager.dart';
import 'package:flutter_core/registry/platform_screen_registry.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/src/features/workspace/workspace_routes_generated.dart';
import 'package:primecare_ui/src/features/platform/platform_master_catalog.g.dart';
import 'package:primecare_ui/src/components/prime_components.dart';
import 'package:primecare_ui/src/components/governance_components.dart';
import 'package:primecare_ui/src/theme/prime_theme.dart';
import 'package:primecare_ui/src/routes/shared_routes.dart';
import 'package:primecare_ui/src/screens/screen_manager_catalog.dart';

void main() {
  test('all rendered shared authentication routes have registrations', () {
    expect(SharedAuthRoutes.screenManager, same(primeCareScreenManager));
    for (final path in [
      '/login', '/signup', '/forgot-password', '/reset-password', '/mfa',
      '/language', '/auth/error', '/auth/callback', '/common/settings', '/consent', '/success',
      '/internal/training/guide', '/internal/training/detail',
      '/internal/unauthorized-fallback', '/internal/access-denied',
      '/internal/guest-error',
      '/admin/screenshot-inventory',
    ]) {
      expect(SharedAuthRoutes.screenManager.lookup(path), isNotNull, reason: path);
    }
  });

  test('generated workspace and special routes have registrations', () {
    expect(SharedAuthRoutes.screenManager.lookup(platformAdministrationRoute), isNotNull);
    expect(SharedAuthRoutes.screenManager.lookup('/maintenance/configuration'), isNotNull);
    for (final path in governedWorkspaceRoutes.keys) {
      expect(SharedAuthRoutes.screenManager.lookup(path), isNotNull, reason: path);
    }
    for (final paths in governedWorkspaceRoleRoutes.values) {
      for (final path in paths) {
        expect(SharedAuthRoutes.screenManager.lookup(path), isNotNull, reason: path);
      }
    }
  });

  test('module routes use independent registrations', () {
    expect(primeCareScreenManager.lookup('/offices/client/roles/client/book-appointment'), isNotNull);
    expect(primeCareScreenManager.lookup('/not-registered-module-route'), isNull);
  });

  test('dynamic platform registry paths have presentation registrations', () {
    for (final screen in PlatformScreenRegistry.screens.values) {
      if (screen.routePath.isNotEmpty) {
        expect(primeCareScreenManager.lookup(screen.routePath), isNotNull,
          reason: '${screen.id}: ${screen.routePath}');
      }
    }
  });

  testWidgets('shared screenshot route uses its registered adapter', (tester) async {
    final router = GoRouter(routes: sharedCommonRoutes, initialLocation: '/admin/screenshot-inventory');
    addTearDown(router.dispose);
    late BuildContext context;
    await tester.pumpWidget(MaterialApp(home: Builder(builder: (value) {
      context = value;
      return const SizedBox();
    })));
    final route = sharedCommonRoutes.whereType<GoRoute>().single;
    final state = GoRouterState(router.configuration,
      uri: Uri.parse(route.path), matchedLocation: route.path,
      fullPath: route.path, pathParameters: const {}, pageKey: const ValueKey('inventory'));
    final shell = route.builder!(context, state) as AppShellBoundary;
    final boundary = shell.child as ManagedScreenBoundary;
    expect(boundary.screenId, '/admin/screenshot-inventory');
    expect(boundary.manager.lookup(boundary.screenId), isNotNull);
  });

  testWidgets('adapter preserves application feature settings', (tester) async {
    ScreenFeatureConfig? observed;
    await tester.pumpWidget(PrimeTheme(data: const PrimeThemeData(), child: MaterialApp(
      home: ScreenFeatureScope(
        features: const ScreenFeatureConfig(padding: EdgeInsets.all(9)),
        child: SharedAuthRoutes.managedPage('/login', (context) {
          observed = ScreenFeatureScope.of(context);
          return const SizedBox(key: Key('managed-auth-child'));
        }),
      ),
    )));
    expect(find.byKey(const Key('managed-auth-child')), findsOneWidget);
    expect(observed!.padding, const EdgeInsets.all(9));
  });

  testWidgets('unregistered public route does not build a screen', (tester) async {
    var built = false;
    await tester.pumpWidget(MaterialApp(home: SharedAuthRoutes.managedPage('/unregistered', (_) {
      built = true;
      return const SizedBox();
    })));
    expect(tester.takeException().toString(), contains('/unregistered'));
    expect(built, isFalse);
  });

  testWidgets('missing PrimeTheme blocks a registered screen', (tester) async {
    var built = false;
    await tester.pumpWidget(MaterialApp(home: SharedAuthRoutes.managedPage('/login', (_) {
      built = true;
      return const SizedBox();
    })));
    expect(tester.takeException().toString(), contains('PrimeTheme'));
    expect(built, isFalse);
  });

  // Exercise the real catalog after its workspace and module extensions.
  // These are separate mount checks, not live dependency removal, state
  // preservation, permission, or workflow tests.
  for (final route in ['/admin/screen-health', '/admin/create-shift']) {
    testWidgets('catalog route $route requires PrimeTheme across blocked and connected mounts', (tester) async {
      var builds = 0;
      final page = managedPrimeCarePage(route, (_) {
        builds++;
        return const SizedBox(key: Key('connected-catalog-page'));
      });
      final app = MaterialApp(home: page);

      Future<void> expectBlocked() async {
        final previousBuilds = builds;
        await tester.pumpWidget(app);
        expect(
          tester.takeException().toString(),
          'Screen Manager: screen "$route" is missing required connections: PrimeTheme.',
        );
        expect(builds, previousBuilds);
        expect(find.byKey(const Key('connected-catalog-page')), findsNothing);
      }

      await expectBlocked();
      await tester.pumpWidget(PrimeTheme(
        data: const PrimeThemeData(),
        bootstrap: false,
        child: app,
      ));
      expect(tester.takeException(), isNull);
      expect(builds, greaterThan(0));
      expect(find.byKey(const Key('connected-catalog-page')), findsOneWidget);
      await expectBlocked();
    });
  }

  testWidgets('managed shared buttons respond to theme and locale changes', (tester) async {
    Widget app(Color primary, Locale locale) => PrimeTheme(
      data: PrimeThemeData(colors: PrimeColors(primary: primary, onSurfaceVariant: primary)),
      child: MaterialApp(
        locale: locale,
        supportedLocales: const [Locale('en', 'US'), Locale('en', 'CA')],
        home: SharedAuthRoutes.managedPage('/login', (context) => Scaffold(
          body: Column(children: [
            PrimeButton.secondary(label: Localizations.localeOf(context).countryCode == 'CA' ? 'Canadian' : 'American', onPressed: () {}),
            PrimeButton.ghost(label: 'Ghost', onPressed: () {}),
            const TextField(key: Key('managed-draft')),
          ]),
        )),
      ),
    );
    await tester.pumpWidget(app(Colors.teal, const Locale('en', 'US')));
    expect(find.text('American'), findsOneWidget);
    await tester.enterText(find.byKey(const Key('managed-draft')), 'keep draft');
    expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).style!.foregroundColor!.resolve({}), Colors.teal);
    await tester.pumpWidget(app(Colors.orange, const Locale('en', 'CA')));
    await tester.pumpAndSettle();
    expect(find.text('Canadian'), findsOneWidget);
    expect(find.text('keep draft'), findsOneWidget);
    expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).style!.foregroundColor!.resolve({}), Colors.orange);
    expect(tester.widget<Text>(find.text('Ghost')).style!.color, Colors.orange);
    expect(tester.takeException(), isNull);
  });

  testWidgets('managed dashboard error follows English French and Spanish', (tester) async {
    var retries = 0;
    Widget app(String language) => PrimeTheme(
      data: const PrimeThemeData(),
      child: MaterialApp(
        locale: Locale(language),
        supportedLocales: const [Locale('en'), Locale('fr'), Locale('es')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: SharedAuthRoutes.managedPage('/login', (_) => Scaffold(
          body: DashboardErrorWidget(message: 'Example', onRetry: () => retries++),
        )),
      ),
    );
    for (final row in [
      ('en', 'Operational Anomaly Detected', 'Retry Hydration'),
      ('fr', 'Anomalie de fonctionnement détectée', 'Réessayer'),
      ('es', 'Se detectó una anomalía operativa', 'Reintentar'),
    ]) {
      await tester.pumpWidget(app(row.$1));
      await tester.pumpAndSettle();
      expect(find.text(row.$2), findsOneWidget);
      expect(find.text(row.$3), findsOneWidget);
      await tester.tap(find.text(row.$3));
    }
    expect(retries, 3);
    expect(tester.takeException(), isNull);
  });

  testWidgets('managed dashboard shared labels follow locale', (tester) async {
    Widget app(String language) => PrimeTheme(data: const PrimeThemeData(), child: MaterialApp(
      locale: Locale(language), supportedLocales: const [Locale('en'), Locale('fr'), Locale('es')],
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
      home: SharedAuthRoutes.managedPage('/login', (_) => const Scaffold(
        body: SingleChildScrollView(child: Column(children: [
          GovDashboardHero(title: 'Title', roleName: 'Role', description: 'Description'),
          GovMetricCard(title: 'Metric', value: '42', trendLabel: 'Stable', progress: .5,
            icon: Icons.analytics, brandColor: Colors.teal),
        ])),
      )),
    ));
    for (final row in [
      ('en', 'ACTIVE & SECURE', 'Utilization'),
      ('fr', 'ACTIF ET SÉCURISÉ', 'Utilisation'),
      ('es', 'ACTIVO Y SEGURO', 'Utilización'),
    ]) {
      await tester.pumpWidget(app(row.$1));
      await tester.pumpAndSettle();
      expect(find.text(row.$2), findsOneWidget);
      expect(find.text(row.$3), findsOneWidget);
      expect(tester.takeException(), isNull);
    }
  });
}
