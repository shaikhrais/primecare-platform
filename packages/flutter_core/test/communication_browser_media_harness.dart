// Browser-only isolated transport fixture, compiled for real Chromium acceptance.
import 'dart:convert';
import 'dart:js_interop';
import 'package:dio/dio.dart';
import 'package:flutter_core/communications/communication_core.dart';
import 'package:flutter_core/communications/communication_media.dart';
import 'package:flutter_core/communications/communication_browser_media.dart';
@JS('globalThis.primecareFlutterAudio') external set _api(JSObject value);
extension type _Harness._(JSObject _) implements JSObject {
 external factory _Harness({required JSFunction start,required JSFunction mute,required JSFunction close});
}
final record=<String,Object?>{'id':'thread','tenantId':'tenant','kind':'conversation','version':3,'members':['alice','bob'],'calls':[<String,Object?>{'id':'call','callerId':'alice','recipientId':'bob','status':'accepted','signals':<Object?>[]}]};
class Transport implements CommunicationTransport {
 Transport(this.user);
 final String user;
 @override Future<Map<String,Object?>> execute(String channel,Map<String,Object?> input) async {
  if(channel=='message')return (jsonDecode(jsonEncode(record)) as Map).cast<String,Object?>();
  if(channel!='audio'||input['action']!='signal')throw StateError('Unexpected browser fixture operation');
  if(input['version']!=record['version']){final request=RequestOptions(path:'/synthetic');throw DioException(requestOptions:request,response:Response(requestOptions:request,statusCode:409));}
  record['version']=(record['version'] as int)+1;
  final call=(record['calls'] as List).single as Map;
  if((input['signal'] as Map)['type']=='offer')call['offered']=true;
  if((input['signal'] as Map)['type']=='answer')call['answered']=true;
  (call['signals'] as List).add({'sequence':(call['signals'] as List).length+1,'actorId':user,'signal':input['signal']});
  return {'id':'thread','version':record['version']};
 }
}
void main(){
 final sessions=<CommunicationMediaSession>[];
 final factory=browserCommunicationMediaFactory(configuration:{'iceServers':<Object?>[]});
 _api=_Harness(start:((){return (() async {
  for(final user in ['alice','bob']){
   final media=await factory(hub:CommunicationHub(Transport(user)),userId:user,tenantId:'tenant',threadId:'thread',callId:'call',onState:(state){});
   sessions.add(media);await media.start();
  }
  return true.toJS;
 })().toJS;}).toJS,mute:((JSBoolean value){sessions.first.mute(value.toDart);}).toJS,close:((){for(final media in sessions){media.close();}sessions.clear();}).toJS);
}
