import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/localization/admin_reality_filter_catalog.dart';
import 'package:primecare_ui/src/localization/admin_reality_filter_text.dart';
import 'package:primecare_ui/src/screens/admin/admin_reality_check_screen.dart';
import 'auth_design_test.dart' show localized;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  test('filter catalogs contain matching nonempty keys and reject unknown keys', () {
    final keys = adminRealityFilterCatalog['en']!.keys.toSet();
    expect(keys.length, 8);
    for (final language in ['en', 'es', 'fr']) {
      final entries = adminRealityFilterCatalog[language]!;
      expect(entries.keys.toSet(), keys);
      for (final value in entries.values) {
        expect(value.trim(), isNotEmpty);
      }
    }
    expect(AdminRealityFilterText.resolve('de', 'search'),
      AdminRealityFilterText.resolve('en', 'search'));
    expect(() => AdminRealityFilterText.resolve('fr', 'unknown'), throwsArgumentError);
  });

  testWidgets('search and filter labels switch en/es/fr while query and filtering survive', (tester) async {
    tester.view.physicalSize = const Size(2400, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final previous = Map<String, ScreenHealthStatus>.from(screenHealthRegistry);
    screenHealthRegistry
      ..clear()
      ..['zero'] = ScreenHealthStatus.fromJson({
        'screenName': 'Fixture zero', 'routePath': '/fixture-zero',
        'componentFile': 'fixture.dart', 'totalInteractiveObjects': 0,
      })
      ..['active'] = ScreenHealthStatus.fromJson({
        'screenName': 'Fixture active', 'routePath': '/fixture-active',
        'componentFile': 'fixture.dart', 'totalInteractiveObjects': 4,
      });
    addTearDown(() { screenHealthRegistry..clear()..addAll(previous); });
    await tester.pumpWidget(ProviderScope(child: PrimeTheme(data: const PrimeThemeData(),
      child: localized(const AdminRealityCheckScreen()))));
    await tester.pumpAndSettle();
    final field = find.byType(TextField);
    final dropdown = find.byType(DropdownButton<String>);
    final screen = find.byType(AdminRealityCheckScreen);
    await tester.enterText(field, 'Fixture');
    await tester.tap(dropdown);
    await tester.pumpAndSettle();
    await tester.tap(find.text(AdminRealityFilterText.resolve('en', 'Zero Interaction')).last);
    await tester.pumpAndSettle();
    for (final language in ['en', 'es', 'fr']) {
      await tester.element(screen).setLocale(Locale(language));
      await tester.pumpAndSettle();
      final widget = tester.widget<DropdownButton<String>>(dropdown);
      expect(widget.value, 'Zero Interaction');
      for (final item in widget.items!) {
        expect((item.child as Text).data, AdminRealityFilterText.resolve(language, item.value!));
      }
      final input = tester.widget<TextField>(field);
      expect(input.decoration!.hintText, AdminRealityFilterText.resolve(language, 'search'));
      expect(input.controller!.text, 'Fixture');
      expect(find.byTooltip(AdminRealityFilterText.resolve(language, 'reload')), findsOneWidget);
      expect(find.text('Fixture zero'), findsOneWidget);
      expect(find.text('Fixture active'), findsNothing);
      await tester.tap(find.byTooltip(AdminRealityFilterText.resolve(language, 'reload')));
      await tester.pumpAndSettle();
      expect(tester.widget<DropdownButton<String>>(dropdown).value, 'Zero Interaction');
      expect(tester.widget<TextField>(field).controller!.text, 'Fixture');
      expect(tester.takeException(), isNull);
    }
  });
}
