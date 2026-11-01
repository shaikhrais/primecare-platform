import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../preference_sync/preference_protocol.dart' show PreferenceScope;
import 'work_module_model.dart';

class TenantTaskRequest {
  final String method;
  final Map<String,String> filters;
  final Map<String,Object?>? body;
  final String? requestId;
  TenantTaskRequest(this.method,Map<String,String> filters,{Map<String,Object?>? body,this.requestId})
      : filters=Map.unmodifiable(filters),body=body==null?null:Map.unmodifiable(Map<String,Object?>.from(jsonDecode(jsonEncode(body)) as Map));
}
typedef TenantTaskTransport=Future<Object?> Function(TenantTaskRequest request);

/// Existing API16578/16579 only. Captured identity is a precondition, never an authorization grant.
class TenantTaskHttpTransport {
  final PreferenceScope scope;
  final String _token;
  final String? Function() currentToken;
  final PreferenceScope? Function() currentScope;
  final http.Client _client;
  final bool _owned;
  final Uri _url;
  final int maxBytes;
  final _requests=<Completer<void>>{};
  bool _dead=false;
  TenantTaskHttpTransport({required Uri origin,required String token,required this.scope,
    required this.currentToken,required this.currentScope,this.maxBytes=1048576,http.Client? client})
      : _token=token,_client=client??http.Client(),_owned=client==null,
        _url=origin.resolve('/v1/governance/tenant-dashboard') {
    if(origin.host.isEmpty||origin.userInfo.isNotEmpty||origin.hasQuery||origin.hasFragment||
      (origin.path.isNotEmpty&&origin.path!='/')||
      !(origin.scheme=='https'||origin.scheme=='http'&&['localhost','127.0.0.1'].contains(origin.host))||
      token.isEmpty||RegExp(r'[\x00-\x20\x7f]').hasMatch(token)||maxBytes<1||maxBytes>1048576){
      if(_owned)_client.close();throw const WorkFailure('invalid',400);
    }
  }
  void _check(){if(_dead)throw const WorkFailure('unavailable');final now=currentScope();
    if(currentToken()!=_token||now==null||!now.same(scope))throw const WorkFailure('denied',403);}
  Future<Object?> call(TenantTaskRequest request)async{
    _check();
    if(!['GET','POST'].contains(request.method)||request.filters['dataset']!=scope.dataset||
      request.filters.keys.any((k)=>!['dataset','search','taskOffset','status'].contains(k))||
      request.filters.values.any((v)=>v.length>200)||
      request.method=='GET'&&(request.body!=null||request.requestId!=null)||
      request.method=='POST'&&(request.body==null||request.filters.length!=1||
        !RegExp(r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',caseSensitive:false).hasMatch(request.requestId??'')))throw const WorkFailure('invalid',400);
    final encoded=request.body==null?null:utf8.encode(jsonEncode(request.body));
    if(encoded!=null&&encoded.length>65536)throw const WorkFailure('invalid',400);
    final abort=Completer<void>();_requests.add(abort);
    try{
      final wire=http.AbortableRequest(request.method,_url.replace(queryParameters:request.filters),abortTrigger:abort.future)
        ..followRedirects=false
        ..headers.addAll({'authorization':'Bearer $_token','cache-control':'no-store',
          if(request.method=='POST')'content-type':'application/json',
          if(request.method=='POST')'idempotency-key':request.requestId!});
      if(encoded!=null)wire.bodyBytes=encoded;
      final response=await _client.send(wire);
      try{_check();}on WorkFailure{await response.stream.listen(null).cancel();rethrow;}
      if(response.statusCode!=200){await response.stream.listen(null).cancel();_check();
        throw WorkFailure([401,403].contains(response.statusCode)?'denied':response.statusCode==409?'conflict':response.statusCode==400?'invalid':'error',response.statusCode);}
      if(response.contentLength!=null&&response.contentLength!>maxBytes){await response.stream.listen(null).cancel();_check();throw const WorkFailure('error',502);}
      final bytes=<int>[];
      await for(final chunk in response.stream){_check();if(bytes.length+chunk.length>maxBytes)throw const WorkFailure('error',502);bytes.addAll(chunk);}
      _check();final Object? raw=jsonDecode(utf8.decode(bytes));_check();return raw;
    }on WorkFailure{rethrow;}catch(_){_check();throw const WorkFailure('error',502);}
    finally{_requests.remove(abort);if(!abort.isCompleted)abort.complete();_check();}
  }
  void dispose(){if(_dead)return;_dead=true;for(final request in _requests){if(!request.isCompleted)request.complete();}_requests.clear();if(_owned)_client.close();}
}
