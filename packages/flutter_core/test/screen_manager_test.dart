import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_core/models/screen.dart';
import 'package:flutter_core/models/domain_governance.dart';
import 'package:flutter_core/registry/platform_role.dart';
import 'package:flutter_core/routes/governance_router.dart';
import 'package:flutter_core/flutter_core.dart'
    show ManagedScreenBoundary, ManagedScreenRegistration, ScreenManager;

class EmptyApplication extends PlatformApplication {
  @override String get appId => 'test';
  @override String get name => 'Test';
  @override PlatformTenant get tenant => PrimeCareTenant();
  @override List<PlatformRoleDefinition> get roleDefinitions => const [];
}

void main() {
  test('rejects duplicate and empty registration ids', () {
    expect(() => ScreenManager([const ManagedScreenRegistration(id: '')]), throwsArgumentError);
    expect(() => ScreenManager([
      const ManagedScreenRegistration(id: 'one'),
      const ManagedScreenRegistration(id: 'one'),
    ]), throwsArgumentError);
  });

  test('module routes extend registrations without replacing shared settings', () {
    final original = ScreenManager([const ManagedScreenRegistration(
      id: '/shared', features: ScreenFeatureConfig(padding: EdgeInsets.all(4)),
    )]);
    final combined = original.withAdditionalRoutes(['/shared', '/module', '/module']);
    expect(original.lookup('/module'), isNull);
    expect(combined.lookup('/module'), isNotNull);
    expect(combined.lookup('/shared')!.features!.padding, const EdgeInsets.all(4));
  });

  testWidgets('unregistered screen never invokes its builder', (tester) async {
    var built = false;
    await tester.pumpWidget(MaterialApp(home: ManagedScreenBoundary(
      manager: ScreenManager([]), screenId: 'missing',
      builder: (_) { built = true; return const SizedBox(); },
    )));
    expect(tester.takeException().toString(), contains('screen "missing" is not registered'));
    expect(built, isFalse);
  });

  testWidgets('guest error builder is blocked without registration', (tester) async {
    var built = false;
    final router = GovernanceRouter.buildZeroTrustRouter(
      application: EmptyApplication(), activeRole: PlatformRole.guest,
      initialLocation: '/login', screenManager: ScreenManager([]),
      publicRoutes: [GoRoute(path: '/login', builder: (_, __) => const SizedBox())],
      guestErrorBuilder: (_, __) { built = true; return const SizedBox(); },
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();
    router.go('/missing');
    await tester.pumpAndSettle();
    expect(tester.takeException().toString(), contains('/internal/guest-error'));
    expect(built, isFalse);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('missing layout blocks the builder', (tester) async {
    var built = false;
    await tester.pumpWidget(MaterialApp(home: ManagedScreenBoundary(
      manager: ScreenManager([const ManagedScreenRegistration(id: 'one')]), screenId: 'one',
      builder: (_) { built = true; return const SizedBox(); },
    )));
    expect(tester.takeException().toString(), contains('layout'));
    expect(built, isFalse);
  });

  // Supply contexts explicitly so MaterialApp cannot hide a missing dependency.
  for (final missing in ['layout', 'theme', 'language', 'responsive']) {
    testWidgets('missing $missing alone blocks a registered builder', (tester) async {
      var built = false;
      Widget child = ManagedScreenBoundary(
        manager: ScreenManager([const ManagedScreenRegistration(id: 'one')]),
        screenId: 'one',
        builder: (_) {
          built = true;
          return const SizedBox();
        },
      );
      if (missing != 'layout') child = AppShellBoundary(child: child);
      if (missing != 'theme') child = Theme(data: ThemeData(), child: child);
      if (missing != 'language') {
        child = Localizations(
          locale: const Locale('en'),
          delegates: const [DefaultWidgetsLocalizations.delegate],
          child: child,
        );
      }
      if (missing != 'responsive') {
        child = MediaQuery(data: const MediaQueryData(), child: child);
      }
      // View (including pumpWidget's default wrapper) adds MediaQuery.
      // RawView supplies only the render root, keeping each context explicit.
      await tester.pumpWidget(
        RawView(
          view: tester.view,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: child,
          ),
        ),
        wrapWithView: false,
      );
      expect(
        tester.takeException().toString(),
        'Screen Manager: screen "one" is missing required connections: $missing.',
      );
      expect(built, isFalse);
    });
  }

  testWidgets('extended registrations retain required connections', (tester) async {
    var built = false;
    final manager = ScreenManager(
      [const ManagedScreenRegistration(id: '/shared')],
      connections: {'custom manager': (_) => false},
    ).withAdditionalRoutes(['/module']);
    await tester.pumpWidget(MaterialApp(home: AppShellBoundary(child: ManagedScreenBoundary(
      manager: manager, screenId: '/module',
      builder: (_) { built = true; return const SizedBox(); },
    ))));
    expect(tester.takeException().toString(), contains('custom manager'));
    expect(built, isFalse);
  });

  testWidgets('registered route pattern handles a concrete parameter', (tester) async {
    final manager = ScreenManager([const ManagedScreenRegistration(id: '/clients/:id')]);
    final router = GoRouter(initialLocation: '/clients/123', routes: [ShellRoute(
      builder: (context, state, child) => AppShellBoundary(child: ManagedScreenBoundary(
        manager: manager, screenId: state.fullPath ?? state.matchedLocation,
        builder: (_) => child,
      )),
      routes: [GoRoute(path: '/clients/:id', builder: (_, state) => Text('Client ${state.pathParameters['id']}'))],
    )]);
    addTearDown(router.dispose);
    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();
    expect(find.text('Client 123'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('registered screen receives features and inherited updates', (tester) async {
    ScreenInheritanceManager? current;
    final manager = ScreenManager([const ManagedScreenRegistration(
      id: 'one', features: ScreenFeatureConfig(padding: EdgeInsets.all(12)),
    )]);
    Widget app(Color color, Locale locale) => MaterialApp(
      theme: ThemeData(colorSchemeSeed: color), locale: locale,
      themeAnimationDuration: Duration.zero,
      supportedLocales: const [Locale('en', 'US'), Locale('en', 'CA')],
      home: AppShellBoundary(child: ManagedScreenBoundary(
        manager: manager, screenId: 'one', builder: (context) {
          current = ScreenInheritanceManager.of(context);
          return const SizedBox();
        },
      )),
    );
    await tester.pumpWidget(app(Colors.teal, const Locale('en', 'US')));
    final firstColor = current!.theme.colorScheme.primary;
    expect(current!.features.padding, const EdgeInsets.all(12));
    await tester.pumpWidget(app(Colors.orange, const Locale('en', 'CA')));
    await tester.pumpAndSettle();
    expect(current!.locale, const Locale('en', 'CA'));
    expect(current!.theme.colorScheme.primary, isNot(firstColor));
  });
}
