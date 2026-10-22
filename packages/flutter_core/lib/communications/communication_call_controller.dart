import 'communication_command_controller.dart';
import 'communication_media.dart';
import 'communication_workspace_controller.dart';

final class _MediaUnavailable implements Exception {}

/// Call controls re-read server state before each action. Media remains an
/// explicit accepted-party action, with no automatic mutation retries.
final class CommunicationCallController extends CommunicationCommandControllerBase {
 CommunicationCallController({required super.hub,required super.userId,required super.tenantId,super.key,this.mediaFactory});
 final CommunicationMediaFactory? mediaFactory;
 String? _threadId;
 Map<String,Object?>? _conversation;
 CommunicationMediaSession? _media;
 String _mediaState='mediaClosed';
 bool _muted=false;
 int _mediaGeneration=0;
 String? get threadId=>_threadId;
 List<Map<String,Object?>> get calls=>(_conversation?['calls'] as List<Map<String,Object?>>?)??const [];
 bool get mediaConfigured=>mediaFactory!=null;
 bool get canInvite=>canMutate&&_conversation!=null&&!calls.any((c)=>{'ringing','accepted'}.contains(c['status']));
 bool canAccept(Map<String,Object?> call)=>canMutate&&call['recipientId']==userId&&call['status']=='ringing';
 bool canEnd(Map<String,Object?> call)=>canMutate&&{'ringing','accepted'}.contains(call['status']);
 bool canConnect(Map<String,Object?> call)=>canMutate&&!mediaActive&&call['status']=='accepted';
 String get mediaState=>_mediaState;
 bool get mediaActive=>_media!=null&&!_media!.closed;
 bool get muted=>_muted;
 @override String get pendingFailure=>'callPending';
 @override String get invalidFailure=>'callInvalid';
 void _closeMedia(){_mediaGeneration++;final media=_media;_media=null;_muted=false;_mediaState='mediaClosed';media?.close();}
 @override void clearPrivateState(){_closeMedia();_conversation=null;}
 /// Switching the message selection releases media immediately. An ambiguous
 /// call command keeps its original thread/key until explicitly confirmed.
 void selectThread(String? id){
  if(isDisposed||id==_threadId)return;
  _closeMedia();_conversation=null;_threadId=id;
  notifyListeners();
 }
 Map<String,Object?> _record(Map<String,Object?> value,String id){
  requireVersion(value,id);
  final members=value['members'],raw=value['calls'];
  if(value['kind']!='conversation'||members is! List||!members.contains(userId)||members.any((v)=>v is! String)||raw is! List)throw const FormatException('Call conversation unavailable');
  final visible=<Map<String,Object?>>[];final ids=<String>{};
  for(final entry in raw){
   if(entry is! Map||entry['id'] is! String||!ids.add(entry['id'] as String)||!members.contains(entry['callerId'])||!members.contains(entry['recipientId'])||entry['callerId']==entry['recipientId']||!{'ringing','accepted','declined','ended','missed'}.contains(entry['status']))throw const FormatException('Call record unavailable');
   if([entry['callerId'],entry['recipientId']].contains(userId))visible.add(Map.unmodifiable({'id':entry['id'],'callerId':entry['callerId'],'recipientId':entry['recipientId'],'status':entry['status']}));
  }
  return Map.unmodifiable({'id':id,'version':value['version'],'members':List<String>.unmodifiable(members.cast<String>()),'calls':List<Map<String,Object?>>.unmodifiable(visible)});
 }
 Future<Map<String,Object?>> _read(String id) async {final record=_record(await hub.messages.read(id),id);requireActive();return record;}
 Future<bool> refresh()=>run(() async {
  final id=identifier(_threadId??'');final record=await _read(id);
  if(id!=_threadId)return (){};
  return (){_conversation=record;if(!calls.any((c)=>c['status']=='accepted'))_closeMedia();};
 });
 Future<bool> invite(String recipient)=>mutate('audio','invite',() async {
  final id=identifier(_threadId??'');final current=await _read(id);if(id!=_threadId)throw CommunicationInputException();
  final target=identifier(recipient);
  if(target==userId||!(current['members'] as List).contains(target)||(current['calls'] as List<Map<String,Object?>>).any((c)=>{'ringing','accepted'}.contains(c['status'])))throw CommunicationInputException();
  return {'id':current['id'],'key':newKey(),'version':current['version'],'callId':newKey(),'recipientId':target};
 });
 Future<bool> act(String action,String callId){
  if(action=='end')_closeMedia(); // Local microphone release never waits for HTTP.
  return mutate('audio',action,() async {
   if(!{'accept','decline','end'}.contains(action))throw CommunicationInputException();
   final id=identifier(_threadId??'');final current=await _read(id);if(id!=_threadId)throw CommunicationInputException();
   final matches=(current['calls'] as List<Map<String,Object?>>).where((c)=>c['id']==callId);if(matches.length!=1)throw CommunicationInputException();final call=matches.single;
   if(action=='end'?!{'ringing','accepted'}.contains(call['status']):call['recipientId']!=userId||call['status']!='ringing')throw CommunicationInputException();
   return {'id':current['id'],'key':newKey(),'version':current['version'],'callId':callId};
  });
 }
 @override Future<CommunicationCommit> confirm(CommunicationPendingCommand command,Map<String,Object?> response) async {
  if(response['id']!=command.id||response['version']!=command.version+1)throw const FormatException('Call action unconfirmed');
  final record=await _read(command.id);
  if((record['version'] as int)<(response['version'] as int))throw const FormatException('Call reload regressed');
  final matches=(record['calls'] as List<Map<String,Object?>>).where((c)=>c['id']==command.fields['callId']);
  if(matches.length!=1||command.action=='invite'&&(matches.single['callerId']!=userId||matches.single['recipientId']!=command.fields['recipientId'])||command.action=='end'&&matches.single['status']!='ended'||command.action=='decline'&&matches.single['status']!='declined'||command.action=='accept'&&matches.single['status']=='ringing')throw const FormatException('Call state unconfirmed');
  return (){_closeMedia();if(_threadId==command.id)_conversation=record;};
 }
 Future<bool> connect(String callId)=>run(() async {
  final factory=mediaFactory;if(factory==null)throw _MediaUnavailable();
  if(hasPendingCommand||_media!=null)throw CommunicationInputException();
  final id=identifier(_threadId??'');final current=await _read(id);
  final matches=(current['calls'] as List<Map<String,Object?>>).where((c)=>c['id']==callId&&c['status']=='accepted');
  if(matches.length!=1||id!=_threadId)throw CommunicationInputException();
  _mediaState='mediaConnecting';
  final generation=_mediaGeneration;
  final session=await factory(hub:hub,userId:userId,tenantId:tenantId,threadId:id,callId:callId,onState:(state){
   if(isDisposed)return;
   _mediaState=switch(state){'connected'=>'mediaConnected','closed'=>'mediaClosed','failed'=>'mediaUnavailable',_=>'mediaConnecting'};
   if(state=='closed'){_muted=false;}
   notifyListeners();
  });
  if(isDisposed||id!=_threadId||generation!=_mediaGeneration){session.close();return (){};}
  _media=session;
  try{await session.start();requireActive();final after=await _read(id);if(id!=_threadId||session.closed||!(after['calls'] as List<Map<String,Object?>>).any((c)=>c['id']==callId&&c['status']=='accepted'))throw const FormatException('Media unavailable');}
  catch(_){session.close();if(identical(_media,session))_media=null;rethrow;}
  return (){_conversation=current;};
 });
 void toggleMute(){
  final media=_media;if(isDisposed||busy||media==null||media.closed)return;
  try{media.mute(!_muted);_muted=!_muted;_mediaState=_muted?'mediaMuted':'mediaConnected';notifyListeners();}
  catch(_){_closeMedia();showFailure('mediaUnavailable');}
 }
 @override String classify(Object error)=>error is _MediaUnavailable?'mediaUnavailable':super.classify(error);
}
