import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:primecare_ui/src/features/auth/mfa_controller.dart';
import 'package:primecare_ui/src/features/auth/reset_password_controller.dart';
import 'auth_design_test.dart' show localized;

const messages = {
  'en': 'This authentication feature is not available yet. Please contact your administrator.',
  'es': 'Esta función de autenticación aún no está disponible. Comuníquese con su administrador.',
  'fr': 'Cette fonctionnalité d’authentification n’est pas encore disponible. Veuillez contacter votre administrateur.',
};

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  test('all nine apps and both shared catalogs provide the unavailable message in en/es/fr', () {
    const apps = ['primecare_business_development', 'primecare_client', 'primecare_clinic',
      'primecare_corporate', 'primecare_enterprise_blueprint', 'primecare_franchise',
      'primecare_governance', 'primecare_marketing', 'primecare_support'];
    final roots = [for (final app in apps) '../../apps/$app/assets/translations',
      '../flutter_core/assets/translations', '../flutter_core/lib/src/localization'];
    for (final root in roots) {
      for (final language in messages.keys) {
        final data = jsonDecode(File('$root/$language.json').readAsStringSync()) as Map<String, dynamic>;
        expect(data['auth_flow_unavailable'], messages[language], reason: '$root/$language');
      }
    }
  });

  for (final language in messages.keys) {
    testWidgets('unavailable MFA and reset show $language text and keep success false', (tester) async {
      await tester.pumpWidget(ProviderScope(child: localized(Scaffold(
        body: Consumer(builder: (context, ref, _) => Column(children: [
          Text(ref.watch(mfaControllerProvider).errorMessage ?? ''),
          Text(ref.watch(resetPasswordControllerProvider).errorMessage ?? ''),
        ])),
      ), language: language)));
      await tester.pumpAndSettle();
      final context = tester.element(find.byType(Scaffold));
      await context.setLocale(Locale(language));
      await tester.pumpAndSettle();
      final container = ProviderScope.containerOf(context);
      final mfa = container.read(mfaControllerProvider.notifier);
      mfa.onCodeChanged('000000');
      await mfa.verify();
      final reset = container.read(resetPasswordControllerProvider.notifier);
      reset.onNewPasswordChanged('synthetic-fixture-only');
      reset.onConfirmPasswordChanged('synthetic-fixture-only');
      await reset.submit();
      await tester.pumpAndSettle();
      expect(container.read(mfaControllerProvider).isVerified, isFalse);
      expect(container.read(resetPasswordControllerProvider).isSuccess, isFalse);
      expect(find.text(messages[language]!), findsNWidgets(2));
      expect(find.text('auth_flow_unavailable'), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }
}
