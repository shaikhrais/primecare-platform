import 'dart:async';import 'dart:convert';import 'dart:io';
import 'package:flutter_test/flutter_test.dart';import 'package:http/http.dart' as http;
import 'package:flutter_core/application_modules.dart';
class SettingsCache implements PreferenceCache{
 final data=<String,String>{};bool denied=false;
 @override Future<String?> read(String key)async=>data[key];
 @override Future<void> write(String key,String value)async{if(denied)throw StateError('denied');data[key]=value;}
 @override Future<void> remove(String key)async{data.remove(key);}
}
class SettingsWire extends http.BaseClient{
 final Future<http.StreamedResponse> Function(http.BaseRequest) handler;bool closed=false;SettingsWire(this.handler);
 @override Future<http.StreamedResponse> send(http.BaseRequest request)=>handler(request);
 @override void close(){closed=true;}
}
void main(){
 final oracle=jsonDecode(File('test/application_modules/settings-oracle.json').readAsStringSync()) as Map,b=oracle['binding'] as Map;
 final scope=PreferenceScope.fromJson(b['scope']),binding=PreferenceBinding(scope:scope,kind:'shortcuts',resource:'navigation',screenIds:['1','2']),names=Map<String,String>.from(oracle['names'] as Map),labels=Map<String,String>.from(oracle['labels'] as Map),defaults=List<String>.from(oracle['defaults'] as List);
 Map<String,dynamic> clone(Object? v)=>Map<String,dynamic>.from(jsonDecode(jsonEncode(v)) as Map);
 ApplicationSettingsPort port(PreferenceTransport transport,[SettingsCache? cache])=>ApplicationSettingsPort(binding:binding,transport:transport,cache:cache??SettingsCache(),names:names,labels:labels,defaults:defaults);
 WorkCommand command(Map<dynamic,dynamic> c)=>WorkCommand(c['itemId'] as String,c['version'] as int,c['action'] as String,Map<String,String>.from(c['fields'] as Map));
 test('native settings defaults, empty values and selected names match the web projection',()async{
  for(final value in oracle['cases'] as List){final c=value as Map,p=port((_)async=>clone(c['raw']));expect(await p.read(const WorkQuery()),c['expected']);p.dispose();}
 });
 test('native commands preserve the exact API777 envelope, receipt and independent readback',()async{
  for(final value in oracle['mutations'] as List){final c=value as Map,cache=SettingsCache();var state=clone(c['initial']);Map<String,dynamic>? sent;
   final p=port((r)async{if(r['action']=='write'){sent=clone(r);state=clone(c['reply']);}return state;},cache);await p.read(const WorkQuery());final receipt=await p.mutate(command(c['command'] as Map),c['key'] as String);expect(sent,c['request']);expect({'itemId':receipt.itemId,'version':receipt.version,'action':receipt.action,'expected':receipt.expected},c['receipt']);expect(await p.readItem('navigation'),c['readback']);expect(cache.data.keys.every((k)=>k.startsWith('application-modules.settings:primecare.preference-sync.v1:')),true);p.dispose();}
 });
 test('lost acknowledgement replays the original durable UUID and payload without duplicate writes',()async{
  final c=(oracle['mutations'] as List).first as Map,requests=<Map<String,dynamic>>[];var state=clone(c['initial']),lost=true,writes=0;
  final p=port((r)async{if(r['action']=='write'){requests.add(clone(r));if(state['revision']==0){state=clone(c['reply']);writes++;}if(lost){lost=false;throw const PreferenceFailure('offline');}}return state;}),s=WorkModuleSession(scope,'settings',port:p,requestId:()=>c['key'] as String);await s.load();final cmd=command(c['command'] as Map);await expectLater(s.submit(cmd.itemId,cmd.action,cmd.fields),throwsA(isA<WorkFailure>()));expect(p.recovery['pending'],isNotNull);await s.retryPending();expect(s.status,'success');expect(writes,1);expect(requests.length,2);expect(requests[0],requests[1]);s.dispose();
 });
 test('an acknowledged save with failed readback retries verification only',()async{
  final c=(oracle['mutations'] as List).first as Map;var state=clone(c['initial']),failRead=false,writes=0;
  final p=port((r)async{if(r['action']=='write'){state=clone(c['reply']);failRead=true;writes++;}else if(failRead){failRead=false;throw const PreferenceFailure('offline');}return state;}),s=WorkModuleSession(scope,'settings',port:p,requestId:()=>c['key'] as String);await s.load();final cmd=command(c['command'] as Map);await expectLater(s.submit(cmd.itemId,cmd.action,cmd.fields),throwsA(isA<WorkFailure>()));expect(s.pendingReceipt,isNotNull);await s.retryPending();expect(s.status,'success');expect(writes,1);s.dispose();
 });
 test('unknown names, stale versions and ungranted fields cannot send a mutation',()async{
  final c=(oracle['mutations'] as List).first as Map;var writes=0;final p=port((r)async{if(r['action']=='write')writes++;return clone(c['initial']);});await p.read(const WorkQuery());
  for(final cmd in [WorkCommand('navigation',1,'edit',{'body':'Unregistered'}),WorkCommand('navigation',99,'edit',{'body':'Overview'}),WorkCommand('navigation',1,'edit',{'body':'Overview','role':'admin'})]){await expectLater(p.mutate(cmd,c['key'] as String),throwsA(isA<WorkFailure>()));}expect(writes,0);p.dispose();
 });
 test('cache failure retains the draft and prevents a server write',()async{
  final c=(oracle['mutations'] as List).first as Map,cache=SettingsCache();var writes=0;final p=port((r)async{if(r['action']=='write')writes++;return clone(c['initial']);},cache);await p.read(const WorkQuery());cache.denied=true;
  await expectLater(p.mutate(command(c['command'] as Map),c['key'] as String),throwsA(isA<WorkFailure>()));expect(writes,0);expect(p.recovery['dirty'],true);expect(p.recovery['error'],'cache_unavailable');p.dispose();
 });
 test('restart retains owned dirty/pending data and requires explicit recovery instead of replaying',()async{
  final c=(oracle['mutations'] as List).first as Map,cache=SettingsCache();var state=clone(c['initial']),writes=0;
  Future<Object?> send(Map<String,dynamic> r)async{if(r['action']=='write'){state=clone(c['reply']);writes++;throw const PreferenceFailure('offline');}return state;}
  final a=port(send,cache);await a.read(const WorkQuery());await expectLater(a.mutate(command(c['command'] as Map),c['key'] as String),throwsA(isA<WorkFailure>()));a.dispose();final b=port(send,cache);await expectLater(b.read(const WorkQuery()),throwsA(isA<WorkFailure>().having((e)=>e.code,'code','conflict')));expect((b.recovery['pending'] as Map)['requestId'],c['key']);expect(writes,1);b.dispose();
 });
 test('authenticated factory uses current scope and preserves borrowed HTTP ownership',()async{
  final c=(oracle['cases'] as List).first as Map,token='a'*43;var current=token;final requests=<http.BaseRequest>[];
  final client=SettingsWire((r)async{requests.add(r);return http.StreamedResponse(Stream.value(utf8.encode(jsonEncode(c['raw']))),200);});
  final p=ApplicationSettingsPort.authenticated(origin:Uri.parse('https://fixture.test'),token:token,binding:binding,cache:SettingsCache(),names:names,labels:labels,defaults:defaults,currentToken:()=>current,currentScope:()=>scope,client:client);await p.read(const WorkQuery());expect(requests.length,2);for(final r in requests){expect(r.url.path,'/v1/user/preferences');expect(r.method,'POST');expect(r.headers['authorization'],'Bearer $token');}
  current='changed';await expectLater(p.read(const WorkQuery()),throwsA(isA<WorkFailure>().having((e)=>e.code,'code','denied')));expect(requests.length,2);p.dispose();expect(client.closed,false);client.close();
 });
 test('wrong-account owned snapshots become denied rather than retryable errors',()async{
  final raw=clone((oracle['cases'] as List).first['raw']);raw['scope']={...scope.toJson(),'userId':'other'};final p=port((_)async=>raw),s=WorkModuleSession(scope,'settings',port:p);await s.load();expect(s.status,'denied');expect(s.snapshot,isNull);s.dispose();
 });
 test('late responses are suppressed after native port disposal',()async{
  final reply=Completer<Object?>(),p=port((_)=>reply.future),pending=p.read(const WorkQuery());await Future<void>.delayed(Duration.zero);p.dispose();reply.complete((oracle['cases'] as List).first['raw']);await expectLater(pending,throwsA(isA<WorkFailure>().having((e)=>e.code,'code','unavailable')));
 });
}
