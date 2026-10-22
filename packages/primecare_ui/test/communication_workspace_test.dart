import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/communications/communication_core.dart';
import 'package:flutter_core/communications/communication_workspace_controller.dart';
import 'package:flutter_core/auth_service.dart';
import 'package:flutter_core/src/network/api_client.dart';
import 'package:primecare_ui/src/communications/communication_workspace.dart';
import 'package:primecare_ui/src/theme/prime_theme.dart';
import 'package:primecare_ui/src/screens/staff/communication/communication_screen.dart';
import 'package:primecare_ui/src/screens/common/patient_messages/patient_messages_screen.dart';
import 'package:primecare_ui/src/screens/psw/messaging/messaging_screen.dart';
import 'package:primecare_ui/src/screens/psw/psw_messages/psw_messages_screen.dart';
import '../../flutter_core/test/fixtures/communication_workspace_transport.dart';

class WorkspaceSessionFixture extends AuthNotifier {
 @override AuthState build()=>AuthState(isInitialized:true,isAuthenticated:true,userId:'alice',tenantId:'tenant-a',token:'synthetic-session-a');
 void replace(AuthState value){state=value;}
}

void main(){
 TestWidgetsFlutterBinding.ensureInitialized();
 late FixtureTransport transport;late CommunicationWorkspaceController controller;var key=0;
 setUp((){transport=FixtureTransport();controller=CommunicationWorkspaceController(hub:CommunicationHub(transport),userId:'alice',tenantId:'tenant-a',key:()=> 'widget-${key++}');});
 tearDown(()=>controller.dispose());
 Widget app({String language='en',double textScale=1,ThemeData? theme,CommunicationPicturePicker? picker})=>ProviderScope(child:PrimeTheme(data:const PrimeThemeData(),child:MaterialApp(theme:theme,builder:(context,child)=>MediaQuery(data:MediaQuery.of(context).copyWith(textScaler:TextScaler.linear(textScale)),child:child!),home:CommunicationWorkspaceView(key:ObjectKey(controller),controller:controller,language:language,picturePicker:picker))));
 Finder control(String id)=>find.byKey(Key(id));
 Finder input(String id)=>find.descendant(of:control(id),matching:find.byType(TextFormField));
 Future<void> tap(WidgetTester tester,String id) async {await tester.ensureVisible(control(id));await tester.tap(control(id));await tester.pumpAndSettle();}
 test('all four existing entry classes inherit the same workspace',(){
  for(final screen in [const CommunicationScreen(),const PatientMessagesScreen(),const MessagingScreen(),const MessagesScreen()])expect(screen,isA<CommunicationScreenBase>());
  expect(CommunicationScreenBase.implementationTags['productionReady'],false);
 });
 test('session-dependent provider disposes private state on account change and logout',() async {
  final dio=Dio(BaseOptions(baseUrl:'https://synthetic.invalid'));
  dio.interceptors.add(InterceptorsWrapper(onRequest:(options,handler)=>handler.resolve(Response(requestOptions:options,statusCode:200,data:{'items':[clone(transport.record)]}))));
  final container=ProviderContainer(overrides:[authProvider.overrideWith(WorkspaceSessionFixture.new),apiClientProvider.overrideWith((ref)=>ApiClient(ref,transport:dio))]);
  final subscription=container.listen(communicationWorkspaceControllerProvider,(previous,next){},fireImmediately:true);
  try{
   final first=container.read(communicationWorkspaceControllerProvider)!;expect(await first.loadInbox(),true);expect(first.inbox,isNotEmpty);
   (container.read(authProvider.notifier) as WorkspaceSessionFixture).replace(AuthState(isInitialized:true,isAuthenticated:true,userId:'bob',tenantId:'tenant-b',token:'synthetic-session-b'));
   final second=container.read(communicationWorkspaceControllerProvider)!;expect(identical(first,second),false);expect(first.isDisposed,true);expect(first.inbox,isEmpty);expect(second.userId,'bob');expect(second.tenantId,'tenant-b');
   (container.read(authProvider.notifier) as WorkspaceSessionFixture).replace(AuthState(isInitialized:true));expect(container.read(communicationWorkspaceControllerProvider),isNull);expect(second.isDisposed,true);
  }finally{subscription.close();container.dispose();dio.close(force:true);}
 });
 testWidgets('inbox open, send and reload render the actual returned message', (tester) async {
  await tester.pumpWidget(app());await tester.pumpAndSettle();
  await tap(tester,'communication-thread-open-0');await tester.enterText(input('communication-composer'),'Hello through shared UI');await tap(tester,'communication-send');
  expect(find.text('Hello through shared UI'),findsOneWidget);expect(tester.widget<TextFormField>(input('communication-composer')).controller!.text,isEmpty);
  expect(transport.requests.where((r)=>r['action']=='send').length,1);expect(tester.takeException(),isNull);
 });
 testWidgets('draft survives an uncertain send and explicit retry does not duplicate it', (tester) async {
  await tester.pumpWidget(app());await tester.pumpAndSettle();await tap(tester,'communication-thread-open-0');transport.loseSendReceipt=true;
  await tester.enterText(input('communication-composer'),'Keep my draft');await tap(tester,'communication-send');
  expect(tester.widget<TextFormField>(input('communication-composer')).controller!.text,'Keep my draft');expect(control('communication-retry'),findsOneWidget);
  await tap(tester,'communication-retry');expect((transport.record['messages'] as List).length,1);expect(find.text('Keep my draft'),findsOneWidget);
 });
 testWidgets('recipient and task inputs dispatch through the inherited client', (tester) async {
  await tester.pumpWidget(app());await tester.pumpAndSettle();await tester.enterText(input('communication-members'),'bob');await tester.enterText(input('communication-reference'),'');await tap(tester,'communication-create');
  final request=transport.requests.firstWhere((r)=>r['action']=='create');expect(request['members'],['alice','bob']);expect(request.containsKey('tenantId'),false);expect(controller.thread,isNotNull);
 });
 testWidgets('permission failure shows safe text and clears private conversation content', (tester) async {
  await tester.pumpWidget(app());await tester.pumpAndSettle();await tap(tester,'communication-thread-open-0');
  await tester.enterText(input('communication-composer'),'Private fixture');await tap(tester,'communication-send');transport.nextFailure=denied(403);await tap(tester,'communication-refresh');
  expect(find.text('Private fixture'),findsNothing);expect(find.text('You do not have access to this communication.'),findsOneWidget);expect(find.textContaining('private provider detail'),findsNothing);
 });
 testWidgets('picture selection, attachment and private preview share the same controller', (tester) async {
  transport.png=base64Decode('iVBORw0KGgoAAAANSUhEUgAAAAIAAAACCAYAAABytg0kAAAAFElEQVR4nGPUCKj4z8DAwMDEAAUAHNgB8zfAN28AAAAASUVORK5CYII=');
  await tester.pumpWidget(app(picker:() async=>CommunicationPictureSelection(length:transport.png.length,bytes:Stream.value(transport.png))));await tester.pumpAndSettle();await tap(tester,'communication-thread-open-0');await tap(tester,'communication-picture-pick');
  expect(control('communication-picture-remove-0'),findsOneWidget);await tap(tester,'communication-send');expect((transport.record['messages'] as List).single['pictureIds'],['picture']);
  await tap(tester,'communication-picture-open-0-0');expect(find.byType(Image),findsOneWidget);expect(tester.takeException(),isNull);
 });
 testWidgets('mobile layout supports large text and live localized status semantics', (tester) async {
  tester.view.physicalSize=const Size(390,844);tester.view.devicePixelRatio=1;addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(app(language:'fr-CA',textScale:1.5));await tester.pumpAndSettle();
  expect(find.text('Actualiser'),findsOneWidget);expect(find.text('Démarrer une conversation'),findsOneWidget);expect(tester.takeException(),isNull);
  final semantics=tester.widgetList<Semantics>(find.byType(Semantics));expect(semantics.any((s)=>s.properties.liveRegion==true),true);
 });
 testWidgets('the approved input is disabled during work and uses the active theme surface', (tester) async {
  final dark=ThemeData.dark();await tester.pumpWidget(app(theme:dark));await tester.pumpAndSettle();
  final field=tester.widget<TextField>(find.descendant(of:control('communication-members'),matching:find.byType(TextField)));expect(field.decoration?.fillColor,dark.colorScheme.surface);expect(field.style?.color,dark.colorScheme.onSurface);
  final waiting=Completer<Map<String,Object?>>();transport.pendingRead=waiting;final reading=controller.openThread('thread');await tester.pump();
  expect(tester.widget<TextFormField>(input('communication-members')).enabled,false);waiting.complete(clone(transport.record));await reading;await tester.pumpAndSettle();
 });
 testWidgets('removing a session-owned view cannot display a late private response', (tester) async {
  await tester.pumpWidget(app());await tester.pumpAndSettle();final waiting=Completer<Map<String,Object?>>();transport.pendingRead=waiting;final reading=controller.openThread('thread');
  controller.dispose();await tester.pumpWidget(const MaterialApp(home:Text('Signed out fixture')));waiting.complete(clone(transport.record));await reading;await tester.pumpAndSettle();
  expect(control('communication-workspace'),findsNothing);expect(find.text('Signed out fixture'),findsOneWidget);expect(tester.takeException(),isNull);
 });
}
