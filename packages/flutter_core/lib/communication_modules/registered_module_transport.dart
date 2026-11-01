import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../communications/dio_communication_transport.dart';
import '../preference_sync/preference_protocol.dart' show PreferenceScope;
import '../work_modules/work_module_model.dart';

/// B14's existing six JSON operations. Channel clients and server retain their contracts.
final class RegisteredModuleHttpTransport extends CommunicationTransportBase {
  final PreferenceScope scope;final String _token;final Uri _origin;
  final String? Function() currentToken;final PreferenceScope? Function() currentScope;
  final http.Client _client;final bool _owned;final int maxBytes;
  final _requests=<Completer<void>>{};bool _dead=false;
  static Map<String,CommunicationRouteBinding> _routes()=>{
    'message.inbox':CommunicationRouteBinding(path:'/v1/messages/inbox',method:'GET',includeAction:false),
    for(final action in ['read','send','mark_read'])'message.$action':CommunicationRouteBinding(path:'/v1/messages',method:'POST'),
    'email.inbox':CommunicationRouteBinding(path:'/v1/messages/email/inbox',method:'GET',includeAction:false),
    'email.read':CommunicationRouteBinding(path:'/v1/messages/email',method:'POST'),
  };
  RegisteredModuleHttpTransport({required Uri origin,required String token,required this.scope,
    required this.currentToken,required this.currentScope,this.maxBytes=1048576,http.Client? client})
      :_origin=origin,_token=token,_client=client??http.Client(),_owned=client==null,super(_routes()){
    if(scope.dataset!='live'||origin.host.isEmpty||origin.userInfo.isNotEmpty||origin.hasQuery||origin.hasFragment||
      origin.path.isNotEmpty&&origin.path!='/'||!(origin.scheme=='https'||origin.scheme=='http'&&['localhost','127.0.0.1'].contains(origin.host))||
      token.isEmpty||RegExp(r'[\x00-\x20\x7f]').hasMatch(token)||maxBytes<1||maxBytes>1048576){if(_owned)_client.close();throw const WorkFailure('invalid',400);}
  }
  void _check(){if(_dead)throw const WorkFailure('unavailable');final now=currentScope();if(currentToken()!=_token||now==null||!now.same(scope))throw const WorkFailure('denied',401);}
  @override Future<Map<String,Object?>> dispatch(CommunicationRouteBinding binding,String channel,Map<String,Object?> request)async{
    _check();if(!identical(bindings['$channel.${request['action']}'],binding))throw const WorkFailure('denied',403);if(request.keys.any(['actor','actorId','userId','tenantId','role','roles','dataset'].contains))throw const WorkFailure('denied',403);
    final fields={for(final e in request.entries)if(binding.includeAction||e.key!='action')e.key:e.value};
    final bytes=utf8.encode(jsonEncode(fields));if(bytes.length>65536)throw const WorkFailure('invalid',400);
    final abort=Completer<void>();_requests.add(abort);
    try{
      final url=_origin.resolve(binding.path),wire=http.AbortableRequest(binding.method,binding.method=='GET'?url.replace(queryParameters:fields.map((k,v)=>MapEntry(k,'$v'))):url,abortTrigger:abort.future)
        ..followRedirects=false..headers.addAll({'authorization':'Bearer $_token','cache-control':'no-store',if(binding.method=='POST')'content-type':'application/json'});
      if(binding.method=='POST')wire.bodyBytes=bytes;
      final response=await _client.send(wire);try{_check();}on WorkFailure{await response.stream.listen(null).cancel();rethrow;}
      if(response.statusCode!=200){await response.stream.listen(null).cancel();_check();throw WorkFailure([401,403].contains(response.statusCode)?'denied':response.statusCode==409?'conflict':response.statusCode==400?'invalid':'error',response.statusCode);}
      if(response.contentLength!=null&&response.contentLength!>maxBytes){await response.stream.listen(null).cancel();_check();throw const WorkFailure('error',502);}
      final data=<int>[];await for(final chunk in response.stream){_check();if(data.length+chunk.length>maxBytes)throw const WorkFailure('error',502);data.addAll(chunk);}
      _check();final Object? raw=jsonDecode(utf8.decode(data));_check();if(raw is! Map||raw.keys.any((k)=>k is! String))throw const WorkFailure('error',502);
      return Map<String,Object?>.from(raw);
    }on WorkFailure{rethrow;}catch(_){_check();throw const WorkFailure('error',502);}
    finally{_requests.remove(abort);if(!abort.isCompleted)abort.complete();_check();}
  }
  void dispose(){if(_dead)return;_dead=true;for(final r in _requests){if(!r.isCompleted)r.complete();}_requests.clear();if(_owned)_client.close();}
}
