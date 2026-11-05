import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/models/screen.dart';
import 'package:flutter_core/flutter_core.dart'
    show ManagedScreenBoundary, ManagedScreenRegistration, ScreenManager;

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

  testWidgets('missing layout blocks the builder', (tester) async {
    var built = false;
    await tester.pumpWidget(MaterialApp(home: ManagedScreenBoundary(
      manager: ScreenManager([const ManagedScreenRegistration(id: 'one')]), screenId: 'one',
      builder: (_) { built = true; return const SizedBox(); },
    )));
    expect(tester.takeException().toString(), contains('layout'));
    expect(built, isFalse);
  });

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
