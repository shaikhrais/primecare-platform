import 'dart:async';
import 'dart:convert';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
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
  OwnedClient(Future<http.Response> Function(http.Request) handle):super(handle);
  @override void close(){closes++;super.close();}
}
class HostFixture {
  final requests=<http.Request>[],clients=<OwnedClient>[],writes=<Map<String,dynamic>>[];
  final receipts=<String,Map<String,dynamic>>{};
  int revision=0,dashboardStatus=200;
  String dashboardUser='user-a';
  Object? document;
  bool loseAcknowledgement=false;
  Completer<http.Response>? delayedDashboard,delayedProfile;
  Map<String,dynamic> get scope=>{'tenantId':'tenant-a','userId':'user-a','role':'tenant_admin','dataset':'live'};
  Map<String,dynamic> get snapshot=>{'version':1,'scope':scope,'kind':'shortcuts','resource':'navigation','revision':revision,'document':document};
  http.Response response(Object? data,[int status=200])=>http.Response(jsonEncode(data),status,headers:{'content-type':'application/json'});
  http.Client client(){final value=OwnedClient(handle);clients.add(value);return value;}
  Future<http.Response> handle(http.Request request)async{
    requests.add(request);
    expect(request.headers['authorization'],'Bearer $capturedToken');
    expect(request.headers.containsKey('x-tenant-id'),false);
    if(request.url.path=='/v1/governance/tenant-dashboard'){
      expect(request.method,'GET');expect(request.url.queryParameters,{'dataset':'live'});
      if(delayedDashboard!=null)return delayedDashboard!.future;
      return response({'dataset':'live','synthetic':false,'identity':{'userId':dashboardUser,'role':'tenant_admin'},
        'organization':{'id':'tenant-a'},'today':'2026-11-13'},dashboardStatus);
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
      localizationsDelegates:GlobalMaterialLocalizations.delegates,home:const TenantApplicationScreen()))));
  await tester.pumpAndSettle();
}
Finder choice()=>find.widgetWithText(TextButton,'Platform Administration');
String shellText(String locale,String key)=>nativeApplicationShell['locales'][locale][key] as String;
Future<void> press(WidgetTester tester,Finder target)async{await tester.ensureVisible(target);await tester.tap(target);await tester.pumpAndSettle();}

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
      await press(tester,choice());expect(f.writes,isEmpty);
      await press(tester,find.widgetWithText(TextButton,shellText(row.$1,'save')));
      expect(f.revision,1);expect((f.document as Map)['screenIds'],contains('1269'));
      expect(f.writes.length,1);expect(f.requests.where((r)=>r.url.path=='/v1/user/preferences'&&jsonDecode(r.body)['action']=='read').length,greaterThanOrEqualTo(2));
      await tester.pumpWidget(const SizedBox());await tester.pumpAndSettle();
      expect(f.clients.every((c)=>c.closes==1),true);
      await mount(tester,container,locale:row.$1);
      expect(choice(),findsOneWidget);expect(f.writes.length,1);expect(tester.takeException(),isNull);
      await tester.pumpWidget(const SizedBox());
    });
  }
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
}
