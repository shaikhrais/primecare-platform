import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart'
    show EasyLocalization, ProviderScope, authProvider;
import 'package:primecare_ui/src/features/auth/auth_experience.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_design_test.dart' as auth_fixture;

void expectLocalInkSurface(WidgetTester tester) {
  final help = find.byType(ExpansionTile);
  expect(help, findsOneWidget);
  final tile = find.descendant(of: help, matching: find.byType(ListTile));
  expect(tile, findsOneWidget);

  // Inspect the actual rendered help tile, not source text or an isolated
  // surrogate. Its ink controller must be below the opaque auth decoration.
  final ancestors = <Element>[];
  tester.element(tile).visitAncestorElements((element) {
    ancestors.add(element);
    return true;
  });
  final surfaceIndex = ancestors.indexWhere((element) {
    final widget = element.widget;
    return widget is DecoratedBox &&
        widget.decoration is BoxDecoration &&
        (widget.decoration as BoxDecoration).boxShadow != null;
  });
  expect(surfaceIndex, greaterThanOrEqualTo(0));
  final materialIndex = ancestors.indexWhere(
    (element) => element.widget is Material,
  );
  expect(
    materialIndex >= 0 && materialIndex < surfaceIndex,
    isTrue,
    reason: 'AUTH_INK_SURFACE: help ink must paint above the opaque auth card',
  );
  final material = ancestors[materialIndex].widget as Material;
  expect(material.type, MaterialType.transparency);
  expect(
    Material.of(tester.element(tile)),
    isNot(same(Material.of(ancestors[surfaceIndex]))),
    reason: 'The card must own a nearer ink controller than the Scaffold',
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  for (final language in ['en', 'fr', 'es']) {
    for (final size in [const Size(360, 800), const Size(1440, 1000)]) {
      testWidgets('login help ink surface $language ${size.width}', (tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(ProviderScope(
          overrides: [authProvider.overrideWith(auth_fixture.GuestAuth.new)],
          child: auth_fixture.localized(
            const PrimeAuthExperience(page: AuthPage.login),
            language: language,
          ),
        ));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        expectLocalInkSurface(tester);
        expect(find.byType(PrimeAuthTextField), findsNWidgets(2));

        final help = find.byType(ExpansionTile);
        final content = tester.widget<ExpansionTile>(help).children.single as Padding;
        final helpText = (content.child! as Text).data!;
        expect(find.text(helpText), findsNothing);
        final tile = find.descendant(of: help, matching: find.byType(ListTile));
        await tester.ensureVisible(tile);
        await tester.tap(tile);
        await tester.pumpAndSettle();
        expect(find.text(helpText), findsOneWidget);
        expectLocalInkSurface(tester);
        await tester.ensureVisible(tile);
        await tester.tap(tile);
        await tester.pumpAndSettle();
        expect(find.text(helpText), findsNothing);
        expectLocalInkSurface(tester);
        expect(tester.takeException(), isNull);
      });
    }
  }
}
