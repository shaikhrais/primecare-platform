import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'package:dio/dio.dart';
import 'communication_core.dart';
import 'communication_media.dart';

@JS('document') external _Document get _document;
@JS('globalThis.PrimecareCommunicationMedia') external _MediaApi? get _api;
extension type _Document(JSObject _) implements JSObject {
 external String get baseURI;
 external JSObject createElement(String tag);
 external _Element get head;
}
extension type _Element(JSObject _) implements JSObject {external void appendChild(JSObject node);}
extension type _Script(JSObject _) implements JSObject {
 external set src(String value);
 external set onload(JSFunction? value);
 external set onerror(JSFunction? value);
 external void remove();
}
extension type _MediaApi(JSObject _) implements JSObject {
 external int get version;
 external _Session create(JSFunction execute,JSFunction onState,String options);
}
extension type _Session(JSObject _) implements JSObject {
 external bool get closed;
 external JSPromise<JSAny?> start();
 external void mute(bool value);
 external void close();
}
Future<void>? _loading;
Future<void> _load(){
 if(_api?.version==1)return Future.value();
 return _loading??=_loadAsset().whenComplete(()=>_loading=null);
}
Future<void> _loadAsset() async {
 final completer=Completer<void>();
 final script=_Script(_document.createElement('script'));
 script.src=Uri.parse(_document.baseURI).resolve('assets/packages/flutter_core/assets/communications/audio-bridge.js').toString();
 script.onload=((JSAny? _){if(!completer.isCompleted){if(_api?.version==1){completer.complete();}else{completer.completeError(StateError('Browser media asset unavailable'));}}}).toJS;
 script.onerror=((JSAny? _){if(!completer.isCompleted)completer.completeError(StateError('Browser media asset unavailable'));}).toJS;
 _document.head.appendChild(script);
 try{await completer.future.timeout(const Duration(seconds:20));}
 finally{script.onload=null;script.onerror=null;script.remove();}
}
final class _BrowserSession extends CommunicationMediaSession {
 _BrowserSession(this.session);
 final _Session session;
 @override bool get closed=>session.closed;
 @override Future<void> start() async {await session.start().toDart;}
 @override void mute(bool muted)=>session.mute(muted);
 @override void close()=>session.close();
}
/// Configuration is trusted host composition, never a message or view field.
/// The injected provider may obtain fresh TURN credentials before constructing it.
CommunicationMediaFactory browserCommunicationMediaFactory({required Map<String,Object?> configuration}){
 final snapshot=jsonDecode(jsonEncode(configuration));
 if(snapshot is! Map||snapshot['iceServers'] is! List)throw ArgumentError('Configured ICE servers required');
 return ({required CommunicationHub hub,required String userId,required String tenantId,required String threadId,required String callId,required void Function(String) onState}) async {
  await _load();
  final execute=((JSString channel,JSString input){
   return (() async {
    try{
     final request=(jsonDecode(input.toDart) as Map).cast<String,Object?>();
     final result=await switch(channel.toDart){'message'=>hub.messages.execute(request['action'] as String,{...request}..remove('action')),'audio'=>hub.audio.execute(request['action'] as String,{...request}..remove('action')),_=>throw StateError('Unsupported browser channel')};
     return jsonEncode({'ok':true,'value':result}).toJS;
    }catch(error){return jsonEncode({'ok':false,'status':error is DioException?error.response?.statusCode:null}).toJS;}
   })().toJS;
  }).toJS;
  final state=((JSString value){onState(value.toDart);}).toJS;
  return _BrowserSession(_api!.create(execute,state,jsonEncode({'userId':userId,'tenantId':tenantId,'threadId':threadId,'callId':callId,'configuration':snapshot})));
 };
}
