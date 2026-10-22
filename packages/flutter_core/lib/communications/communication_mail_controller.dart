import 'dart:convert';
import 'communication_command_controller.dart';
import 'communication_workspace_catalog.dart';
import 'communication_workspace_controller.dart';

/// One mailbox view model for every permitted portal. No raw MIME/HTML enters
/// presentation state; current server mailbox policy remains authoritative.
final class CommunicationMailController extends CommunicationCommandControllerBase {
 CommunicationMailController({required super.hub,required super.userId,required super.tenantId,super.key});
 List<Map<String,Object?>> _items=const [];
 Map<String,Object?>? _selected;
 String _direction='outbound';
 String? _mailboxId,_nextAfter;
 List<Map<String,Object?>> get items=>_items;
 Map<String,Object?>? get selected=>_selected;
 String get direction=>_direction;
 String? get mailboxId=>_mailboxId;
 bool get hasMore=>_nextAfter!=null;
 bool get canDeliver=>canMutate&&_selected?['kind']=='outbound_mail'&&_selected?['status']=='queued';
 @override String get pendingFailure=>'mailPending';
 @override String get invalidFailure=>'mailInvalid';
 @override void clearPrivateState(){_items=const [];_selected=null;_nextAfter=null;_mailboxId=null;}
 String _address(Object? value){
  if(value is! String||value.length>254||!RegExp(r'^[^\s<>@]+@[^\s<>@]+\.[^\s<>@]+$').hasMatch(value)||RegExp(r'[\x00-\x1f\x7f]').hasMatch(value))throw CommunicationInputException();return value;
 }
 String _status(Object? value,String kind){
  if(!(kind=='outbound_mail'?{'queued','sending','accepted','unknown'}:{'quarantined'}).contains(value))throw const FormatException('Mail status unavailable');return value as String;
 }
 Map<String,Object?> _summary(Map<String,Object?> value,String direction){
  final kind=direction=='inbound'?'inbound_mail':'outbound_mail';
  if(value['kind']!=kind||value['id'] is! String||value['version'] is! int||(value['version'] as int)<1||value['subject']!=null&&value['subject'] is! String)throw const FormatException('Mail summary unavailable');
  final id=identifier(value['id'] as String);
  return Map.unmodifiable({'id':id,'version':value['version'],'kind':kind,'status':_status(value['status'],kind),'from':_address(value['from']),'to':_address(value['to']),if(value['subject'] is String)'subject':value['subject']});
 }
 Map<String,Object?> _record(Map<String,Object?> value,String id,{String? mailbox}){
  requireVersion(value,id);
  final kind=value['kind'];
  if(kind=='outbound_mail'){
   if(value['ownerId']!=userId||value['text'] is! String||value['subject'] is! String||utf8.encode(value['text'] as String).length>CommunicationWorkspaceCatalog.limits['maxMailTextBytes']!||(value['subject'] as String).length>CommunicationWorkspaceCatalog.limits['maxMailSubject']!)throw const FormatException('Mail content unavailable');
  }else if(kind!='inbound_mail'||mailbox==null||value['mailboxId']!=mailbox){throw const FormatException('Mail scope unavailable');}
  return Map.unmodifiable({..._summary(value,kind=='inbound_mail'?'inbound':'outbound'),if(kind=='outbound_mail')'text':value['text']});
 }
 Future<bool> loadInbox({required String direction,String? mailboxId,bool more=false})=>run(() async {
  if(!{'inbound','outbound'}.contains(direction)||direction=='outbound'&&mailboxId!=null)throw CommunicationInputException();
  final mailbox=direction=='inbound'?identifier(mailboxId??''):null;
  if(more&&(_direction!=direction||_mailboxId!=mailbox||_nextAfter==null))throw CommunicationInputException();
  final previous=more?_items:const <Map<String,Object?>>[];
  final after=more?_nextAfter:null;
  final page=await hub.email.inbox(direction:direction,mailboxId:mailbox,limit:CommunicationWorkspaceCatalog.limits['mailPageLimit']!,after:after);requireActive();
  final raw=page['items'],cursor=page['nextAfter'];
  if(raw is! List||raw.length>CommunicationWorkspaceCatalog.limits['mailPageLimit']!||cursor!=null&&(cursor is! String||cursor.trim().isEmpty||cursor==after))throw const FormatException('Mail page unavailable');
  final records=raw.map((value)=>_summary(Map<String,Object?>.from(value as Map),direction)).toList();
  if(records.map((v)=>v['id']).toSet().length!=records.length||more&&records.any((v)=>previous.any((old)=>old['id']==v['id'])))throw const FormatException('Mail page repeated');
  return (){_items=List.unmodifiable([...previous,...records].reversed.take(CommunicationWorkspaceCatalog.limits['inboxLimit']!).toList().reversed);_direction=direction;_mailboxId=mailbox;_nextAfter=cursor as String?;_selected=null;};
 });
 Future<bool> refreshInbox()=>loadInbox(direction:_direction,mailboxId:_mailboxId);
 Future<bool> loadMore()=>loadInbox(direction:_direction,mailboxId:_mailboxId,more:true);
 Future<bool> openMail(String id)=>run(() async {
  final selected=identifier(id);final record=_record(await hub.email.read(selected),selected,mailbox:_mailboxId);requireActive();
  return ()=>_selected=record;
 });
 Future<bool> queue(String to,String subject,String text)=>mutate('email','queue',(){
  final address=_address(to.trim());final title=identifier(subject,maximum:CommunicationWorkspaceCatalog.limits['maxMailSubject']!);
  if(text.trim().isEmpty||utf8.encode(text).length>CommunicationWorkspaceCatalog.limits['maxMailTextBytes']!||RegExp(r'[\x00\x0b\x0c]').hasMatch(text))throw CommunicationInputException();
  return {'id':newKey(),'key':newKey(),'to':address,'subject':title,'text':text};
 });
 Future<bool> deliver()=>mutate('email','deliver',(){
  final current=_selected;if(current==null||current['kind']!='outbound_mail'||current['status']!='queued')throw CommunicationInputException();
  return {'id':current['id'],'key':newKey(),'version':current['version']};
 });
 @override Future<CommunicationCommit> confirm(CommunicationPendingCommand command,Map<String,Object?> response) async {
  if(response['id']!=command.id||response['version'] is! int||(command.action=='queue'?response['version']!=1:(response['version'] as int)<=command.version))throw const FormatException('Mail action unconfirmed');
  final record=_record(await hub.email.read(command.id),command.id);requireActive();
  if(command.action=='queue'&&(record['to']!=command.fields['to']||record['subject']!=command.fields['subject']||record['text']!=command.fields['text']))throw const FormatException('Mail draft unconfirmed');
  if(command.action=='deliver'&&record['status']=='queued')throw const FormatException('Mail delivery unconfirmed');
  if(record['kind']!='outbound_mail'||(record['version'] as int)<(response['version'] as int))throw const FormatException('Mail reload regressed');
  return (){_selected=record;_items=const [];_nextAfter=null;_direction='outbound';_mailboxId=null;};
 }
}
