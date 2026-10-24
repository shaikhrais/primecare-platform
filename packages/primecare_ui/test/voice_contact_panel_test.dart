import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/business_core.dart';
import 'package:primecare_ui/src/communications/communication_workspace.dart';
import 'package:primecare_ui/src/theme/prime_theme.dart';
import '../../flutter_core/test/fixtures/voice_contact_transport.dart';
void main(){
 late VoiceContactTransport transport;late VoiceContactController model;
 setUp((){transport=VoiceContactTransport();model=VoiceContactController(hub:CommunicationHub(transport));});
 tearDown(()=>model.dispose());
 Finder control(String key)=>find.byKey(Key(CommunicationWorkspaceCatalog.id(key)));
 Finder input(String key)=>find.descendant(of:control(key),matching:find.byType(TextFormField));
 Widget app(String language)=>PrimeTheme(data:const PrimeThemeData(),child:MaterialApp(home:Scaffold(body:SingleChildScrollView(child:VoiceContactVerificationPanel(model:model,language:language)))));
 Future<void> tap(WidgetTester tester,String key) async {await tester.ensureVisible(control(key));await tester.tap(control(key));await tester.pumpAndSettle();}
 testWidgets('registered panel sends once, hides and clears code, and displays only server-approved verification',(tester) async {
  await tester.pumpWidget(app('en'));await tester.pumpAndSettle();expect(transport.sends,0);await tester.enterText(input('phoneNumber'),'+14165550101');await tap(tester,'phoneSend');expect(transport.sends,1);expect(tester.widget<TextFormField>(input('phoneNumber')).controller!.text,isEmpty);
  expect(tester.widget<TextField>(find.descendant(of:control('phoneCode'),matching:find.byType(TextField))).obscureText,true);
  await tester.enterText(input('phoneCode'),'123456');await tap(tester,'phoneCheck');expect(transport.checks,1);expect(tester.widget<TextFormField>(input('phoneCode')).controller!.text,isEmpty);expect(find.text('Your account phone is verified.'),findsOneWidget);expect(tester.takeException(),isNull);
 });
 testWidgets('uncertain send offers status refresh without another SMS and never displays provider details',(tester) async {
  transport.sendUnknown=true;await tester.pumpWidget(app('en'));await tester.pumpAndSettle();await tester.enterText(input('phoneNumber'),'+14165550101');await tap(tester,'phoneSend');expect(transport.sends,1);expect(find.textContaining('PRIVATE'),findsNothing);await tap(tester,'phoneRefresh');expect(model.canSend,false);expect(transport.sends,1);
 });
 testWidgets('all registered locales render controls at narrow width and large text',(tester) async {
  tester.view.physicalSize=const Size(390,844);tester.view.devicePixelRatio=1;addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
  for(final locale in ['en','fr','es']){await tester.pumpWidget(app(locale));await tester.pumpAndSettle();expect(find.text(CommunicationWorkspaceCatalog.text(locale,'phoneVerification')),findsOneWidget);expect(control('phoneSend'),findsOneWidget);expect(tester.takeException(),isNull);}
 });
}
