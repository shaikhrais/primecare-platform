import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/src/localization/live_screen_text.dart';
import 'package:primecare_ui/src/features/auth/password_recovery_form.dart';
import 'package:primecare_ui/src/localization/auth_screen_text_generated.dart';
import 'auth_design_test.dart' show localized;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() => SharedPreferences.setMockInitialValues({}));
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });
  for (final language in ['en', 'fr', 'es']) {
    for (final reset in [false, true]) {
      testWidgets('recovery $reset refresh preserves drafts and localizes validation in $language', (tester) async {
        var edited = false;
        final client = MockClient((request) async {
          if (request.url.path.endsWith('/screen-text')) {
            return http.Response(jsonEncode({'screens': [{'id': 'password_recovery', 'version': edited ? 1 : 0}]}), 200, headers: {'content-type': 'application/json; charset=utf-8'}, encoding: utf8);
          }
          return http.Response(jsonEncode({'screen': 'password_recovery', 'version': edited ? 1 : 0, 'locales': {
            for (final locale in ['en', 'fr', 'es']) locale: {
              ...passwordRecoveryScreenCatalog[locale]!,
              if (edited) 'email': 'Edited $locale',
              if (edited) 'invalid_email': 'Validation $locale',
            },
          }}), 200, headers: {'content-type': 'application/json; charset=utf-8'}, encoding: utf8);
        });
        final store = LiveScreenTextStore(client: client, baseUrl: 'https://test');
        addTearDown(store.dispose);
        await tester.pumpWidget(ProviderScope(child: localized(LiveScreenTextScope(
          store: store,
          child: Scaffold(body: PasswordRecoveryForm(reset: reset)),
        ), language: language)));
        await tester.pumpAndSettle();
        final fields = find.byType(TextField);
        expect(fields, findsNWidgets(reset ? 4 : 1));
        expect(find.text(passwordRecoveryScreenCatalog[language]!['email']!), findsOneWidget);
        await tester.enterText(fields.first, 'unsaved-invalid-email');
        if (reset) await tester.enterText(fields.at(2), 'unsaved-secret');
        await tester.tap(find.byType(FilledButton));
        await tester.pump();
        expect(find.text(passwordRecoveryScreenCatalog[language]!['invalid_email']!), findsOneWidget);
        edited = true;
        await store.refresh();
        await tester.pumpAndSettle();
        expect(store.text('password_recovery', language, 'email'), 'Edited $language');
        expect(tester.widget<TextField>(fields.first).decoration!.labelText, 'Edited $language');
        expect(find.text('Validation $language'), findsOneWidget);
        expect(tester.widget<TextField>(fields.first).controller!.text, 'unsaved-invalid-email');
        if (reset) {
          expect(tester.widget<TextField>(fields.at(2)).controller!.text, 'unsaved-secret');
          expect(tester.widget<TextField>(fields.at(2)).obscureText, isTrue);
        }
        await tester.pumpWidget(const SizedBox.shrink());
      });
    }
  }
}
