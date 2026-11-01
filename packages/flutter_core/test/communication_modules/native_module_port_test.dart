import 'dart:async';import 'dart:convert';import 'dart:io';
import 'package:flutter_test/flutter_test.dart';import 'package:http/http.dart' as http;
import 'package:flutter_core/communications/dio_communication_transport.dart' show CommunicationRouteBinding;
import 'package:flutter_core/communication_modules.dart';import 'package:flutter_core/preference_sync/preference_protocol.dart';
class ModuleStub implements CommunicationTransport{
 final Future<Map<String,Object?>> Function(String,Map<String,Object?>) handler;ModuleStub(this.handler);
 @override Future<Map<String,Object?>> execute(String channel,Map<String,Object?> request)=>handler(channel,request);
}
class ModuleWire extends http.BaseClient{
 final Future<http.StreamedResponse> Function(http.BaseRequest) handler;bool closed=false;ModuleWire(this.handler);
 @override Future<http.StreamedResponse> send(http.BaseRequest request)=>handler(request);
 @override void close(){closed=true;}
}
void main(){
 final oracle=jsonDecode(File('test/communication_modules/module-oracle.json').readAsStringSync()) as Map,scope=PreferenceScope.fromJson(oracle['scope']),labels=Map<String,String>.from(oracle['labels'] as Map);
 Map<String,Object?> clone(Object? v)=>Map<String,Object?>.from(jsonDecode(jsonEncode(v)) as Map);
 WorkCommand command(Map<dynamic,dynamic> c)=>WorkCommand(c['itemId'] as String,c['version'] as int,c['action'] as String,Map<String,String>.from(c['fields'] as Map));
 CommunicationModulePort port(String module,CommunicationTransport transport,{String? direction,String? mailbox})=>CommunicationModulePort(scope:scope,module:module,transport:transport,labels:labels,mailboxDirection:direction,mailboxId:mailbox);
 final thread=(oracle['cases'] as List).first['record'];
 test('eight native projections match shared web mailbox, messenger and attachment references',()async{
  for(final value in oracle['cases'] as List){final c=value as Map,record=c['record'] as Map,box=c['box'] as Map?;
   final p=port(c['module'] as String,ModuleStub((channel,r)async=>r['action']=='inbox'?{'items':channel=='email'?[{'id':record['id'],'version':record['version']}]:[record],if(channel=='email')'nextAfter':null}:clone(record)),direction:box?['direction'] as String?,mailbox:box?['id'] as String?);
   final raw=await p.read(const WorkQuery());expect(raw,c['expected'],reason:c['name'] as String);expect(jsonEncode(raw).contains('NEVER EXPOSE RAW'),false);p.dispose();
  }
 });
 test('send/read receipt and mark-read acknowledgement match shared commands and independent readback',()async{
  for(final value in oracle['mutations'] as List){final c=value as Map;var changed=false;Map<String,Object?>? sent;
   final p=port('messenger',ModuleStub((channel,r)async{if(r['action']=='inbox')return {'items':[c['record']]};if(r['action']=='read')return clone(c[changed?'reply':'record']);sent={'operation':'$channel.${r['action']}','value':{for(final e in r.entries)if(e.key!='action')e.key:e.value}};changed=true;return {'id':'thread1','version':3};}));
   await p.read(const WorkQuery());final receipt=await p.mutate(command(c['command'] as Map),c['key'] as String);expect(sent,c['request']);expect({'itemId':receipt.itemId,'version':receipt.version,'action':receipt.action,'expected':receipt.expected},c['receipt']);expect(await p.readItem('thread1'),c['readback']);p.dispose();
  }
 });
 test('uncertain sends replay the original key; acknowledged sends retry only verification',()async{
  final c=(oracle['mutations'] as List).first as Map;
  for(final lostAck in [true,false]){var changed=false,lost=true,writes=0;final requests=<Map<String,Object?>>[];
   final p=port('messenger',ModuleStub((_,r)async{if(r['action']=='inbox')return {'items':[c['record']]};if(r['action']=='read'){if(!lostAck&&lost){lost=false;throw const WorkFailure('error');}return clone(c['reply']);}requests.add(clone(r));if(!changed){changed=true;writes++;}if(lostAck&&lost){lost=false;throw const WorkFailure('error');}return {'id':'thread1','version':3};}));
   final session=WorkModuleSession(scope,'messenger',port:p,requestId:()=>c['key'] as String);await session.load();final cmd=command(c['command'] as Map);await expectLater(session.submit(cmd.itemId,cmd.action,cmd.fields),throwsA(isA<WorkFailure>()));await session.retryPending();expect(session.status,'success');expect(writes,1);expect(requests.length,lostAck?2:1);if(lostAck)expect(requests[0],requests[1]);session.dispose();
  }
 });
 test('membership, tenant and quarantine checks fail closed; readonly modules cannot mutate',()async{
  for(final raw in [{...clone(thread),'tenantId':'other'},{...clone(thread),'members':['other']}]){final p=port('messenger',ModuleStub((_,__)async=>{'items':[raw]}));await expectLater(p.read(const WorkQuery()),throwsA(isA<WorkFailure>().having((e)=>e.code,'code','denied')));p.dispose();}
  final c=(oracle['cases'] as List).firstWhere((c)=>c['name']=='mailbox-available') as Map;
  for(final change in [{'mailboxId':'other'},{'senderIdentityVerified':true},{'status':'accepted'}]){final raw={...clone(c['record']),...change},p=port('mailbox',ModuleStub((_,r)async=>r['action']=='inbox'?{'items':[{'id':raw['id'],'version':1}],'nextAfter':null}:raw),direction:'inbound',mailbox:'box1');await expectLater(p.read(const WorkQuery()),throwsA(isA<WorkFailure>()));p.dispose();}
  for(final module in ['mailbox','files']){var calls=0;final p=port(module,ModuleStub((_,__)async{calls++;return{};}),direction:'outbound');await expectLater(p.mutate(WorkCommand('x',1,'send',{'body':'No grant'}),'key'),throwsA(isA<WorkFailure>()));expect(calls,0);p.dispose();}
 });
 test('a forged receipt or mismatched independent message cannot become success',()async{
  for(final badReceipt in [true,false]){final p=port('messenger',ModuleStub((_,r)async{if(r['action']=='inbox')return{'items':[thread]};if(r['action']=='read')return {...clone(thread),'version':3};return {'id':badReceipt?'other':'thread1','version':3};}));final s=WorkModuleSession(scope,'messenger',port:p,requestId:()=> '00000000-0000-4000-8000-000000000001');await s.load();await expectLater(s.submit('thread1','send',{'body':'Not verified'}),throwsA(isA<WorkFailure>()));expect(s.status,'conflict');s.dispose();}
 });
 test('mail cursor pagination and stale query isolation preserve the active collection',()async{
  final c=(oracle['cases'] as List).firstWhere((c)=>c['name']=='mailbox-queued') as Map,cursors=<Object?>[];
  final p=port('mailbox',ModuleStub((_,r)async{if(r['action']=='inbox'){cursors.add(r['after']);return {'items':[{'id':(c['record'] as Map)['id'],'version':1}],'nextAfter':r['after']==null?'cursor1':null};}return clone(c['record']);}),direction:'outbound');await p.read(const WorkQuery());await p.read(const WorkQuery('',100));expect(cursors,[null,'cursor1']);await expectLater(p.read(const WorkQuery('',300)),throwsA(isA<WorkFailure>()));p.dispose();
  final old=Completer<Map<String,Object?>>(),latest=Completer<Map<String,Object?>>();var calls=0;final newer=port('messenger',ModuleStub((_,__)=>++calls==1?old.future:latest.future));final a=newer.read(const WorkQuery('old')),b=newer.read(const WorkQuery());latest.complete({'items':[thread]});await b;old.complete({'items':[thread]});await expectLater(a,throwsA(isA<WorkFailure>()));newer.dispose();
 });
 test('registered HTTP composes inherited clients without allowing provider or identity overrides',()async{
  final requests=<http.BaseRequest>[],client=ModuleWire((r)async{requests.add(r);return http.StreamedResponse(Stream.value(utf8.encode('{"ok":true}')),200);});
  final wire=RegisteredModuleHttpTransport(origin:Uri.parse('https://fixture.test'),token:'captured',scope:scope,currentToken:()=> 'captured',currentScope:()=>scope,client:client),messages=MessageChannelClient(wire),email=EmailChannelClient(wire);
  await messages.inbox(limit:100);await messages.read('thread1');await messages.send('thread1','key',2,'Text');await messages.markRead('thread1','read-key',2,1);await email.inbox(direction:'outbound');await email.read('mail1');
  expect(requests.map((r)=>r.url.path).toList(),['/v1/messages/inbox','/v1/messages','/v1/messages','/v1/messages','/v1/messages/email/inbox','/v1/messages/email']);
  for(final r in requests){expect(r.headers['authorization'],'Bearer captured');expect(r.followRedirects,false);}
  await expectLater(wire.execute('message',{'action':'read','id':'thread1','userId':'other'}),throwsA(isA<WorkFailure>()));await expectLater(wire.dispatch(CommunicationRouteBinding(path:'/v1/unregistered',method:'POST'),'message',{'action':'read','id':'thread1'}),throwsA(isA<WorkFailure>()));await expectLater(email.queue('mail','key','someone@example.invalid','Subject','No provider dispatch'),throwsA(isA<StateError>()));expect(requests.length,6);wire.dispose();expect(client.closed,false);client.close();
 });
 test('authenticated native session executes send and independent HTTP read before success',()async{
  final c=(oracle['mutations'] as List).first as Map,actions=<String>[];var changed=false;
  final client=ModuleWire((r)async{final request=r as http.Request;if(request.method=='GET')return http.StreamedResponse(Stream.value(utf8.encode(jsonEncode({'items':[c['record']]}))),200);final body=jsonDecode(request.body) as Map;actions.add(body['action'] as String);if(body['action']=='read')return http.StreamedResponse(Stream.value(utf8.encode(jsonEncode(c[changed?'reply':'record']))),200);changed=true;return http.StreamedResponse(Stream.value(utf8.encode('{"id":"thread1","version":3}')),200);});
  final p=CommunicationModulePort.authenticated(origin:Uri.parse('https://fixture.test'),token:'captured',scope:scope,module:'messenger',labels:labels,currentToken:()=> 'captured',currentScope:()=>scope,client:client),s=WorkModuleSession(scope,'messenger',port:p,requestId:()=>c['key'] as String);await s.load();final cmd=command(c['command'] as Map);await s.submit(cmd.itemId,cmd.action,cmd.fields);expect(s.status,'success');expect(actions,['send','read']);s.dispose();expect(client.closed,false);client.close();
 });
 test('HTTP rejects changed sessions, oversized replies, invalid JSON and redirects',()async{
  for(final mode in ['scope','large','json','redirect']){var token='captured';final client=ModuleWire((_)async{if(mode=='scope')token='other';return http.StreamedResponse(Stream.value(mode=='large'?List.filled(65,65):utf8.encode(mode=='json'?'{bad':'{}')),mode=='redirect'?302:200);});final wire=RegisteredModuleHttpTransport(origin:Uri.parse('https://fixture.test'),token:'captured',scope:scope,currentToken:()=>token,currentScope:()=>scope,client:client,maxBytes:64);await expectLater(MessageChannelClient(wire).read('thread1'),throwsA(isA<WorkFailure>()));wire.dispose();client.close();}
 });
 test('transport disposal requests abort and leaves borrowed clients owned by their host',()async{
  final started=Completer<http.AbortableRequest>(),client=ModuleWire((r)async{final abort=r as http.AbortableRequest;started.complete(abort);await abort.abortTrigger;throw http.ClientException('aborted');});
  final wire=RegisteredModuleHttpTransport(origin:Uri.parse('https://fixture.test'),token:'captured',scope:scope,currentToken:()=> 'captured',currentScope:()=>scope,client:client),pending=MessageChannelClient(wire).read('thread1');await started.future;final failure=expectLater(pending,throwsA(isA<WorkFailure>().having((e)=>e.code,'code','unavailable')));wire.dispose();await failure;expect(client.closed,false);client.close();
 });
}
