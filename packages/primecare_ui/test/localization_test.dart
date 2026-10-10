import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_core/primecare_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

void main() {
  tearDown(() => applicationLanguage.selectLanguage(SupportedLanguage.en));
  for (final language in SupportedLanguage.values) {
    testWidgets('Inherited Admin labels and denial are localized in ${language.name}', (tester) async {
      applicationLanguage.selectLanguage(language);
      final strings = AppStrings(language.name);
      Future<Map<String,dynamic>> request(String method,String path,{Map<String,dynamic>? body}) async => throw const AuthFailure('Forbidden',status:403);
      await tester.pumpWidget(MaterialApp(locale: Locale(language.name), supportedLocales: AppStrings.locales, localizationsDelegates: AppStrings.delegates, home: AdminScreen(request: request)));
      await tester.pumpAndSettle();
      expect(find.text(strings.text('admin.workspace')), findsOneWidget);
      expect(find.text(strings.text('error.forbidden')), findsOneWidget);
      expect(find.text(strings.text('admin.create')), findsOneWidget);
      expect(tester.widget<FilledButton>(find.widgetWithText(FilledButton,strings.text('admin.create'))).onPressed,isNull);
      expect(strings.text('admin.counts',{'total':3,'active':2}), isNot(contains('{')));
    });
  }
}
