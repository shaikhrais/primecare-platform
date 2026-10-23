import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/business_core.dart';
import 'package:primecare_ui/src/communications/communication_workspace.dart';
import 'package:primecare_ui/src/theme/prime_theme.dart';
import '../../flutter_core/test/fixtures/communication_channels_transport.dart';
import '../../flutter_core/test/fixtures/communication_workspace_transport.dart';

void main(){
 late ChannelsTransport transport;late CommunicationWorkspaceController messages;late CommunicationMailController mail;late CommunicationCallController calls;MediaFixture? media;var serial=0;
 setUp((){
  transport=ChannelsTransport();media=null;final hub=CommunicationHub(transport);String key()=> 'widget-channel-${serial++}';
  messages=CommunicationWorkspaceController(hub:hub,userId:'alice',tenantId:'tenant-a',key:key);
  mail=CommunicationMailController(hub:hub,userId:'alice',tenantId:'tenant-a',key:key);
  calls=CommunicationCallController(hub:hub,userId:'alice',tenantId:'tenant-a',key:key,mediaFactory:({required hub,required userId,required tenantId,required threadId,required callId,required onState}) async {media=MediaFixture(onState);return media!;});calls.selectThread('thread');
 });
 tearDown((){messages.dispose();mail.dispose();calls.dispose();});
 Widget app({String language='en',double scale=1})=>ProviderScope(child:PrimeTheme(data:const PrimeThemeData(),child:MaterialApp(builder:(context,child)=>MediaQuery(data:MediaQuery.of(context).copyWith(textScaler:TextScaler.linear(scale)),child:child!),home:CommunicationWorkspaceView(key:ObjectKey(messages),controller:messages,mailController:mail,callController:calls,language:language))));
 Finder control(String id)=>find.byKey(Key(id));
 Finder input(String id)=>find.descendant(of:control(id),matching:find.byType(TextFormField));
 Future<void> tap(WidgetTester tester,String id) async {await tester.ensureVisible(control(id));await tester.tap(control(id));await tester.pumpAndSettle();}
 Future<void> draft(WidgetTester tester) async {await tester.enterText(input('communication-mail-to'),'recipient@example.invalid');await tester.enterText(input('communication-mail-subject'),'A subject');await tester.enterText(input('communication-mail-body'),'A private body');}
 testWidgets('email queue and delivery controls call shared core and display provider acceptance honestly',(tester) async {
  await tester.pumpWidget(app());await tester.pumpAndSettle();await draft(tester);await tap(tester,'communication-mail-queue');expect(transport.deliveries,0);expect(mail.selected!['status'],'queued');
  await tap(tester,'communication-mail-deliver');expect(transport.deliveries,1);expect(find.text('Accepted by the provider. Recipient delivery is not confirmed.'),findsOneWidget);expect(tester.takeException(),isNull);
 });
 testWidgets('ambiguous mail queue keeps draft and explicit confirmation creates no duplicate',(tester) async {
  await tester.pumpWidget(app());await tester.pumpAndSettle();await draft(tester);transport.loseMailQueue=true;await tap(tester,'communication-mail-queue');
  expect(tester.widget<TextFormField>(input('communication-mail-body')).controller!.text,'A private body');expect(control('communication-mail-retry'),findsOneWidget);await tap(tester,'communication-mail-retry');expect(transport.mail.length,1);expect(tester.widget<TextFormField>(input('communication-mail-body')).controller!.text,isEmpty);
 });
 testWidgets('inbound envelope and quarantine warning render without raw message content',(tester) async {
  transport.received('received');await tester.pumpWidget(app());await tester.pumpAndSettle();await tester.enterText(input('communication-mailbox'),'owned-box');await tap(tester,'communication-mail-inbound');await tap(tester,'communication-mail-open-0');
  expect(find.text('outside@example.invalid'),findsOneWidget);expect(find.textContaining('PRIVATE RAW MIME'),findsNothing);expect(find.textContaining('Received in quarantine.'),findsWidgets);expect(tester.takeException(),isNull);
 });
 testWidgets('calls invite, refresh and end through shared inherited controls',(tester) async {
  await calls.refresh();await tester.pumpWidget(app());await tester.pumpAndSettle();await tester.enterText(input('communication-call-recipient'),'bob');await tap(tester,'communication-call-invite');expect(calls.calls.single['status'],'ringing');
  await tap(tester,'communication-call-end-0');expect(calls.calls.single['status'],'ended');expect(find.text('Ended'),findsOneWidget);
 });
 testWidgets('accepted call connects media and the mute/end controls release resources',(tester) async {
  transport.record['calls']=[{'id':'call','callerId':'alice','recipientId':'bob','status':'accepted'}];await calls.refresh();await tester.pumpWidget(app());await tester.pumpAndSettle();await tap(tester,'communication-call-connect-0');expect(media!.starts,1);expect(find.text('Audio connected'),findsOneWidget);
  await tap(tester,'communication-call-mute');expect(media!.muted,true);expect(find.text('Microphone muted'),findsOneWidget);await tap(tester,'communication-call-end-0');expect(media!.closed,true);
 });
 testWidgets('permission loss removes private email body without provider-error text',(tester) async {
  await mail.queue('recipient@example.invalid','A subject','A private body');await tester.pumpWidget(app());await tester.pumpAndSettle();expect(find.text('A private body'),findsOneWidget);
  transport.nextFailure=denied(403);await tap(tester,'communication-mail-refresh');expect(find.text('A private body'),findsNothing);expect(find.textContaining('private provider detail'),findsNothing);
 });
 testWidgets('all channel panels fit narrow screens with scaled French text and live status semantics',(tester) async {
  tester.view.physicalSize=const Size(390,844);tester.view.devicePixelRatio=1;addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(app(language:'fr-CA',scale:1.5));await tester.pumpAndSettle();expect(find.text('Courriel'),findsOneWidget);expect(find.text('Appels audio'),findsOneWidget);expect(tester.takeException(),isNull);
  expect(tester.widgetList<Semantics>(find.byType(Semantics)).where((s)=>s.properties.liveRegion==true).length,greaterThanOrEqualTo(3));
 });
 testWidgets('unverified received text is rendered as Text under the quarantine warning, without remote images',(tester) async {
  transport.received('received');transport.mail['received']!['contentPreview']={'status':'available','text':'Literal <img src="https://synthetic.invalid/tracker">','subject':'Unverified received subject'};
  await tester.pumpWidget(app());await tester.pumpAndSettle();await tester.enterText(input('communication-mailbox'),'owned-box');await tap(tester,'communication-mail-inbound');await tap(tester,'communication-mail-open-0');
  expect(find.text('Unverified text preview'),findsOneWidget);expect(find.text('Literal <img src="https://synthetic.invalid/tracker">'),findsOneWidget);expect(find.byType(Image),findsNothing);expect(find.textContaining('Received in quarantine.'),findsWidgets);expect(tester.takeException(),isNull);
 });
 testWidgets('unavailable preview never displays partial body or parser details',(tester) async {
  transport.received('received');transport.mail['received']!['contentPreview']={'status':'unavailable'};transport.mail['received']!['text']='PRIVATE PARTIAL';
  await tester.pumpWidget(app(language:'fr'));await tester.pumpAndSettle();await tester.enterText(input('communication-mailbox'),'owned-box');await tap(tester,'communication-mail-inbound');await tap(tester,'communication-mail-open-0');
  expect(find.text('Aperçu du texte indisponible. Ce courriel reste en quarantaine.'),findsOneWidget);expect(find.textContaining('PRIVATE PARTIAL'),findsNothing);expect(tester.takeException(),isNull);
 });

}
