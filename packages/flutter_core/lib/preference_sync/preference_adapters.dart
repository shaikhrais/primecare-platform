import 'dart:convert';import 'package:http/http.dart' as http;import 'package:shared_preferences/shared_preferences.dart';import 'preference_sync_client.dart';
class SharedPreferenceCache implements PreferenceCache {
 final SharedPreferences preferences;SharedPreferenceCache(this.preferences);
 @override Future<String?> read(String key)async=>preferences.getString(key);
 @override Future<void> write(String key,String value)async{if(!await preferences.setString(key,value))throw const PreferenceFailure('cache_unavailable',500);}
 @override Future<void> remove(String key)async{if(!await preferences.remove(key))throw const PreferenceFailure('cache_unavailable',500);}
}
/// Session-owned adapter; close it together with the actor-bound sync client.
class PreferenceHttpTransport {
 final http.Client client;final Uri _url;final String _token;
 PreferenceHttpTransport({required Uri origin,required String token,http.Client? client}):client=client??http.Client(),_url=origin.resolve('/v1/user/preferences'),_token=token{
 if((origin.scheme!='https'&&!(origin.scheme=='http'&&['localhost','127.0.0.1'].contains(origin.host)))||origin.userInfo.isNotEmpty||origin.hasQuery||origin.hasFragment||origin.path.isNotEmpty&&origin.path!='/'||!RegExp(r'^[A-Za-z0-9_-]{43}$').hasMatch(token))throw const PreferenceFailure('invalid_transport',400);
 }
 Future<Object?> call(Map<String,dynamic> body)async{http.StreamedResponse response;try{final request=http.Request('POST',_url)..followRedirects=false..headers.addAll({'authorization':'Bearer $_token','content-type':'application/json'})..body=jsonEncode(body);response=await client.send(request);}catch(_){throw const PreferenceFailure('offline');}Object? raw;try{final bytes=<int>[];await for(final chunk in response.stream){if(bytes.length+chunk.length>262144)throw const FormatException();bytes.addAll(chunk);}raw=jsonDecode(utf8.decode(bytes));}catch(_){throw const PreferenceFailure('invalid_response',502);}if(response.statusCode<200||response.statusCode>=300){final value=raw is Map?raw:const <String,Object?>{},error=value['error'];throw PreferenceFailure(error is String&&RegExp(r'^[a-z_]{1,80}$').hasMatch(error)?error:'request_failed',response.statusCode,value['current']);}return raw;}
 void close()=>client.close();
}
