import 'dart:math';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'communication_core.dart';
import 'communication_workspace_catalog.dart';

typedef CommunicationCommit = void Function();
final class CommunicationPictureSelection {
 const CommunicationPictureSelection({required this.length,required this.bytes});
 final int length;
 final Stream<List<int>> bytes;
}
typedef CommunicationPicturePicker = Future<CommunicationPictureSelection?> Function();
final class _InvalidCommunicationInput implements Exception {}
Object? _freeze(Object? value) {
 if(value is Map)return Map<String,Object?>.unmodifiable(value.map((key,value)=>MapEntry(key as String,_freeze(value))));
 if(value is List)return List<Object?>.unmodifiable(value.map(_freeze));
 return value;
}

/// One lifecycle for every communication view: no queued clicks, late commits or
/// provider-error strings in presentation. Subclasses supply channel operations.
abstract class CommunicationWorkspaceControllerBase extends ChangeNotifier {
 bool _disposed=false;
 bool _busy=false;
 String? _failureKey;
 bool get isDisposed=>_disposed;
 bool get busy=>_busy;
 String? get failureKey=>_failureKey;
 @protected void clearPrivateState();
 @protected void operationFailed(Object error);
 @protected String classify(Object error) {
  if(error is _InvalidCommunicationInput)return 'invalidInput';
  final status=error is DioException?error.response?.statusCode:null;
  return switch(status){401=>'unauthenticated',403=>'forbidden',404=>'notFound',409=>'conflict',400||413||415=>'invalidInput',_=>'unavailable'};
 }
 @protected void requireActive(){if(_disposed)throw StateError('Communication controller disposed');}
 @protected Future<bool> run(Future<CommunicationCommit> Function() operation) async {
  if(_disposed||_busy)return false;
  _busy=true;_failureKey=null;notifyListeners();
  try {
   final commit=await operation();if(_disposed)return false;
   commit();return true;
  }catch(error){
   if(!_disposed){if(error is! _InvalidCommunicationInput)clearPrivateState();operationFailed(error);_failureKey=classify(error);}
   return false;
  }finally{if(!_disposed){_busy=false;notifyListeners();}}
 }
 @protected void showFailure(String key){if(!_disposed){_failureKey=key;notifyListeners();}}
 @override void dispose(){if(_disposed)return;_disposed=true;clearPrivateState();super.dispose();}
}

final class _PendingMessageCommand {
 _PendingMessageCommand(this.action,Map<String,Object?> fields):fields=_freeze(fields) as Map<String,Object?>;
 final String action;
 final Map<String,Object?> fields;
 bool uncertain=false;
 String get id=>fields['id'] as String;
}

