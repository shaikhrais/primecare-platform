import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/features/auth/mfa_form.dart';
import 'package:primecare_ui/src/features/auth/mfa_catalog.g.dart';
import 'auth_design_test.dart' show localized, GuestAuth;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async { SharedPreferences.setMockInitialValues({}); await EasyLocalization.ensureInitialized(); });
  for (final language in ['en','fr','es']) {
    testWidgets('MFA setup fits small viewport in $language; wrong code clears, cancel removes challenge', (tester) async {
      final semantics = tester.ensureSemantics();
      try {
      tester.view.physicalSize = const Size(320, 1200); tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
      final container=ProviderContainer(overrides:[authProvider.overrideWith(GuestAuth.new)]);addTearDown(container.dispose);
      final controller=container.read(mfaControllerProvider.notifier);
      var submitted='';
      final pending=controller.request({'purpose':'enroll','challenge':List.filled(43,'a').join(),'setupKey':List.filled(32,'A').join()},(code) async {submitted=code;return false;});
      await tester.pumpWidget(UncontrolledProviderScope(container:container,child:localized(Scaffold(body:SingleChildScrollView(child:MediaQuery(data:const MediaQueryData(textScaler:TextScaler.linear(2)),child:const NativeMfaForm()))),language:language)));
      await tester.pumpAndSettle();expect(tester.takeException(),isNull);
      expect(find.text(nativeMfaText[language]!['setup']!),findsOneWidget);
      final seedControl=find.byWidgetPredicate((widget)=>widget is Cy && widget.id=='mfa-seed');
      final seedSemantics=tester.getSemantics(seedControl).getSemanticsData();
      expect(seedSemantics.label.split('\n'),['mfa-seed',List.filled(32,'A').join()]);
      expect(seedSemantics.value,isEmpty);
      final field=find.byType(TextFormField);expect(field,findsOneWidget);
      await tester.enterText(field,'123456');await controller.verify();await tester.pumpAndSettle();
      expect(submitted,'123456');expect(container.read(mfaControllerProvider).code,'');expect(container.read(mfaControllerProvider).failed,true);
      // No intermediate pump: a fast failure must clear the rendered digits
      // even when the old/new widget initialValue are both empty.
      expect(tester.widget<TextFormField>(field).controller!.text, isEmpty);
      expect(find.text(nativeMfaText[language]!['error']!),findsOneWidget);
      await tester.enterText(field, '12');
      await controller.verify();await tester.pumpAndSettle();
      expect(tester.widget<TextFormField>(field).controller!.text, isEmpty);
      expect(submitted, '123456');
      controller.cancel();await pending;await tester.pumpAndSettle();
      expect(container.read(mfaControllerProvider).challenge,isNull);expect(find.byType(TextFormField),findsNothing);
      } finally { semantics.dispose(); }
    });
  }
  test('codes outside an active challenge are ignored', () {
    final container=ProviderContainer();addTearDown(container.dispose);
    final controller=container.read(mfaControllerProvider.notifier);
    controller.onCodeChanged('123456');
    expect(container.read(mfaControllerProvider).code, isEmpty);
    expect(container.read(mfaControllerProvider).pending, isFalse);
  });
  testWidgets('enrolled challenge never displays setup key and confirmation clears transient state', (tester) async {
    final container=ProviderContainer(overrides:[authProvider.overrideWith(GuestAuth.new)]);addTearDown(container.dispose);
    final controller=container.read(mfaControllerProvider.notifier);
    final pending=controller.request({'purpose':'verify','challenge':List.filled(43,'a').join()},(code) async =>true);
    await tester.pumpWidget(UncontrolledProviderScope(container:container,child:localized(const Scaffold(body:NativeMfaForm()))));await tester.pumpAndSettle();
    expect(find.byType(SelectableText),findsNothing);controller.onCodeChanged('123456');await controller.verify();await pending;await tester.pumpAndSettle();expect(container.read(mfaControllerProvider).pending,false);
  });
}
