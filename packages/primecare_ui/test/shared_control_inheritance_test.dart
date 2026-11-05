import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/src/localization/live_screen_text.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:primecare_ui/src/components/prime_components.dart';
import 'package:primecare_ui/src/theme/prime_theme.dart';
import 'package:primecare_ui/src/theme/prime_theme_resolver.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets('mounted shared controls inherit theme, locale and live text without losing drafts', (tester) async {
    var version = 0;
    var retries = 0;
    final store = LiveScreenTextStore(
      baseUrl: 'https://test',
      client: MockClient((request) async => http.Response(
        jsonEncode(request.url.path.endsWith('/screen-text')
            ? {'screens': version == 0 ? [] : [{'id': 'shared_controls', 'version': version}]}
            : {'screen': 'shared_controls', 'version': version, 'locales': {
                for (final language in ['en', 'fr', 'es']) language: {
                  'dashboard_error': 'Updated error $language v$version',
                  'retry': 'Updated retry $language v$version',
                },
              }}),
        200,
        headers: {'content-type': 'application/json; charset=utf-8'},
      )),
    );
    addTearDown(store.dispose);

    // Keep the exact same child instance: changes must reach the controls via
    // inherited dependencies, rather than reconstructing the screen manually.
    final controls = Scaffold(body: SingleChildScrollView(child: Column(children: [
      const PrimeCareCard(child: PrimeCareTextField(label: 'Reference')),
      DashboardErrorWidget(message: 'Service unavailable', onRetry: () => retries++),
    ])));
    Widget app(PrimeThemeData prime, ThemeData material, String language) {
      return PrimeTheme(
        bootstrap: false,
        data: prime,
        child: MaterialApp(
          theme: material,
          locale: Locale(language),
          supportedLocales: const [Locale('en'), Locale('fr'), Locale('es')],
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          home: LiveScreenTextScope(store: store, child: controls),
        ),
      );
    }

    final light = PersonalTheme(name: 'Light', preset: 'default', radius: 8);
    final dark = PersonalTheme(name: 'Dark', preset: 'dark1', radius: 20, fontScale: 1.5);
    const base = PrimeThemeData();
    final lightMaterial = applyPersonalThemeData(base.toThemeData(), light);
    final darkMaterial = applyPersonalThemeData(base.toThemeData(), dark);
    final lightPrime = resolvePersonalPrimeTheme(base, lightMaterial, light);
    final darkPrime = resolvePersonalPrimeTheme(base, darkMaterial, dark);
    await tester.pumpWidget(app(lightPrime, lightMaterial, 'en'));
    await tester.pumpAndSettle();
    expect(find.text('Operational Anomaly Detected'), findsOneWidget);
    expect(find.text('Retry Hydration'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField), 'unsaved reference');
    final originalState = tester.state(find.byType(EditableText));
    final originalFontSize = tester.widget<TextField>(find.byType(TextField)).style!.fontSize!;

    void expectPreservedDraft() {
      expect(tester.state(find.byType(EditableText)), same(originalState));
      expect(tester.widget<EditableText>(find.byType(EditableText)).controller.text, 'unsaved reference');
      expect(tester.takeException(), isNull);
    }

    // Locale-only change: both theme instances and the child are identical.
    await tester.pumpWidget(app(lightPrime, lightMaterial, 'fr'));
    await tester.pumpAndSettle();
    expect(find.text('Anomalie de fonctionnement détectée'), findsOneWidget);
    expect(find.text('Réessayer'), findsOneWidget);
    expect(find.text('Retry Hydration'), findsNothing);
    expectPreservedDraft();

    // Theme-only change: the locale remains French.
    await tester.pumpWidget(app(darkPrime, darkMaterial, 'fr'));
    await tester.pumpAndSettle();
    expect(find.text('Réessayer'), findsOneWidget);
    final material = tester.widget<MaterialApp>(find.byType(MaterialApp)).theme!;
    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.decoration!.fillColor, material.colorScheme.surface);
    expect(field.style!.color, material.colorScheme.onSurface);
    expect(field.style!.fontSize, closeTo(originalFontSize * 1.5, 0.001));
    final card = tester.widget<Card>(find.byType(Card));
    expect(card.color, material.colorScheme.surface);
    expect((card.shape! as RoundedRectangleBorder).borderRadius, BorderRadius.circular(20));
    expectPreservedDraft();

    // Notify the live catalog without pumping a replacement app/screen.
    version = 1;
    await store.refresh();
    await tester.pumpAndSettle();
    expect(find.text('Updated error fr v1'), findsOneWidget);
    expect(find.text('Updated retry fr v1'), findsOneWidget);
    expect(find.text('Réessayer'), findsNothing);
    expectPreservedDraft();
    await tester.tap(find.byType(ElevatedButton));
    expect(retries, 1);

    await tester.pumpWidget(app(lightPrime, lightMaterial, 'es'));
    await tester.pumpAndSettle();
    expect(find.text('Updated error es v1'), findsOneWidget);
    expect(find.text('Updated retry es v1'), findsOneWidget);
    expect(tester.widget<TextField>(find.byType(TextField)).style!.fontSize, originalFontSize);
    expectPreservedDraft();

    version = 2;
    await store.refresh();
    await tester.pumpAndSettle();
    expect(find.text('Updated retry es v2'), findsOneWidget);
    expect(find.text('Updated retry es v1'), findsNothing);
    expectPreservedDraft();
    await tester.pumpWidget(app(darkPrime, darkMaterial, 'en'));
    await tester.pumpAndSettle();
    expect(find.text('Updated retry en v2'), findsOneWidget);
    expectPreservedDraft();
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
