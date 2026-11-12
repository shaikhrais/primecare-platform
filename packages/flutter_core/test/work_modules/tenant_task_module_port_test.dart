import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_core/work_modules.dart';
import 'package:flutter_core/preference_sync/preference_protocol.dart';

class WireClient extends http.BaseClient {
  final Future<http.StreamedResponse> Function(http.BaseRequest) handler;bool closed=false;
  WireClient(this.handler);
  @override Future<http.StreamedResponse> send(http.BaseRequest request)=>handler(request);
  @override void close(){closed=true;}
}
void main(){
 final oracle=jsonDecode(File('test/work_modules/tenant-task-oracle.json').readAsStringSync()) as Map;
 final scope=PreferenceScope.fromJson(oracle['scope']),labels=Map<String,String>.from(oracle['labels'] as Map);
 Map<String,dynamic> clone(Object? value)=>Map<String,dynamic>.from(jsonDecode(jsonEncode(value)) as Map);
 TenantTaskModulePort port(String module,TenantTaskTransport transport)=>TenantTaskModulePort(scope:scope,module:module,labels:labels,transport:transport);
 final first=clone((oracle['cases'] as List).cast<Map<dynamic,dynamic>>().firstWhere((c)=>c['name']=='tasks-open-manager')['raw']);
 WorkCommand command(Map<dynamic,dynamic> c)=>WorkCommand(c['itemId'] as String,c['version'] as int,c['action'] as String,Map<String,String>.from(c['fields'] as Map));
 test('60 native projections match the existing shared web adapter exactly',()async{
  for(final value in oracle['cases'] as List){final c=value as Map,p=port(c['module'] as String,(_ )async=>clone(c['raw']));
   expect(await p.read(const WorkQuery()),c['expected'],reason:c['name'] as String);p.dispose();}
 });
 test('52 native mutations match existing wire commands, receipts and independent readback',()async{
  for(final value in oracle['mutations'] as List){final c=value as Map;var changed=false;TenantTaskRequest? sent;
   final p=port(c['module'] as String,(r)async{if(r.method=='POST'){sent=r;changed=true;}return clone(c[changed?'reply':'raw']);});
   await p.read(const WorkQuery());final receipt=await p.mutate(command(c['command'] as Map),c['key'] as String);
   final expected=c['request'] as Map;expect(sent!.method,expected['method']);expect(sent!.filters,expected['filters']);expect(sent!.body,expected['body']);expect(sent!.requestId,expected['requestId']);
   expect({'itemId':receipt.itemId,'version':receipt.version,'action':receipt.action,'expected':receipt.expected},c['receipt']);
   expect(await p.readItem('task1'),c['readback']);p.dispose();
  }
 });
 test('lost acknowledgements replay the original receipt once through the native session',()async{
  final c=(oracle['mutations'] as List).cast<Map<dynamic,dynamic>>().firstWhere((c)=>c['name']=='tasks-open-manager-edit'),keys=<String>[],bodies=<Object?>[];var changed=false,lost=true,writes=0;
  final p=port('tasks',(r)async{if(r.method=='POST'){keys.add(r.requestId!);bodies.add(r.body);if(!changed){writes++;changed=true;}if(lost){lost=false;throw const WorkFailure('error');}}return clone(c[changed?'reply':'raw']);});
  final session=WorkModuleSession(scope,'tasks',port:p,requestId:()=>c['key'] as String);await session.load();
  final cmd=command(c['command'] as Map);await expectLater(session.submit(cmd.itemId,cmd.action,cmd.fields),throwsA(isA<WorkFailure>()));expect(session.pending,isNotNull);
  await session.retryPending();expect(session.status,'success');expect(writes,1);expect(keys.length,2);expect(keys[0],keys[1]);expect(bodies[0],bodies[1]);session.dispose();
 });
 test('acknowledged saves retry readback without another mutation',()async{
  final c=(oracle['mutations'] as List).cast<Map<dynamic,dynamic>>().firstWhere((c)=>c['name']=='tasks-open-manager-edit');var changed=false,failRead=true,writes=0;
  final p=port('tasks',(r)async{if(r.method=='POST'){changed=true;writes++;}else if(changed&&failRead){failRead=false;throw const WorkFailure('error');}return clone(c[changed?'reply':'raw']);});
  final session=WorkModuleSession(scope,'tasks',port:p,requestId:()=>c['key'] as String);await session.load();final cmd=command(c['command'] as Map);
  await expectLater(session.submit(cmd.itemId,cmd.action,cmd.fields),throwsA(isA<WorkFailure>()));expect(session.pendingReceipt,isNotNull);
  await session.retryPending();expect(session.status,'success');expect(writes,1);session.dispose();
 });
 for(final staleVersion in [1,2])test('stale rename readback $staleVersion retains original verification search for retry',()async{
  final c=(oracle['mutations'] as List).cast<Map<dynamic,dynamic>>().firstWhere((c)=>c['name']=='tasks-open-manager-edit');
  final cmd=command(c['command'] as Map),before=clone(c['raw']),searches=<String>[];
  (before['tasks'] as List).cast<Map<dynamic,dynamic>>().single['title']='${cmd.fields['title']} draft';
  var changed=false,reads=0,writes=0;
  final p=port('tasks',(r)async{
   if(r.method=='POST'){changed=true;writes++;return clone(c['reply']);}
   if(!changed)return before;
   searches.add(r.filters['search']!);
   final stale=++reads==1,response=stale?clone(before):clone(c['reply']);
   if(stale)(response['tasks'] as List).cast<Map<dynamic,dynamic>>().single['version']=staleVersion;
   final row=(response['tasks'] as List).cast<Map<dynamic,dynamic>>().single;
   if(!(row['title'] as String).toLowerCase().contains(r.filters['search']!.toLowerCase())){response['tasks']=<Object?>[];response['taskPage']={'total':0};}
   return response;
  });
  final session=WorkModuleSession(scope,'tasks',port:p,requestId:()=>c['key'] as String);await session.load();
  await expectLater(session.submit(cmd.itemId,cmd.action,cmd.fields),throwsA(isA<WorkFailure>()));
  expect(session.pendingReceipt,isNotNull);await session.retryPending();
  expect(session.status,'success');expect(writes,1);expect(searches,[cmd.fields['title'],cmd.fields['title']]);session.dispose();
 });
 test('contacts remain read-only; scope, engine, versions and field grants fail closed',()async{
  final contacts=port('contacts',(_)async=>first);await contacts.read(const WorkQuery());await expectLater(contacts.mutate(WorkCommand('staff:worker',1,'edit',{'body':'x'}),'00000000-0000-4000-8000-000000000001'),throwsA(isA<WorkFailure>()));contacts.dispose();
  for(final raw in [ {...first,'database':'SQLite'}, {...first,'identity':{'userId':'other','role':scope.role}}, {...first,'organization':{'id':'other'}}, {...first,'synthetic':true} ]){
   final p=port('tasks',(_)async=>raw);await expectLater(p.read(const WorkQuery()),throwsA(isA<WorkFailure>().having((e)=>e.code,'code','denied')));p.dispose();
  }
  for(final selfOwner in [true,false]){
   final raw=clone(first),task=(raw['tasks'] as List).cast<Map<dynamic,dynamic>>().single;task['status']='submitted';task['owner_id']=selfOwner?'manager':'worker';task['submitted_by']=selfOwner?'worker':'manager';task['actions']=['complete','return'];
   final guarded=port('tasks',(_)async=>raw),snapshot=WorkSnapshot.fromJson(await guarded.read(const WorkQuery()),scope,'tasks');expect(snapshot.items.single.actions.any((a)=>a.id=='complete'),false);if(!selfOwner)expect(snapshot.items.single.actions.any((a)=>a.id=='return'),false);
   await expectLater(guarded.mutate(WorkCommand('task1',1,'complete',{'body':'Independent approval required'}),'00000000-0000-4000-8000-000000000001'),throwsA(isA<WorkFailure>()));guarded.dispose();
  }
  var posts=0;final p=port('tasks',(r)async{if(r.method=='POST')posts++;return first;});await p.read(const WorkQuery());
  for(final cmd in [WorkCommand('task1',99,'edit',{'title':'New title','body':'Note','date':'2026-11-02'}),WorkCommand('task1',1,'edit',{'role':'admin'}),WorkCommand('task1',1,'invented',{'body':'No grant'})]){await expectLater(p.mutate(cmd,'00000000-0000-4000-8000-000000000001'),throwsA(isA<WorkFailure>()));}expect(posts,0);p.dispose();
 });
 test('readback follows renamed tasks across bounded pages and fails on missing identity',()async{
  final c=(oracle['mutations'] as List).cast<Map<dynamic,dynamic>>().firstWhere((c)=>c['name']=='tasks-open-manager-edit'),offsets=<String>[];var changed=false;
  final p=port('tasks',(r)async{if(r.method=='POST'){changed=true;return clone(c['reply']);}if(!changed)return clone(c['raw']);offsets.add(r.filters['taskOffset']!);expect(r.filters['search'],'Updated task');final raw=clone(c['reply']);raw['taskPage']={'total':201};if(r.filters['taskOffset']!='200')raw['tasks']=<Object?>[];return raw;});
  await p.read(const WorkQuery());await p.mutate(command(c['command'] as Map),c['key'] as String);expect((await p.readItem('task1') as Map)['offset'],200);expect(offsets,['0','100','200']);await expectLater(p.readItem('missing'),throwsA(isA<WorkFailure>()));p.dispose();
 });
 test('disposed ports ignore delayed data and close an owned transport once',()async{
  final reply=Completer<Object?>();var closes=0;final p=TenantTaskModulePort(scope:scope,module:'tasks',labels:labels,transport:(_)=>reply.future,closeTransport:()=>closes++);
  final pending=p.read(const WorkQuery());p.dispose();p.dispose();reply.complete(first);await expectLater(pending,throwsA(isA<WorkFailure>().having((e)=>e.code,'code','unavailable')));expect(closes,1);
 });
 test('a delayed older query cannot replace the newer native adapter context',()async{
  final old=Completer<Object?>(),latest=Completer<Object?>();var reads=0;final posted=<Map<String,Object?>?>[];
  final p=port('tasks',(r)async{if(r.method=='POST'){posted.add(r.body);final next=clone(first);(next['tasks'] as List).cast<Map<dynamic,dynamic>>().single['version']=3;return next;}return (++reads==1?old:latest).future;});
  final a=p.read(const WorkQuery('old')),b=p.read(const WorkQuery('new'));final fresh=clone(first);(fresh['tasks'] as List).cast<Map<dynamic,dynamic>>().single['version']=2;
  latest.complete(fresh);await b;old.complete(first);await expectLater(a,throwsA(isA<WorkFailure>()));
  await p.mutate(WorkCommand('task1',2,'edit',{'title':'New task','body':'Updated note','date':'2026-11-02'}),'00000000-0000-4000-8000-000000000001');expect(posted.single!['version'],2);p.dispose();
 });
 test('native HTTP uses exact registered endpoint, bearer and original request key',()async{
  final requests=<http.BaseRequest>[],client=WireClient((r)async{requests.add(r);return http.StreamedResponse(Stream.value(utf8.encode(jsonEncode(first))),200);});
  final wire=TenantTaskHttpTransport(origin:Uri.parse('https://fixture.test'),token:'captured',scope:scope,currentToken:()=> 'captured',currentScope:()=>scope,client:client);
  await wire.call(TenantTaskRequest('GET',{'dataset':'live','status':'all'}));await wire.call(TenantTaskRequest('POST',{'dataset':'live'},body:{'action':'edit'},requestId:'00000000-0000-4000-8000-000000000001'));
  expect(requests.length,2);for(final r in requests){expect(r.url.path,'/v1/governance/tenant-dashboard');expect(r.followRedirects,false);expect(r.headers['authorization'],'Bearer captured');expect(r,isA<http.AbortableRequest>());}expect(requests.last.headers['idempotency-key'],'00000000-0000-4000-8000-000000000001');wire.dispose();expect(client.closed,false);client.close();
 });
 test('HTTP cancellation on disposal requests abort without closing a borrowed client',()async{
  final started=Completer<http.AbortableRequest>();final client=WireClient((r)async{final abortable=r as http.AbortableRequest;started.complete(abortable);await abortable.abortTrigger;throw http.ClientException('aborted');});
  final wire=TenantTaskHttpTransport(origin:Uri.parse('https://fixture.test'),token:'captured',scope:scope,currentToken:()=> 'captured',currentScope:()=>scope,client:client);
  final pending=wire.call(TenantTaskRequest('GET',{'dataset':'live'})),request=await started.future;final failed=expectLater(pending,throwsA(isA<WorkFailure>().having((e)=>e.code,'code','unavailable')));wire.dispose();await request.abortTrigger;
  await failed;expect(client.closed,false);
 });
 test('HTTP rejects session changes, oversized streams, malformed JSON and redirects',()async{
  for(final mode in ['scope','large','json','redirect']){var token='captured';final client=WireClient((r)async{if(mode=='scope')token='other';return http.StreamedResponse(Stream.value(mode=='large'?List.filled(65,65):utf8.encode(mode=='json'?'{bad':'{}')),mode=='redirect'?302:200);});
   final wire=TenantTaskHttpTransport(origin:Uri.parse('https://fixture.test'),token:'captured',scope:scope,currentToken:()=>token,currentScope:()=>scope,client:client,maxBytes:64);
   await expectLater(wire.call(TenantTaskRequest('GET',{'dataset':'live'})),throwsA(isA<WorkFailure>()));wire.dispose();client.close();
  }
 });
 test('authenticated factory completes the native session HTTP save and independent readback',()async{
  final c=(oracle['mutations'] as List).cast<Map<dynamic,dynamic>>().firstWhere((c)=>c['name']=='tasks-open-manager-edit'),methods=<String>[];var changed=false;
  final client=WireClient((r)async{methods.add(r.method);if(r.method=='POST'){changed=true;expect(jsonDecode((r as http.Request).body),(c['request'] as Map)['body']);}return http.StreamedResponse(Stream.value(utf8.encode(jsonEncode(c[changed?'reply':'raw']))),200);});
  final p=TenantTaskModulePort.authenticated(origin:Uri.parse('https://fixture.test'),token:'captured',scope:scope,module:'tasks',labels:labels,currentToken:()=> 'captured',currentScope:()=>scope,client:client);
  final session=WorkModuleSession(scope,'tasks',port:p,requestId:()=>c['key'] as String);await session.load();final cmd=command(c['command'] as Map);await session.submit(cmd.itemId,cmd.action,cmd.fields);
  expect(session.status,'success');expect(methods,['GET','POST','GET']);expect(session.snapshot!.items.single.version,2);session.dispose();await expectLater(p.read(const WorkQuery()),throwsA(isA<WorkFailure>()));expect(client.closed,false);client.close();
 });
 test('demo writes preserve workspace revision and requests cannot override dataset',()async{
  final demoScope=PreferenceScope(scope.tenantId,scope.userId,scope.role,'demo'),raw=clone(first)..['dataset']='demo'..['synthetic']=true..['workspaceVersion']=7;TenantTaskRequest? posted;
  final p=TenantTaskModulePort(scope:demoScope,module:'notes',labels:labels,transport:(r)async{if(r.method=='POST'){posted=r;final reply=clone(raw);(reply['tasks'] as List).cast<Map<dynamic,dynamic>>().single['version']=2;return reply;}return raw;});
  await p.read(const WorkQuery());await p.mutate(WorkCommand('task1',1,'edit',{'body':'Updated note'}),'00000000-0000-4000-8000-000000000001');expect(posted!.body!['workspaceVersion'],7);expect(posted!.filters['dataset'],'demo');p.dispose();
  final wire=TenantTaskHttpTransport(origin:Uri.parse('https://fixture.test'),token:'captured',scope:scope,currentToken:()=> 'captured',currentScope:()=>scope);
  await expectLater(wire.call(TenantTaskRequest('GET',{'dataset':'demo'})),throwsA(isA<WorkFailure>()));wire.dispose();
 });
}