/// Presentation state and commands, shared by all registered messaging screens.
/// Identity selects local scope only; transport/server always owns authorization.
final class CommunicationWorkspaceController extends CommunicationWorkspaceControllerBase {
 CommunicationWorkspaceController({required this.hub,required this.userId,required this.tenantId,String Function()? key})
  :_key=key??_randomKey {
  if(userId.trim().isEmpty||tenantId.trim().isEmpty)throw ArgumentError('Authenticated communication identity required');
 }
 final CommunicationHub hub;
 final String userId,tenantId;
 final String Function() _key;
 static final _random=Random.secure();
 static String _randomKey()=>List.generate(16,(_)=>_random.nextInt(256).toRadixString(16).padLeft(2,'0')).join();
 List<Map<String,Object?>> _inbox=const [];
 Map<String,Object?>? _thread;
 List<String> _draftPictureIds=const [];
 Uint8List? _preview;
 _PendingMessageCommand? _pending;
 List<Map<String,Object?>> get inbox=>_inbox;
 Map<String,Object?>? get thread=>_thread;
 List<String> get draftPictureIds=>_draftPictureIds;
 Uint8List? get previewBytes=>_preview==null?null:Uint8List.fromList(_preview!);
 bool get hasPendingCommand=>_pending!=null;
 bool get canMutate=>!busy&&!isDisposed&&_pending==null;
 @override void clearPrivateState(){_inbox=const [];_thread=null;_draftPictureIds=const [];_preview=null;}
 @override void dispose(){_pending=null;super.dispose();}
 @override void operationFailed(Object error){
  final status=error is DioException?error.response?.statusCode:null;
  final command=_pending;if(command==null)return;
  // A later denied read/retry cannot prove that an earlier ambiguous write failed.
  if(command.uncertain||status==null||status>=500||status==408){command.uncertain=true;}
  else if(status>=400&&status<500){_pending=null;}
 }
 @override String classify(Object error){
  final key=super.classify(error);
  return _pending!=null&&!{'unauthenticated','forbidden','notFound','conflict'}.contains(key)?'uncertain':key;
 }
 String _text(String value,{int max=200}) {
  final result=value.trim();
  if(result.isEmpty||result.length>max||RegExp(r'[\x00-\x1f\x7f]').hasMatch(result))throw _InvalidCommunicationInput();
  return result;
 }
 Map<String,Object?> _record(Map<String,Object?> result,[String? id]) {
  if(result['id'] is! String||id!=null&&result['id']!=id||result['tenantId']!=tenantId||result['kind']!='conversation'||result['version'] is! int||(result['version'] as int)<1||result['members'] is! List||!(result['members'] as List).contains(userId)||result['messages'] is! List)throw const FormatException('Communication scope unavailable');
  return _freeze(result) as Map<String,Object?>;
 }
 void _select(Map<String,Object?> value,{bool clearDraft=true}) {
  _thread=value;_preview=null;
  if(clearDraft)_draftPictureIds=const [];
  final records=[..._inbox.where((item)=>item['id']!=value['id']),value]..sort((a,b)=>(a['id'] as String).compareTo(b['id'] as String));
  _inbox=List.unmodifiable(records.take(CommunicationWorkspaceCatalog.limits['inboxLimit']!));
 }
 Future<bool> loadInbox()=>run(() async {
  final response=await hub.messages.inbox(limit:CommunicationWorkspaceCatalog.limits['inboxLimit']!);requireActive();
  if(response['items'] is! List)throw const FormatException('Communication inbox unavailable');
  final records=(response['items'] as List).map((item)=>_record(Map<String,Object?>.from(item as Map))).toList();
  if(records.length>CommunicationWorkspaceCatalog.limits['inboxLimit']!)throw const FormatException('Communication inbox limit');
  return ()=>_inbox=List.unmodifiable(records);
 });
 Future<bool> openThread(String id)=>run(() async {
  final selected=_text(id);final record=_record(await hub.messages.read(selected),selected);requireActive();
  return ()=>_select(record);
 });
 Future<CommunicationCommit> _executePending(_PendingMessageCommand pending) async {
  final result=await hub.messages.execute(pending.action,pending.fields);requireActive();
  final expectedVersion=(pending.fields['version'] as int?)??0;
  if(result['id']!=pending.id||result['version']!=expectedVersion+1)throw const FormatException('Communication action unconfirmed');
  final record=_record(await hub.messages.read(pending.id),pending.id);requireActive();
  if((record['version'] as int)<(result['version'] as int))throw const FormatException('Communication reload regressed');
  return (){_pending=null;_select(record);};
 }
 Future<bool> _mutation(String action,Map<String,Object?> Function() fields) {
  if(_pending!=null){showFailure('uncertain');return Future.value(false);}
  return run(() async {
   final command=_PendingMessageCommand(action,fields());_pending=command;
   return _executePending(command);
  });
 }
 Future<bool> createConversation(String recipients,String reference)=>_mutation('create',(){
  final members=<String>[userId];
  for(final item in recipients.split(',')){if(item.trim().isEmpty)continue;final member=_text(item);if(!members.contains(member))members.add(member);}
  if(members.length<2||members.length>CommunicationWorkspaceCatalog.limits['maxMembers']!)throw _InvalidCommunicationInput();
  final ref=reference.trim().isEmpty?CommunicationWorkspaceCatalog.generalReference:_text(reference);
  return {'id':_key(),'key':_key(),'members':members,'businessReference':ref};
 });
 Future<bool> sendMessage(String value)=>_mutation('send',(){
  final current=_thread;if(current==null||value.length>CommunicationWorkspaceCatalog.limits['maxText']!||value.trim().isEmpty&&_draftPictureIds.isEmpty||RegExp(r'[\x00\x0b\x0c]').hasMatch(value))throw _InvalidCommunicationInput();
  return {'id':current['id'],'key':_key(),'version':current['version'],'text':value,'pictureIds':List<String>.of(_draftPictureIds)};
 });
 Future<bool> markRead()=>_mutation('mark_read',(){
  final current=_thread;if(current==null)throw _InvalidCommunicationInput();
  final messages=current['messages'] as List;
  final sequence=messages.isEmpty?0:(messages.last as Map)['sequence'];
  if(sequence is! int||sequence<0)throw const FormatException('Invalid message sequence');
  return {'id':current['id'],'key':_key(),'version':current['version'],'sequence':sequence};
 });
 Future<bool> retryPending(){final command=_pending;if(command==null)return Future.value(false);return run(()=>_executePending(command));}
 Future<bool> pickPicture(CommunicationPicturePicker picker)=>run(() async {
  final current=_thread;
  if(current==null||_pending!=null||_draftPictureIds.length>=CommunicationWorkspaceCatalog.limits['maxPictures']!)throw _InvalidCommunicationInput();
  final selected=await picker();requireActive();if(selected==null)return (){};
  final maximum=CommunicationWorkspaceCatalog.limits['maxPictureBytes']!;
  if(selected.length<1||selected.length>maximum)throw _InvalidCommunicationInput();
  final bytes=Uint8List(selected.length);var length=0;
  await for(final chunk in selected.bytes){
   requireActive();if(length+chunk.length>bytes.length||chunk.any((n)=>n<0||n>255))throw _InvalidCommunicationInput();
   bytes.setRange(length,length+chunk.length,chunk);length+=chunk.length;
  }
  requireActive();if(length!=bytes.length)throw _InvalidCommunicationInput();
  final png=bytes.length>=8&&listEquals(bytes.take(8).toList(),[137,80,78,71,13,10,26,10]);
  final jpeg=bytes.length>=3&&bytes[0]==255&&bytes[1]==216&&bytes[2]==255;
  if(!png&&!jpeg)throw _InvalidCommunicationInput();
  final record=await hub.pictures.upload(current['id'] as String,bytes,png?'image/png':'image/jpeg');requireActive();
  if(record['id'] is! String||record['tenantId']!=tenantId||record['threadId']!=current['id']||record['status']!='clean'||record['mediaType']!='image/png'||record['size'] is! int||(record['size'] as int)<1||(record['size'] as int)>maximum)throw const FormatException('Picture unavailable');
  return (){_draftPictureIds=List.unmodifiable({..._draftPictureIds,record['id'] as String});};
 });
 void removePicture(String id){if(!canMutate)return;_draftPictureIds=List.unmodifiable(_draftPictureIds.where((value)=>value!=id));notifyListeners();}
 Future<bool> openPicture(String id)=>run(() async {
  final current=_thread;if(current==null)throw _InvalidCommunicationInput();
  final response=await hub.pictures.open(current['id'] as String,_text(id));requireActive();final bytes=response['bytes'];
  if(bytes is! Uint8List||bytes.isEmpty||bytes.length>CommunicationWorkspaceCatalog.limits['maxPictureBytes']!||response['mediaType']!='image/png')throw const FormatException('Picture unavailable');
  final copy=Uint8List.fromList(bytes);return ()=>_preview=copy;
 });
}
