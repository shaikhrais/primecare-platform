import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/localization/admin_role_carousel_catalog.dart';
import 'package:primecare_ui/src/localization/admin_role_carousel_text.dart';
import 'package:primecare_ui/src/screens/admin/admin_role_carousel_screen.dart';
import 'auth_design_test.dart' show localized;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  test('all three catalogs contain the same nonempty keys and interpolation parameters', () {
    final english = adminRoleCarouselCatalog['en']!;
    final parameter = RegExp(r'\{([a-zA-Z][a-zA-Z0-9_]*)\}');
    for (final language in ['en', 'es', 'fr']) {
      final entries = adminRoleCarouselCatalog[language]!;
      expect(entries.keys.toSet(), english.keys.toSet());
      for (final entry in entries.entries) {
        expect(entry.value.trim(), isNotEmpty, reason: '$language.${entry.key}');
        expect(parameter.allMatches(entry.value).map((m) => m.group(1)).toSet(),
          parameter.allMatches(english[entry.key]!).map((m) => m.group(1)).toSet(),
          reason: '$language.${entry.key}');
      }
    }
    expect(AdminRoleCarouselText.resolve('es', 'copiedPath', args: {'file': '{name}.dart'}),
      contains('{name}.dart')); // Parameter values must not be interpreted again.
    expect(() => AdminRoleCarouselText.resolve('fr', 'reviewCount'), throwsArgumentError);
    expect(() => AdminRoleCarouselText.resolve('es', 'unknown'), throwsArgumentError);
  });

  testWidgets('carousel labels, search placeholder, tooltips and dialog switch en/es/fr without losing search', (tester) async {
    tester.view.physicalSize = const Size(2400, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final previous = Map<String, ScreenHealthStatus>.from(screenHealthRegistry);
    screenHealthRegistry
      ..clear()
      ..['fixture'] = ScreenHealthStatus.fromJson({
        'screenName': 'Fixture', 'routePath': '/fixture', 'componentFile': 'fixture.dart',
        'roleKey': 'qa', 'roleName': 'QA', 'roleCategory': 'corporate',
      });
    addTearDown(() { screenHealthRegistry..clear()..addAll(previous); });
    await tester.pumpWidget(ProviderScope(child: PrimeTheme(data: const PrimeThemeData(),
      child: localized(const AdminRoleCarouselScreen()))));
    await tester.pumpAndSettle();
    final field = find.byType(TextField);
    final screen = find.byType(AdminRoleCarouselScreen);
    for (final language in ['en', 'es', 'fr']) {
      await tester.element(screen).setLocale(Locale(language));
      await tester.pumpAndSettle();
      String text(String key) => AdminRoleCarouselText.resolve(language, key);
      expect(find.text(text('title')), findsOneWidget);
      expect(find.text(text('reload')), findsOneWidget);
      expect(find.text(text('incompleteOnly')), findsOneWidget);
      expect(tester.widget<TextField>(field).decoration!.hintText, text('search'));
      expect(find.byTooltip(text('healthDetails')), findsOneWidget);
      await tester.tap(find.byTooltip(text('healthDetails')));
      await tester.pumpAndSettle();
      expect(find.text(AdminRoleCarouselText.resolve(language, 'healthTitle', args: {'name': 'Fixture'})), findsOneWidget);
      expect(find.text(text('missingItems')), findsOneWidget);
      expect(find.text(text('noMissingItems')), findsOneWidget);
      await tester.tap(find.text(text('close')));
      await tester.pumpAndSettle();
      await tester.enterText(field, 'no-matching-record');
      await tester.element(screen).setLocale(Locale(language == 'fr' ? 'en' : 'fr'));
      await tester.pumpAndSettle();
      expect(tester.widget<TextField>(field).controller!.text, 'no-matching-record');
      final current = tester.element(screen).locale.languageCode;
      expect(find.text(AdminRoleCarouselText.resolve(current, 'empty')), findsOneWidget);
      await tester.tap(find.byTooltip(AdminRoleCarouselText.resolve(current, 'clearSearch')));
      await tester.pumpAndSettle();
      expect(tester.widget<TextField>(field).controller!.text, isEmpty);
      expect(tester.takeException(), isNull);
    }
  });
}
