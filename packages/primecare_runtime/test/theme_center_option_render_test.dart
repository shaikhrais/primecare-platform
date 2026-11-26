import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:primecare_runtime/auth_service.dart';
import 'package:primecare_runtime/providers/persistence_providers.dart';
import 'package:primecare_runtime/registry/widgets/theme_center_panel.dart';
import 'theme_center_test.dart' show TestThemeAuth;

void main() {
  testWidgets('existing editor resolves the registered disabled label in all locales', (tester) async {
    for (final entry in {'en':'Disabled text','fr':'Texte désactivé','es':'Texto deshabilitado'}.entries) {
      await tester.pumpWidget(Localizations(locale:Locale(entry.key),
        delegates:const [DefaultWidgetsLocalizations.delegate],
        child:Builder(builder:(context)=>Text(themeCenterText(context,'color.disabled')))));
      expect(find.text(entry.value),findsOneWidget);
      expect(tester.takeException(),isNull);
    }
  });

  testWidgets('opening the existing full color editor does not crash on the disabled field', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs=await SharedPreferences.getInstance();
    await tester.pumpWidget(ProviderScope(overrides:[
      sharedPreferencesProvider.overrideWithValue(prefs),
      authProvider.overrideWith(()=>TestThemeAuth(AuthState(isAuthenticated:true,
        userId:'label-fixture',tenantId:'fixture',role:'admin',preferredLanguage:'en'))),
    ],child:const MaterialApp(home:Scaffold(body:SingleChildScrollView(child:ThemeCenterPanel())))));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Edit current'));
    await tester.pumpAndSettle();
    expect(find.text('Edit theme'),findsOneWidget);
    expect(find.text('Disabled text'),findsOneWidget);
    expect(tester.takeException(),isNull);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
  });
}
