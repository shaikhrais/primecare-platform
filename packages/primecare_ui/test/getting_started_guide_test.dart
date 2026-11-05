import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/src/localization/live_screen_text.dart';
import 'package:primecare_ui/src/features/platform/platform_master_screen.dart';
import 'package:primecare_ui/src/features/training/getting_started_guide.dart';
import 'package:primecare_ui/src/features/training/getting_started_catalog.g.dart';
void main(){
 testWidgets('guide explains organization and advances without domain mutations',(tester)async{
  await tester.pumpWidget(ProviderScope(overrides:[platformAdministrationAccessProvider.overrideWith((ref)async=>false)],child:const MaterialApp(home:GettingStartedGuide())));
  await tester.pumpAndSettle();expect(find.text('Welcome to your workspace'),findsOneWidget);
  await tester.ensureVisible(find.text('Next step'));await tester.tap(find.text('Next step'));await tester.pumpAndSettle();
  expect(find.text('Organization and tenants'),findsOneWidget);expect(find.text('Open dashboard'),findsNothing);
  await tester.ensureVisible(find.text('Back'));await tester.tap(find.text('Back'));await tester.pumpAndSettle();expect(find.text('Welcome to your workspace'),findsOneWidget);
 });
 testWidgets('guide controls follow locale changes without resetting the current step',(tester)async{
  final locale=ValueNotifier(const Locale('en'));
  addTearDown(locale.dispose);
  await tester.pumpWidget(ProviderScope(overrides:[platformAdministrationAccessProvider.overrideWith((ref)async=>false)],
    child:ValueListenableBuilder<Locale>(valueListenable:locale,builder:(context,value,_)=>MaterialApp(
      locale:value,supportedLocales:const [Locale('en'),Locale('fr'),Locale('es')],
      localizationsDelegates:const [GlobalMaterialLocalizations.delegate,GlobalWidgetsLocalizations.delegate,GlobalCupertinoLocalizations.delegate],
      home:const GettingStartedGuide()))));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Next step'));await tester.pumpAndSettle();
  expect(find.text('Step 2 of ${gettingStartedSteps.length}'),findsOneWidget);
  locale.value=const Locale('fr');await tester.pumpAndSettle();
  expect(find.text('Guide de démarrage'),findsOneWidget);
  expect(find.text('Étape 2 sur ${gettingStartedSteps.length}'),findsOneWidget);
  expect(find.text('Organisation et locataires'),findsOneWidget);
  expect(find.text('Étape suivante'),findsOneWidget);
  locale.value=const Locale('es');await tester.pumpAndSettle();
  expect(find.text('Guía para empezar'),findsOneWidget);
  expect(find.text('Paso 2 de ${gettingStartedSteps.length}'),findsOneWidget);
  expect(find.text('Organización y entidades'),findsOneWidget);
  expect(find.text('Siguiente paso'),findsOneWidget);
  expect(tester.takeException(),isNull);
 });
 testWidgets('live guide text updates without resetting progress',(tester)async{
  SharedPreferences.setMockInitialValues({});
  final initial={for(final lang in ['en','fr','es'])lang:{'step_2_title':'Original $lang'}};
  final client=MockClient((request) async => http.Response(jsonEncode(
    request.url.path.endsWith('/screen-text')
      ? {'screens':[{'id':'getting_started_guide','version':0}]}
      : {'screen':'getting_started_guide','version':0,'locales':initial}),200));
  final store=LiveScreenTextStore(baseUrl:'https://fixture.test',client:client);
  addTearDown(store.dispose);
  await tester.pumpWidget(ProviderScope(overrides:[platformAdministrationAccessProvider.overrideWith((ref)async=>false)],
    child:MaterialApp(home:LiveScreenTextScope(store:store,child:const GettingStartedGuide()))));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Next step'));await tester.pumpAndSettle();
  expect(find.text('Original en'),findsOneWidget);
  await store.saveLocal('getting_started_guide',{
    for(final lang in ['en','fr','es'])lang:{'step_2_title':'Updated $lang'},
  });
  await tester.pumpAndSettle();
  expect(find.text('Updated en'),findsOneWidget);
  expect(find.text('Step 2 of ${gettingStartedSteps.length}'),findsOneWidget);
  expect(tester.takeException(),isNull);
 });
}
