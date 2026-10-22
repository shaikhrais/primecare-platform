import 'dart:async';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'communication_core.dart';
import 'communication_workspace_controller.dart';

/// Owned immutable command. Retried only when the user explicitly requests it.
final class CommunicationPendingCommand {
 CommunicationPendingCommand(this.channel,this.action,Map<String,Object?> fields):fields=Map.unmodifiable(fields);
 final String channel,action;
 final Map<String,Object?> fields;
 bool uncertain=false;
 String get id=>fields['id'] as String;
 int get version=>(fields['version'] as int?)??0;
}

/// Shared command/retry lifecycle for the mail and call presentation controllers.
/// Session identity is local validation context, never a request override.
abstract class CommunicationCommandControllerBase extends CommunicationWorkspaceControllerBase {
 CommunicationCommandControllerBase({required this.hub,required this.userId,required this.tenantId,String Function()? key}):_key=key??_randomKey {
  if(userId.trim().isEmpty||tenantId.trim().isEmpty)throw ArgumentError('Authenticated communication scope required');
 }
 final CommunicationHub hub;
 final String userId,tenantId;
 final String Function() _key;
 static final _random=Random.secure();
 static String _randomKey()=>List.generate(16,(_)=>_random.nextInt(256).toRadixString(16).padLeft(2,'0')).join();
 @protected String newKey()=>_key();
 CommunicationPendingCommand? _pending;
 bool get hasPendingCommand=>_pending!=null;
 String? get pendingAction=>_pending?.action;
 bool get canMutate=>!isDisposed&&!busy&&_pending==null;
 @protected String get pendingFailure;
 @protected String get invalidFailure;
 @override String classify(Object error){
  final result=super.classify(error);
  if(result=='invalidInput')return invalidFailure;
  return _pending!=null&&!{'unauthenticated','forbidden','notFound','conflict'}.contains(result)?pendingFailure:result;
 }
 @override void operationFailed(Object error){
  final command=_pending;if(command==null)return;
  final status=error is DioException?error.response?.statusCode:null;
  if(command.uncertain||status==null||status>=500||status==408){command.uncertain=true;}
  else if(status>=400&&status<500){_pending=null;}
 }
 @protected Future<CommunicationCommit> confirm(CommunicationPendingCommand command,Map<String,Object?> response);
 Future<CommunicationCommit> _execute(CommunicationPendingCommand command) async {
  final response=await switch(command.channel){
   'email'=>hub.email.execute(command.action,command.fields),
   'audio'=>hub.audio.execute(command.action,command.fields),
   _=>throw StateError('Unsupported presentation channel'),
  };requireActive();
  final commit=await confirm(command,response);requireActive();
  return (){commit();_pending=null;};
 }
 @protected Future<bool> mutate(String channel,String action,FutureOr<Map<String,Object?>> Function() fields){
  if(busy||isDisposed)return Future.value(false);
  if(_pending!=null){showFailure(pendingFailure);return Future.value(false);}
  return run(() async {final input=await fields();requireActive();final command=CommunicationPendingCommand(channel,action,input);_pending=command;return _execute(command);});
 }
 Future<bool> retryPending(){final command=_pending;if(command==null)return Future.value(false);return run(()=>_execute(command));}
 @protected String identifier(String value,{int maximum=200}){
  final result=value.trim();if(result.isEmpty||result.length>maximum||RegExp(r'[\x00-\x1f\x7f]').hasMatch(result))throw CommunicationInputException();return result;
 }
 @protected void requireVersion(Map<String,Object?> result,String id){
  if(result['id']!=id||result['tenantId']!=tenantId||result['version'] is! int||(result['version'] as int)<1)throw const FormatException('Communication scope unavailable');
 }
 @override void dispose(){_pending=null;super.dispose();}
}
