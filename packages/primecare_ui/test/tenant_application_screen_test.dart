import 'dart:async';
import 'dart:convert';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_core/dashboard_pages.dart';
import 'package:flutter_core/work_modules.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/features/tenant_applications/tenant_application_screen.dart';
import 'package:primecare_ui/src/features/tenant_applications/tenant_application_catalog.g.dart';
import 'package:primecare_ui/src/screens/screen_manager_catalog.dart';

final capturedToken=List.filled(43,'a').join();
AuthState identity({String user='user-a',String tenant='tenant-a',String role='tenant_admin',bool authenticated=true})=>
  AuthState(isInitialized:true,isAuthenticated:authenticated,userId:user,tenantId:tenant,role:role,token:capturedToken);
class HostAuth extends AuthNotifier {
  @override AuthState build()=>identity();
  void replace(AuthState value){state=value;}
}
class OwnedClient extends MockClient {
  int closes=0;
  final Object? closeFailure;
  OwnedClient(Future<http.Response> Function(http.Request) handle,{this.closeFailure}):super(handle);
  @override void close(){closes++;super.close();final error=closeFailure;if(error!=null)throw error;}
}
class HostFixture {
  final requests=<http.Request>[],clients=<OwnedClient>[],writes=<Map<String,dynamic>>[];
  final closeFailures=<int,Object>{};
  final receipts=<String,Map<String,dynamic>>{};
  int revision=0,dashboardStatus=200;
  bool includeTask=false,allowTasks=true,allowPeople=false,includeDirectory=false,taskLoseAcknowledgement=false,taskConflict=false,taskFailReadback=false;
  int taskVersion=1,taskApplied=0,taskVerificationReads=0;
  String taskTitle='Native owned task';
  final taskWrites=<http.Request>[],taskReceipts=<String,Map<String,dynamic>>{};
  Completer<http.Response>? delayedTask;
  Map<String,dynamic> get taskRow=>{'id':'task-a','version':taskVersion,'title':taskTitle,'notes':'Owned task instructions',
    'due_on':'2026-11-13','status':'open','owner_id':'user-a','priority':'normal','flow_id':'owned.workflow','evidence':null,'submitted_by':null,'actions':['edit','start','block','submit','cancel']};
  Map<String,dynamic> get dashboard=>{'dataset':'live','database':'PostgreSQL','synthetic':false,'identity':{'userId':dashboardUser,'role':'tenant_admin'},
    'organization':{'id':dashboardTenant},'today':'2026-11-13','canManage':true,'canCreate':true,'taskActorId':'user-a',
    'allowedViews':[if(allowTasks)'tasks',if(allowPeople)'people','operations','audit','workflows'],
    'users':<Map<String,dynamic>>[if(includeDirectory){'id':'staff-a','name':'Owned directory staff','email':'owned@example.invalid'}],
    'clients':<Map<String,dynamic>>[if(includeDirectory){'id':'client-a','name':'Owned directory client'}],
    'taskStats':{'open':includeTask?1:0,'review':0,'blocked':0,'overdue':0,'completed':0},
    'stats':{'staff':1,'clients':0,'visits':null,'requests':null,'time':null,'care':null,'plans':0},
    'events':<Map<String,dynamic>>[],'tasks':[if(includeTask)taskRow],'taskPage':{'offset':0,'total':includeTask?1:0,'limit':100},
    'workflows':[{'title':'Owned workflow guide','flow_id':'owned.workflow'}]};
  String dashboardUser='user-a',dashboardTenant='tenant-a';
  Object? document;
  bool loseAcknowledgement=false;
  int? failFactoryAt;
  Completer<http.Response>? delayedDashboard,delayedProfile;
  Map<String,dynamic> get scope=>{'tenantId':'tenant-a','userId':'user-a','role':'tenant_admin','dataset':'live'};
  int get parentDashboardReads=>requests.where((request)=>request.method=='GET'&&request.url.path=='/v1/governance/tenant-dashboard'&&request.url.queryParameters.length==1&&request.url.queryParameters['dataset']=='live').length;
  Map<String,dynamic> get snapshot=>{'version':1,'scope':scope,'kind':'shortcuts','resource':'navigation','revision':revision,'document':document};
  http.Response response(Object? data,[int status=200])=>http.Response(jsonEncode(data),status,headers:{'content-type':'application/json'});
  http.Client client(){if(clients.length==failFactoryAt)throw StateError('fixture client construction failure');final value=OwnedClient(handle,closeFailure:closeFailures[clients.length]);clients.add(value);return value;}
  Future<http.Response> handle(http.Request request)async{
    requests.add(request);
    expect(request.headers['authorization'],'Bearer $capturedToken');
    expect(request.headers.containsKey('x-tenant-id'),false);
    if(request.url.path=='/v1/governance/tenant-dashboard'){
      expect(request.url.queryParameters['dataset'],'live');
      if(request.method=='POST'){
        taskWrites.add(request);final key=request.headers['idempotency-key'];
        expect(key,matches(RegExp(r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$')));
        if(taskReceipts.containsKey(key))return response(taskReceipts[key]);
        final body=jsonDecode(request.body) as Map<String,dynamic>;expect(body['id'],'task-a');expect(body['action'],'edit');
        if(taskConflict){taskConflict=false;taskVersion++;taskTitle='Changed by another writer';return response({'error':'conflict'},409);}
        expect(body['version'],taskVersion);taskVersion++;taskApplied++;taskTitle=(body['value'] as Map)['title'] as String;
        taskReceipts[key!]=Map<String,dynamic>.from(jsonDecode(jsonEncode(dashboard)) as Map);
        if(taskLoseAcknowledgement){taskLoseAcknowledgement=false;throw http.ClientException('lost task acknowledgement');}
        return response(taskReceipts[key]);
      }
      expect(request.method,'GET');
      if(request.url.queryParameters.containsKey('search')){
        expect(request.url.queryParameters['status'],'all');expect(request.url.queryParameters['taskOffset'],'0');
        if(request.url.queryParameters['search']!.isNotEmpty){taskVerificationReads++;if(taskFailReadback){taskFailReadback=false;return response({'error':'unavailable'},503);}}
        if(delayedTask!=null)return delayedTask!.future;
      }else{expect(request.url.queryParameters,{'dataset':'live'});if(delayedDashboard!=null)return delayedDashboard!.future;}
      return response(dashboard,dashboardStatus);
    }
    if(request.url.path=='/v1/auth/me'){
      expect(request.method,'GET');
      if(delayedProfile!=null)return delayedProfile!.future;
      return response({'status':'authenticated','userId':'user-a','tenantId':'tenant-a','roles':'tenant_admin'});
    }
    expect(request.url.path,'/v1/user/preferences');expect(request.method,'POST');
    final body=jsonDecode(request.body) as Map<String,dynamic>;
    expect(body['expectedScope'],scope);
    if(body['action']=='read')return response(snapshot);
    writes.add(Map<String,dynamic>.from(jsonDecode(jsonEncode(body)) as Map));
    final key=body['requestId'] as String;
    if(receipts.containsKey(key))return response(receipts[key]);
    expect(body['revision'],revision);
    revision++;document=body['document'];
    final receipt=Map<String,dynamic>.from(jsonDecode(jsonEncode(snapshot)) as Map);
    receipts[key]=receipt;
    if(loseAcknowledgement){loseAcknowledgement=false;throw http.ClientException('lost acknowledgement');}
    return response(receipt);
  }
  ProviderContainer container()=>ProviderContainer(overrides:[authProvider.overrideWith(HostAuth.new),
    nativeApplicationClientProvider.overrideWithValue(client)]);
}
Future<void> mount(WidgetTester tester,ProviderContainer container,{String locale='en'})async{
  await tester.pumpWidget(UncontrolledProviderScope(container:container,child:PrimeTheme(data:const PrimeThemeData(),
    child:MaterialApp(locale:Locale(locale),supportedLocales:const[Locale('en'),Locale('fr'),Locale('es')],
      localizationsDelegates:GlobalMaterialLocalizations.delegates,home:managedPrimeCarePage(nativeTenantApplicationRoute,(_)=>const TenantApplicationScreen())))));
  await tester.pumpAndSettle();
}
Finder choice()=>find.widgetWithText(TextButton,'Platform Administration');
String shellText(String locale,String key)=>nativeApplicationShell['locales'][locale][key] as String;
Future<void> press(WidgetTester tester,Finder target)async{await tester.ensureVisible(target);await tester.tap(target);await tester.pumpAndSettle();}
Future<void> waitForTaskStatus(WidgetTester tester,WorkModuleSession session,Set<String> terminal)async{
 await tester.runAsync(()async{
   for(var pump=0;pump<100&&!terminal.contains(session.status);pump++){
     await Future<void>.delayed(const Duration(milliseconds:10));await tester.pump();
   }
 });
 await tester.pumpAndSettle();expect(session.status,isIn(terminal));
}

Finder taskModule()=>find.byWidgetPredicate((widget)=>widget is PrimeWorkModule&&widget.session.module=='tasks');
Finder directoryModule()=>find.byWidgetPredicate((widget)=>widget is PrimeWorkModule&&widget.session.module=='contacts');
WorkModuleSession profileSession(WidgetTester tester)=>tester.widgetList<PrimeWorkModule>(find.byType(PrimeWorkModule)).singleWhere((widget)=>widget.session.module=='profile').session;
String taskText(String key,{String locale='en'})=>nativeApplicationWork['locales'][locale][key] as String;
Finder taskButton(String key,{String locale='en'})=>find.descendant(of:taskModule(),matching:find.widgetWithText(TextButton,taskText(key,locale:locale))).first;
Finder taskTitleField({String locale='en'})=>find.descendant(of:taskModule(),matching:find.byWidgetPredicate((widget)=>widget is TextField&&widget.decoration?.labelText==taskText('title',locale:locale)));
Future<void> editTask(WidgetTester tester,String title,{String locale='en'})async{
 await press(tester,taskButton('open',locale:locale));final field=taskTitleField(locale:locale);await tester.ensureVisible(field);await tester.enterText(field,title);
}
WorkModuleLeaveBlock taskBlock(ProviderContainer container)=>container.read(nativeTaskLeaveBlockProvider(NativeApplicationIdentity('user-a','tenant-a','tenant_admin',capturedToken)));

void main(){
  setUp(()=>SharedPreferences.setMockInitialValues({}));
  test('existing tenant route is registered without adding permission grants',(){
    expect(nativeTenantApplicationRoute,'/tenant-dashboard');
    expect(primeCareScreenManager.lookup(nativeTenantApplicationRoute),isNotNull);
    expect(nativeApplicationDestinations['host']['screenId'],2534);
    expect(nativeApplicationDestinations['newRoleGrants'],0);
  });
  for(final row in [('en',320.0),('fr',768.0),('es',1440.0)]){
    testWidgets('${row.$1} native host mounts real ports, saves and reloads without write replay',(tester)async{
      await tester.binding.setSurfaceSize(Size(row.$2,1800));addTearDown(()=>tester.binding.setSurfaceSize(null));
      final f=HostFixture(),container=f.container();addTearDown(container.dispose);
      await mount(tester,container,locale:row.$1);
      expect(f.requests.first.url.path,'/v1/governance/tenant-dashboard');
      expect(f.requests.any((r)=>r.url.path=='/v1/auth/me'),true);
      expect(f.writes,isEmpty);expect(choice(),findsOneWidget);
      expect(find.byType(PrimeDashboardPage),findsNWidgets(2));expect(find.byType(PrimeRecordPage),findsNWidgets(2));
      final expectedLive=nativeApplicationDashboard['resources']['dashboardPages.ready'][row.$1] as String;
      final expectedDemo=nativeApplicationTenant['labels']['demo'] as String;
      for(final page in tester.widgetList<PrimeDashboardPage>(find.byType(PrimeDashboardPage))){
        expect(page.labels['live'],expectedLive);expect(page.labels['demo'],expectedDemo);
      }
      for(final page in tester.widgetList<PrimeRecordPage>(find.byType(PrimeRecordPage))){
        expect(page.labels['live'],expectedLive);expect(page.labels['demo'],expectedDemo);
      }
      if(row.$1!='en')expect(find.text(nativeApplicationTenant['labels']['live'] as String),findsNothing);
      final search=find.byWidgetPredicate((w)=>w is Semantics&&w.properties.identifier=='application-modules-filter-dashboard-search');
      final field=find.descendant(of:search,matching:find.byType(TextField));
      await tester.ensureVisible(field);await tester.enterText(field,'no matching guide');await tester.pump();
      expect(tester.widgetList<PrimeRecordPage>(find.byType(PrimeRecordPage)).singleWhere((w)=>w.projection.kind=='search').projection.status,'empty');
      await tester.enterText(field,List.filled(100,'😀').join());await tester.pump();
      expect(tester.widget<TextField>(field).controller!.text.length,lessThanOrEqualTo(100));
      expect(tester.widgetList<PrimeRecordPage>(find.byType(PrimeRecordPage)).singleWhere((w)=>w.projection.kind=='search').projection.status,'empty');
      final refresh=find.descendant(of:find.byWidgetPredicate((w)=>w is Semantics&&w.properties.identifier=='application-modules-reload-dashboard'),matching:find.byType(TextButton));
      expect(tester.widget<TextButton>(refresh).onPressed,isNotNull);
      await press(tester,choice());expect(f.writes,isEmpty);
      expect(tester.widget<TextButton>(refresh).onPressed,isNull);
      await press(tester,find.widgetWithText(TextButton,shellText(row.$1,'save')));
      expect(tester.widget<TextButton>(refresh).onPressed,isNotNull);
      expect(f.revision,1);expect((f.document as Map)['screenIds'],contains('1269'));
      expect(f.writes.length,1);expect(f.requests.where((r)=>r.url.path=='/v1/user/preferences'&&jsonDecode(r.body)['action']=='read').length,greaterThanOrEqualTo(2));
      await tester.pumpWidget(const SizedBox());await tester.pumpAndSettle();
      expect(f.clients.every((c)=>c.closes==1),true);
      await mount(tester,container,locale:row.$1);
      expect(choice(),findsOneWidget);expect(f.writes.length,1);expect(tester.takeException(),isNull);
      await tester.pumpWidget(const SizedBox());
    });
  }
  testWidgets('clean locale change reconstructs localized owned ports once',(tester)async{
    await tester.binding.setSurfaceSize(const Size(1200,1800));addTearDown(()=>tester.binding.setSurfaceSize(null));
    final f=HostFixture(),container=f.container();addTearDown(container.dispose);await mount(tester,container);
    final original=List<OwnedClient>.of(f.clients),dashboardReads=f.parentDashboardReads;
    await mount(tester,container,locale:'fr');
    expect(original.every((client)=>client.closes==1),true);expect(f.clients.length,8);
    expect(f.parentDashboardReads,dashboardReads+1);
    expect(profileSession(tester).snapshot!.items.single.title,nativeApplicationApplication['locales']['fr']['profile']);
    expect(f.writes,isEmpty);expect(tester.takeException(),isNull);await tester.pumpWidget(const SizedBox());
  });
  testWidgets('dirty shortcut defers locale reconstruction until the existing save completes',(tester)async{
    await tester.binding.setSurfaceSize(const Size(1200,1800));addTearDown(()=>tester.binding.setSurfaceSize(null));
    final f=HostFixture(),container=f.container();addTearDown(container.dispose);await mount(tester,container);
    await press(tester,choice());final original=List<OwnedClient>.of(f.clients),requests=f.requests.length;
    await mount(tester,container,locale:'es');
    expect(f.clients.length,4);expect(original.every((client)=>client.closes==0),true);expect(f.requests.length,requests);expect(f.writes,isEmpty);
    await press(tester,find.widgetWithText(TextButton,shellText('es','save')));
    expect(f.writes.length,1);expect((f.document as Map)['screenIds'],contains('1269'));
    expect(original.every((client)=>client.closes==1),true);expect(f.clients.length,8);
    expect(f.parentDashboardReads,2);
    expect(profileSession(tester).snapshot!.items.single.title,nativeApplicationApplication['locales']['es']['profile']);
    expect(tester.takeException(),isNull);await tester.pumpWidget(const SizedBox());
  });
  testWidgets('returning to original locale cancels a deferred shortcut reconstruction',(tester)async{
    await tester.binding.setSurfaceSize(const Size(1200,1800));addTearDown(()=>tester.binding.setSurfaceSize(null));
    final f=HostFixture(),container=f.container();addTearDown(container.dispose);await mount(tester,container);
    await press(tester,choice());final original=List<OwnedClient>.of(f.clients),profile=profileSession(tester);
    await mount(tester,container,locale:'fr');await mount(tester,container);
    await press(tester,find.widgetWithText(TextButton,shellText('en','save')));
    expect(f.writes.length,1);expect(f.clients.length,4);expect(original.every((client)=>client.closes==0),true);
    expect(profileSession(tester),same(profile));expect(profile.snapshot!.items.single.title,nativeApplicationApplication['locales']['en']['profile']);
    expect(tester.takeException(),isNull);await tester.pumpWidget(const SizedBox());expect(original.every((client)=>client.closes==1),true);
  });
  testWidgets('dirty task keeps its draft across locale changes then reconstructs latest locale once',(tester)async{
    await tester.binding.setSurfaceSize(const Size(1200,2400));addTearDown(()=>tester.binding.setSurfaceSize(null));
    final f=HostFixture()..includeTask=true,container=f.container();addTearDown(container.dispose);await mount(tester,container);
    await editTask(tester,'Retained locale task draft');final original=List<OwnedClient>.of(f.clients),tasks=tester.widget<PrimeWorkModule>(taskModule()).session;
    await mount(tester,container,locale:'fr');await mount(tester,container,locale:'es');
    expect(tester.widget<PrimeWorkModule>(taskModule()).session,same(tasks));expect(taskBlock(container).value,true);
    expect(tester.widget<TextField>(taskTitleField(locale:'es')).controller!.text,'Retained locale task draft');
    expect(f.clients.length,4);expect(original.every((client)=>client.closes==0),true);expect(f.taskWrites,isEmpty);
    await press(tester,taskButton('close',locale:'es'));
    expect(taskBlock(container).value,false);expect(f.clients.length,8);expect(original.every((client)=>client.closes==1),true);
    expect(profileSession(tester).snapshot!.items.single.title,nativeApplicationApplication['locales']['es']['profile']);
    expect(tester.widget<PrimeWorkModule>(taskModule()).session.snapshot!.items.single.title,'Native owned task');expect(f.taskWrites,isEmpty);
    expect(tester.takeException(),isNull);await tester.pumpWidget(const SizedBox());expect(f.clients.every((client)=>client.closes==1),true);
  });
  for(final failing in [<int>[0],<int>[1],<int>[0,1]]){
    testWidgets('native retirement attempts every client and reports only first failure $failing',(tester)async{
      final f=HostFixture(),first=StateError('first owned close failure');
      for(final index in failing){f.closeFailures[index]=index==failing.first?first:StateError('later owned close failure');}
      final container=f.container();addTearDown(container.dispose);await mount(tester,container);
      expect(f.clients.length,4);expect(choice(),findsOneWidget);expect(f.writes,isEmpty);
      await tester.pumpWidget(const SizedBox());await tester.pumpAndSettle();
      expect(tester.takeException(),same(first));expect(tester.takeException(),isNull);
      expect(f.clients.every((client)=>client.closes==1),true);expect(f.writes,isEmpty);
      expect(find.byType(PrimeDashboardPage),findsNothing);expect(find.byType(PrimeRecordPage),findsNothing);
      f.closeFailures.clear();await mount(tester,container);
      expect(choice(),findsOneWidget);expect(f.clients.take(4).every((client)=>client.closes==1),true);
      expect(tester.takeException(),isNull);await tester.pumpWidget(const SizedBox());
    });
  }
  testWidgets('reload cleanup failure clears protected views and can retry without reclosing old clients',(tester)async{
    await tester.binding.setSurfaceSize(const Size(1200,1800));addTearDown(()=>tester.binding.setSurfaceSize(null));
    final f=HostFixture(),failure=StateError('reload owned close failure');f.closeFailures[0]=failure;
    final container=f.container();addTearDown(container.dispose);await mount(tester,container);
    final reload=find.descendant(of:find.byWidgetPredicate((w)=>w is Semantics&&w.properties.identifier=='application-modules-reload-dashboard'),matching:find.byType(TextButton));
    await press(tester,reload);expect(tester.takeException(),same(failure));expect(tester.takeException(),isNull);
    expect(f.clients.length,4);expect(f.clients.every((client)=>client.closes==1),true);
    expect(choice(),findsNothing);expect(find.byType(PrimeDashboardPage),findsNothing);expect(find.byType(PrimeRecordPage),findsNothing);
    expect(find.text(nativeApplicationApplication['locales']['en']['unavailable'] as String),findsOneWidget);
    final requests=f.requests.length;f.closeFailures.clear();
    await press(tester,find.widgetWithText(TextButton,nativeApplicationApplication['locales']['en']['reload'] as String));
    expect(choice(),findsOneWidget);expect(f.requests.length,greaterThan(requests));
    expect(f.clients.take(4).every((client)=>client.closes==1),true);expect(f.writes,isEmpty);
    expect(tester.takeException(),isNull);await tester.pumpWidget(const SizedBox());
  });
  testWidgets('startup failure still retires every allocated client when cleanup also fails',(tester)async{
    final f=HostFixture(),failure=StateError('startup owned close failure');
    f.failFactoryAt=2;f.closeFailures[0]=failure;
    final container=f.container();addTearDown(container.dispose);await mount(tester,container);
    expect(tester.takeException(),same(failure));expect(tester.takeException(),isNull);
    expect(f.clients.length,2);expect(f.clients.every((client)=>client.closes==1),true);
    expect(choice(),findsNothing);expect(find.byType(PrimeDashboardPage),findsNothing);expect(find.byType(PrimeRecordPage),findsNothing);
    expect(find.text(nativeApplicationApplication['locales']['en']['unavailable'] as String),findsOneWidget);
    expect(f.writes,isEmpty);await tester.pumpWidget(const SizedBox());
    expect(f.clients.every((client)=>client.closes==1),true);expect(tester.takeException(),isNull);
  });
  testWidgets('native host preserves uncertain receipt through restart and explicit retry',(tester)async{
    await tester.binding.setSurfaceSize(const Size(1200,1800));addTearDown(()=>tester.binding.setSurfaceSize(null));
    final f=HostFixture(),container=f.container();addTearDown(container.dispose);
    await mount(tester,container);await press(tester,choice());f.loseAcknowledgement=true;
    await press(tester,find.widgetWithText(TextButton,shellText('en','save')));
    final original=f.writes.single;
    await tester.pumpWidget(const SizedBox());await tester.pumpAndSettle();await mount(tester,container);
    expect(f.writes.length,1);
    await press(tester,find.widgetWithText(TextButton,shellText('en','retry')));
    expect(f.writes.length,2);expect(f.writes.last,original);expect(f.revision,1);
    expect(tester.takeException(),isNull);await tester.pumpWidget(const SizedBox());
  });
  for(final mode in ['denied','wrong-actor']){
    testWidgets('$mode dashboard does not mount protected child ports',(tester)async{
      final f=HostFixture();if(mode=='denied'){f.dashboardStatus=403;}else{f.dashboardUser='other-user';}
      final container=f.container();addTearDown(container.dispose);await mount(tester,container);
      expect(choice(),findsNothing);expect(f.requests.length,1);expect(f.writes,isEmpty);
      expect(f.clients.every((c)=>c.closes==1),true);expect(tester.takeException(),isNull);
      await tester.pumpWidget(const SizedBox());
    });
  }
  for(final phase in ['dashboard','profile']){
    testWidgets('account change during $phase retires clients and rejects late identity',(tester)async{
      final f=HostFixture(),pending=Completer<http.Response>();
      if(phase=='dashboard'){f.delayedDashboard=pending;}else{f.delayedProfile=pending;}
      final container=f.container();addTearDown(container.dispose);await mount(tester,container);
      (container.read(authProvider.notifier) as HostAuth).replace(identity(authenticated:false));
      await tester.pumpAndSettle();
      pending.complete(f.response(phase=='dashboard'?{'dataset':'live','synthetic':false,'identity':{'userId':'user-a','role':'tenant_admin'},'organization':{'id':'tenant-a'},'today':'2026-11-13'}:
        {'status':'authenticated','userId':'user-a','tenantId':'tenant-a','roles':'tenant_admin'}));
      await tester.pumpAndSettle();expect(choice(),findsNothing);expect(find.text('user-a'),findsNothing);
      expect(f.writes,isEmpty);expect(f.clients.every((c)=>c.closes==1),true);
      expect(tester.takeException(),isNull);await tester.pumpWidget(const SizedBox());
    });
  }
  testWidgets('ungranted native role sends no child or dashboard requests',(tester)async{
    final f=HostFixture(),container=f.container();addTearDown(container.dispose);
    (container.read(authProvider.notifier) as HostAuth).replace(identity(role:'guest'));
    await mount(tester,container);expect(f.requests,isEmpty);expect(choice(),findsNothing);
    await tester.pumpWidget(const SizedBox());
  });
  testWidgets('existing account security navigation preserves a dirty shortcut draft',(tester)async{
    await tester.binding.setSurfaceSize(const Size(1200,1800));addTearDown(()=>tester.binding.setSurfaceSize(null));
    final f=HostFixture(),container=f.container();addTearDown(container.dispose);
    final router=GoRouter(routes:[
      GoRoute(path:'/',builder:(context,state)=>managedPrimeCarePage(nativeTenantApplicationRoute,(_)=>const TenantApplicationScreen())),
      GoRoute(path:'/success',builder:(context,state)=>const Scaffold(body:Text('existing account security'))),
    ]);addTearDown(router.dispose);
    await tester.pumpWidget(UncontrolledProviderScope(container:container,child:PrimeTheme(data:const PrimeThemeData(),child:MaterialApp.router(routerConfig:router))));
    await tester.pumpAndSettle();await press(tester,choice());
    final words=nativeApplicationApplication['locales']['en'];
    await press(tester,find.widgetWithText(TextButton,'${words['open']} ${words['profile']}'));
    expect(find.text('existing account security'),findsOneWidget);
    expect(f.writes,isEmpty);expect(f.clients.every((c)=>c.closes==1),true);
    expect(router.routeInformationProvider.value.uri.queryParameters['enable-semantics'],'true');
    router.go('/');await tester.pumpAndSettle();expect(choice(),findsOneWidget);expect(f.writes,isEmpty);
    await press(tester,find.widgetWithText(TextButton,shellText('en','save')));
    expect((f.document as Map)['screenIds'],contains('1269'));expect(f.writes.length,1);
    expect(tester.takeException(),isNull);await tester.pumpWidget(const SizedBox());
  });
  for(final locale in ['en','fr','es'])testWidgets('$locale native task host saves through existing API and verifies independent readback',(tester)async{
    await tester.binding.setSurfaceSize(const Size(1200,2400));addTearDown(()=>tester.binding.setSurfaceSize(null));
    final f=HostFixture()..includeTask=true,container=f.container();addTearDown(container.dispose);await mount(tester,container,locale:locale);
    expect(taskModule(),findsOneWidget);expect(nativeApplicationWork['apiBindings'],{'GET':16578,'POST':16579});
    expect((nativeApplicationWork['controls'] as List).singleWhere((row)=>row['key']=='tasks')['controlId'],735);
    expect(tester.widget<PrimeWorkModule>(taskModule()).session.snapshot!.items.single.title,f.taskTitle);
    await editTask(tester,'Verified $locale task',locale:locale);expect(taskBlock(container).value,true);expect(f.taskWrites,isEmpty);
    await press(tester,taskButton('save',locale:locale));
    expect(f.taskApplied,1);expect(f.taskWrites.length,1);expect(f.taskVerificationReads,1);
    expect(tester.widget<PrimeWorkModule>(taskModule()).session.status,'success');expect(taskBlock(container).value,false);
    expect(tester.widget<PrimeWorkModule>(taskModule()).session.snapshot!.items.single.title,'Verified $locale task');
    final reload=find.descendant(of:find.byWidgetPredicate((w)=>w is Semantics&&w.properties.identifier=='application-modules-reload-dashboard'),matching:find.byType(TextButton));
    await press(tester,reload);expect(tester.widget<PrimeWorkModule>(taskModule()).session.snapshot!.items.single.title,'Verified $locale task');expect(f.taskApplied,1);expect(tester.takeException(),isNull);
    await tester.pumpWidget(const SizedBox());expect(f.clients.every((client)=>client.closes==1),true);
  });
  testWidgets('server task-view denial preserves other registered children without mounting task port',(tester)async{
    final f=HostFixture()..includeTask=true..allowTasks=false,container=f.container();addTearDown(container.dispose);await mount(tester,container);
    expect(taskModule(),findsNothing);expect(choice(),findsOneWidget);expect(f.clients.length,3);expect(f.taskWrites,isEmpty);
    expect(f.requests.where((request)=>request.url.queryParameters.containsKey('taskOffset')),isEmpty);expect(taskBlock(container).value,false);expect(tester.takeException(),isNull);await tester.pumpWidget(const SizedBox());
  });
  for(final locale in ['en','fr','es'])testWidgets('$locale native directory mounts only existing read-only scoped records',(tester)async{
    await tester.binding.setSurfaceSize(const Size(1200,2800));addTearDown(()=>tester.binding.setSurfaceSize(null));
    final f=HostFixture()..allowPeople=true..includeDirectory=true,container=f.container();addTearDown(container.dispose);await mount(tester,container,locale:locale);
    expect(directoryModule(),findsOneWidget);expect((nativeApplicationWork['controls'] as List).singleWhere((row)=>row['key']=='contacts')['controlId'],734);
    final directory=tester.widget<PrimeWorkModule>(directoryModule()).session;
    final workIdentifiers=tester.widgetList<Semantics>(find.byWidgetPredicate((widget)=>widget is Semantics&&(widget.properties.identifier??'').startsWith('work-modules-'))).map((widget)=>widget.properties.identifier).toList();
    expect(workIdentifiers.toSet().length,workIdentifiers.length);expect(workIdentifiers,contains('work-modules-filter-contacts'));expect(workIdentifiers,contains('work-modules-filter'));
    expect(directory.snapshot!.items.map((item)=>item.title),['Owned directory staff','Owned directory client']);expect(directory.snapshot!.items.every((item)=>item.actions.isEmpty),true);
    final create=find.descendant(of:directoryModule(),matching:find.widgetWithText(TextButton,taskText('create',locale:locale)));expect(tester.widget<TextButton>(create).onPressed,isNull);
    await expectLater(directory.submit('staff:staff-a','edit',{'body':'Forbidden write'}),throwsA(isA<WorkFailure>().having((error)=>error.code,'code','denied')));
    expect(f.taskWrites,isEmpty);expect(f.writes,isEmpty);expect(f.clients.length,5);expect(taskBlock(container).value,false);
    final search=find.descendant(of:directoryModule(),matching:find.byType(TextField));await tester.ensureVisible(search);await tester.enterText(search,'directory client');await tester.testTextInput.receiveAction(TextInputAction.done);await waitForTaskStatus(tester,directory,{'ready'});
    expect(directory.snapshot!.items.single.title,'Owned directory client');expect(directory.snapshot!.items.single.actions,isEmpty);expect(f.taskWrites,isEmpty);
    expect(tester.takeException(),isNull);await tester.pumpWidget(const SizedBox());expect(f.clients.every((client)=>client.closes==1),true);
  });
  testWidgets('task view permission does not authorize the native directory',(tester)async{
    final f=HostFixture()..includeDirectory=true,container=f.container();addTearDown(container.dispose);await mount(tester,container);
    expect(taskModule(),findsOneWidget);expect(directoryModule(),findsNothing);expect(find.text('Owned directory staff'),findsNothing);expect(find.text('Owned directory client'),findsNothing);
    expect(f.clients.length,4);expect(f.taskWrites,isEmpty);expect(f.writes,isEmpty);expect(tester.takeException(),isNull);await tester.pumpWidget(const SizedBox());
  });
  testWidgets('parent people-view revocation retires the native directory and its client',(tester)async{
    await tester.binding.setSurfaceSize(const Size(1200,2800));addTearDown(()=>tester.binding.setSurfaceSize(null));
    final f=HostFixture()..allowPeople=true..includeDirectory=true,container=f.container();addTearDown(container.dispose);await mount(tester,container);
    final original=List<OwnedClient>.of(f.clients),directory=tester.widget<PrimeWorkModule>(directoryModule()).session;f.allowPeople=false;
    final reload=find.descendant(of:find.byWidgetPredicate((widget)=>widget is Semantics&&widget.properties.identifier=='application-modules-reload-dashboard'),matching:find.byType(TextButton));await press(tester,reload);
    expect(directoryModule(),findsNothing);expect(directory.dead,true);expect(original.every((client)=>client.closes==1),true);expect(f.clients.length,9);
    expect(find.text('Owned directory staff'),findsNothing);expect(find.text('Owned directory client'),findsNothing);expect(f.taskWrites,isEmpty);expect(f.writes,isEmpty);
    expect(tester.takeException(),isNull);await tester.pumpWidget(const SizedBox());expect(f.clients.every((client)=>client.closes==1),true);
  });
  for(final denial in ['tenant','actor','http','people view'])testWidgets('native directory $denial denial clears protected records',(tester)async{
    final f=HostFixture()..allowPeople=true..includeDirectory=true,container=f.container();addTearDown(container.dispose);await mount(tester,container);
    final directory=tester.widget<PrimeWorkModule>(directoryModule()).session;if(denial=='tenant')f.dashboardTenant='different-tenant';if(denial=='actor')f.dashboardUser='different-actor';if(denial=='http')f.dashboardStatus=403;if(denial=='people view')f.allowPeople=false;
    await tester.runAsync(()=>directory.load());await tester.pumpAndSettle();expect(directory.status,'denied');expect(directory.snapshot,isNull);
    expect(find.descendant(of:directoryModule(),matching:find.text('Owned directory staff')),findsNothing);expect(find.descendant(of:directoryModule(),matching:find.text('Owned directory client')),findsNothing);
    expect(f.taskWrites,isEmpty);expect(f.writes,isEmpty);expect(tester.takeException(),isNull);await tester.pumpWidget(const SizedBox());expect(f.clients.every((client)=>client.closes==1),true);
  });
  testWidgets('dirty task synchronously blocks a previously captured parent reload callback',(tester)async{
    await tester.binding.setSurfaceSize(const Size(1200,2400));addTearDown(()=>tester.binding.setSurfaceSize(null));
    final f=HostFixture()..includeTask=true,container=f.container();addTearDown(container.dispose);await mount(tester,container);
    final reload=find.descendant(of:find.byWidgetPredicate((w)=>w is Semantics&&w.properties.identifier=='application-modules-reload-dashboard'),matching:find.byType(TextButton));
    final captured=tester.widget<TextButton>(reload).onPressed!;
    await editTask(tester,'Synchronous task draft');final requests=f.requests.length;expect(taskBlock(container).value,true);captured();await tester.pumpAndSettle();
    expect(f.requests.length,requests);expect(tester.widget<TextField>(taskTitleField()).controller!.text,'Synchronous task draft');expect(tester.widget<TextButton>(reload).onPressed,isNull);
    await press(tester,taskButton('close'));expect(taskBlock(container).value,false);expect(f.taskWrites,isEmpty);expect(tester.takeException(),isNull);await tester.pumpWidget(const SizedBox());
  });
  for(final mode in ['lost acknowledgement','readback failure'])testWidgets('native task $mode retains original receipt and blocks parent navigation after Close',(tester)async{
    await tester.binding.setSurfaceSize(const Size(1200,2400));addTearDown(()=>tester.binding.setSurfaceSize(null));
    final f=HostFixture()..includeTask=true,container=f.container();addTearDown(container.dispose);await mount(tester,container);
    await editTask(tester,'Retained original task receipt');
    if(mode=='lost acknowledgement')f.taskLoseAcknowledgement=true;else f.taskFailReadback=true;
    final tasks=tester.widget<PrimeWorkModule>(taskModule()).session;
    await press(tester,taskButton('save'));await waitForTaskStatus(tester,tasks,{'error'});final original=f.taskWrites.single;
    expect(tasks.busy,false);expect(tasks.pendingKey,original.headers['idempotency-key']);
    if(mode=='readback failure')expect(tasks.pendingReceipt,isNotNull);
    expect(f.taskApplied,1);expect(tester.widget<PrimeWorkModule>(taskModule()).session.pending,isNotNull);expect(taskBlock(container).value,true);
    await press(tester,taskButton('close'));expect(taskBlock(container).value,true);
    await press(tester,taskButton('save'));await waitForTaskStatus(tester,tasks,{'success'});expect(taskBlock(container).value,false);expect(f.taskApplied,1);
    expect(tester.widget<PrimeWorkModule>(taskModule()).session.status,'success');
    if(mode=='lost acknowledgement'){
      expect(f.taskWrites.length,2);expect(f.taskWrites.last.headers['idempotency-key'],original.headers['idempotency-key']);expect(f.taskWrites.last.body,original.body);
    }else{expect(f.taskWrites.length,1);expect(f.taskVerificationReads,2);}
    expect(tester.takeException(),isNull);await tester.pumpWidget(const SizedBox());
  });
  testWidgets('native task conflict retains draft until Close and fresh parent reload',(tester)async{
    await tester.binding.setSurfaceSize(const Size(1200,2400));addTearDown(()=>tester.binding.setSurfaceSize(null));
    final f=HostFixture()..includeTask=true,container=f.container();addTearDown(container.dispose);await mount(tester,container);
    await editTask(tester,'Conflicting local draft');final tasks=tester.widget<PrimeWorkModule>(taskModule()).session;
    f.taskConflict=true;await press(tester,taskButton('save'));await waitForTaskStatus(tester,tasks,{'conflict'});
    expect(f.taskApplied,0);expect(f.taskWrites.length,1);expect(tester.widget<PrimeWorkModule>(taskModule()).session.status,'conflict');expect(taskBlock(container).value,true);
    expect(tester.widget<TextField>(taskTitleField()).controller!.text,'Conflicting local draft');await press(tester,taskButton('close'));expect(taskBlock(container).value,false);
    final reload=find.descendant(of:find.byWidgetPredicate((w)=>w is Semantics&&w.properties.identifier=='application-modules-reload-dashboard'),matching:find.byType(TextButton));
    await press(tester,reload);expect(tester.widget<PrimeWorkModule>(taskModule()).session.snapshot!.items.single.title,'Changed by another writer');expect(f.taskWrites.length,1);expect(tester.takeException(),isNull);await tester.pumpWidget(const SizedBox());
  });
  testWidgets('logout during a held native task read retires all clients and stale guard claims',(tester)async{
    await tester.binding.setSurfaceSize(const Size(1200,2400));addTearDown(()=>tester.binding.setSurfaceSize(null));
    final f=HostFixture()..includeTask=true,container=f.container();addTearDown(container.dispose);await mount(tester,container);
    await editTask(tester,'Draft before logout');expect(taskBlock(container).value,true);
    final held=Completer<http.Response>();f.delayedTask=held;final tasks=tester.widget<PrimeWorkModule>(taskModule()).session;
    // The host cannot reload a dirty editor; use the existing session read to hold an owned HTTP request.
    final read=tasks.port!.read(const WorkQuery()).catchError((Object _)=>null);
    (container.read(authProvider.notifier) as HostAuth).replace(identity(authenticated:false));await tester.pumpAndSettle();
    expect(taskModule(),findsNothing);expect(f.clients.every((client)=>client.closes==1),true);
    expect(canLeaveNativeApplicationTasks(identity(authenticated:false),(owner)=>container.read(nativeTaskLeaveBlockProvider(owner))),true);
    held.complete(f.response(f.dashboard));await read;await tester.pumpAndSettle();expect(taskModule(),findsNothing);expect(f.taskWrites,isEmpty);expect(tester.takeException(),isNull);await tester.pumpWidget(const SizedBox());
  });
  testWidgets('task dirty guard blocks route and account exit while allowing logout and account replacement',(tester)async{
    await tester.binding.setSurfaceSize(const Size(1200,2400));addTearDown(()=>tester.binding.setSurfaceSize(null));
    final f=HostFixture()..includeTask=true,container=f.container();addTearDown(container.dispose);
    bool canLeave()=>canLeaveNativeApplicationTasks(container.read(authProvider),(owner)=>container.read(nativeTaskLeaveBlockProvider(owner)));
    final router=GoRouter(routes:[
      GoRoute(path:'/',builder:(context,state)=>managedPrimeCarePage(nativeTenantApplicationRoute,(_)=>const TenantApplicationScreen()),onExit:(context,state)=>canLeave()),
      GoRoute(path:'/success',builder:(context,state)=>const Scaffold(body:Text('existing account security'))),
    ]);addTearDown(router.dispose);
    await tester.pumpWidget(UncontrolledProviderScope(container:container,child:PrimeTheme(data:const PrimeThemeData(),child:MaterialApp.router(routerConfig:router))));await tester.pumpAndSettle();
    final words=nativeApplicationApplication['locales']['en'],account=find.widgetWithText(TextButton,'${words['open']} ${words['profile']}'),capturedAccount=tester.widget<TextButton>(account).onPressed!;
    await editTask(tester,'Unsaved route draft');expect(canLeave(),false);capturedAccount();await tester.pumpAndSettle();expect(find.text('existing account security'),findsNothing);
    router.go('/success');await tester.pumpAndSettle();expect(taskModule(),findsOneWidget);expect(tester.widget<TextField>(taskTitleField()).controller!.text,'Unsaved route draft');
    final current=container.read(authProvider);
    expect(canLeaveNativeApplicationTasks(current.copyWith(isInitialized:false),(owner)=>container.read(nativeTaskLeaveBlockProvider(owner))),true);
    expect(canLeaveNativeApplicationTasks(identity(user:'replacement-user'),(owner)=>container.read(nativeTaskLeaveBlockProvider(owner))),true);
    await press(tester,taskButton('close'));expect(canLeave(),true);router.go('/success');await tester.pumpAndSettle();expect(find.text('existing account security'),findsOneWidget);expect(f.taskWrites,isEmpty);expect(tester.takeException(),isNull);await tester.pumpWidget(const SizedBox());
  });

  for(final denial in ['tenant','actor','http'])testWidgets('task $denial denial clears the owned task snapshot and cannot write',(tester)async{
    await tester.binding.setSurfaceSize(const Size(1200,2400));addTearDown(()=>tester.binding.setSurfaceSize(null));
    final f=HostFixture()..includeTask=true,container=f.container();addTearDown(container.dispose);await mount(tester,container);
    final tasks=tester.widget<PrimeWorkModule>(taskModule()).session;expect(tasks.snapshot!.items.single.title,'Native owned task');
    if(denial=='tenant')f.dashboardTenant='different-tenant';if(denial=='actor')f.dashboardUser='different-actor';if(denial=='http')f.dashboardStatus=403;
    await tester.runAsync(()=>tasks.load());await tester.pumpAndSettle();expect(tasks.status,'denied');expect(tasks.snapshot,isNull);expect(f.taskWrites,isEmpty);expect(find.descendant(of:taskModule(),matching:find.text('Native owned task')),findsNothing);
    expect(tester.takeException(),isNull);await tester.pumpWidget(const SizedBox());expect(f.clients.every((client)=>client.closes==1),true);
  });

}
