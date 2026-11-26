import 'dart:async';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_core/application_modules.dart';

class ApplicationCancellationCache implements PreferenceCache {
 @override Future<String?> read(String key)async=>null;
 @override Future<void> write(String key,String value)async{}
 @override Future<void> remove(String key)async{}
}
class HeldApplicationClient extends http.BaseClient {
  final bool holdHeaders;
  final replies=<Completer<http.StreamedResponse>>[];
  final bodies=<StreamController<List<int>>>[];
  int aborted=0;
  bool closed=false;
  HeldApplicationClient(this.holdHeaders);
  @override Future<http.StreamedResponse> send(http.BaseRequest request) {
    final reply=Completer<http.StreamedResponse>(),body=StreamController<List<int>>();
    replies.add(reply);bodies.add(body);
    if(request is http.AbortableRequest) {
      request.abortTrigger?.then((_){
        aborted++;
        if(!reply.isCompleted)reply.completeError(http.RequestAbortedException());
        else if(body.hasListener&&!body.isClosed)body.addError(http.RequestAbortedException());
        if(!body.isClosed)unawaited(body.close());
      });
    }
    if(!holdHeaders)reply.complete(http.StreamedResponse(body.stream,200));
    return reply.future;
  }
  void release() {
    for(var i=0;i<replies.length;i++) {
      if(!replies[i].isCompleted)replies[i].complete(http.StreamedResponse(Stream.value(utf8.encode('{}')),200));
      if(!bodies[i].isClosed)unawaited(bodies[i].close());
    }
  }
  @override void close(){closed=true;release();}
}
void main(){
  final scope=PreferenceScope('tenant1','user1','tenant_admin','live');
  for(final profile in [true,false])for(final headers in [true,false]) {
    test('${profile?'profile':'settings'} disposal cancels held ${headers?'headers':'body'} and preserves borrowed client',()async{
      final client=HeldApplicationClient(headers),token='a'*43;
      final WorkPort port=profile?ApplicationProfilePort(origin:Uri.parse('https://fixture.test'),token:token,scope:scope,
        currentToken:()=>token,currentScope:()=>scope,identityLabel:'Identity',client:client):
        ApplicationSettingsPort.authenticated(origin:Uri.parse('https://fixture.test'),token:token,
          binding:PreferenceBinding(scope:scope,kind:'shortcuts',resource:'navigation',screenIds:['1']),
          cache:ApplicationCancellationCache(),names:{'1':'Overview'},labels:{'shortcuts':'Shortcuts','editShortcuts':'Edit'},
          currentToken:()=>token,currentScope:()=>scope,client:client);
      final pending=(profile?port.read(const WorkQuery()):port.readItem('navigation')).then<Object?>((value)=>value,onError:(Object error)=>error);
      try{
        await Future<void>.delayed(Duration.zero);
        expect(client.replies.length,1);
        port.dispose();port.dispose();
        final result=await pending.timeout(const Duration(seconds:2));
        expect(result,isA<WorkFailure>().having((e)=>e.code,'code','unavailable'));
        expect(client.aborted,1);expect(client.closed,false);
      }finally{port.dispose();client.release();await pending;client.close();}
    });
  }
  for(final profile in [true,false])test('${profile?'profile':'settings'} completed requests retire before disposal',()async{
    final client=HeldApplicationClient(true),token='a'*43;
    final WorkPort port=profile?ApplicationProfilePort(origin:Uri.parse('https://fixture.test'),token:token,scope:scope,
      currentToken:()=>token,currentScope:()=>scope,identityLabel:'Identity',client:client):
      ApplicationSettingsPort.authenticated(origin:Uri.parse('https://fixture.test'),token:token,
        binding:PreferenceBinding(scope:scope,kind:'shortcuts',resource:'navigation',screenIds:['1']),
        cache:ApplicationCancellationCache(),names:{'1':'Overview'},labels:{'shortcuts':'Shortcuts','editShortcuts':'Edit'},
        currentToken:()=>token,currentScope:()=>scope,client:client);
    final pending=profile?port.read(const WorkQuery()):port.readItem('navigation');
    try{
      await Future<void>.delayed(Duration.zero);
      final raw=profile?{'status':'authenticated','roles':scope.role,'tenantId':scope.tenantId,'userId':scope.userId}:
        {'version':1,'scope':scope.toJson(),'kind':'shortcuts','resource':'navigation','revision':0,'document':null};
      client.replies.single.complete(http.StreamedResponse(Stream.value(utf8.encode(jsonEncode(raw))),200));
      await pending;port.dispose();await Future<void>.delayed(Duration.zero);
      expect(client.aborted,0);expect(client.closed,false);
    }finally{port.dispose();client.release();client.close();}
  });
  test('profile disposal aborts every concurrent request on a borrowed client',()async{
    final client=HeldApplicationClient(true),port=ApplicationProfilePort(origin:Uri.parse('https://fixture.test'),token:'token',scope:scope,
      currentToken:()=>'token',currentScope:()=>scope,identityLabel:'Identity',client:client);
    final pending=List.generate(2,(_)=>port.read(const WorkQuery()).then<Object?>((value)=>value,onError:(Object error)=>error));
    try{
      await Future<void>.delayed(Duration.zero);port.dispose();
      final results=await Future.wait(pending).timeout(const Duration(seconds:2));
      expect(client.aborted,2);expect(client.closed,false);
      for(final result in results)expect(result,isA<WorkFailure>().having((e)=>e.code,'code','unavailable'));
    }finally{port.dispose();client.release();await Future.wait(pending);client.close();}
  });
}
