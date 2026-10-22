// Isolated fixtures only; never imported by production code.
import 'dart:async';
import 'package:flutter_core/communications/communication_core.dart';
import 'package:flutter_core/communications/communication_media.dart';
import 'communication_workspace_transport.dart';

class ChannelsTransport extends FixtureTransport {
 final mail=<String,Map<String,Object?>>{};
 bool loseMailQueue=false,loseMailDeliver=false,loseCall=false;
 String deliveryStatus='accepted';
 int deliveries=0;
 Completer<Map<String,Object?>>? deferred;
 @override Future<Map<String,Object?>> execute(String channel,Map<String,Object?> input) async {
  if(channel!='email'&&channel!='audio')return super.execute(channel,input);
  requests.add({'channel':channel,...input});
  for(final field in ['actor','actorId','tenantId','roles']){if(input.containsKey(field))throw StateError('Identity override');}
  final error=nextFailure;nextFailure=null;if(error!=null)throw error;
  final waiting=deferred;deferred=null;if(waiting!=null)return waiting.future;
  final action=input['action'],id=input['id'] as String?;
  if(channel=='email'){
   if(action=='inbox'){
    final selected=mail.values.where((m)=>input['direction']=='outbound'?m['kind']=='outbound_mail'&&m['ownerId']=='alice':m['kind']=='inbound_mail'&&m['mailboxId']==input['mailboxId']).toList()..sort((a,b)=>(a['id'] as String).compareTo(b['id'] as String));
    final page=selected.where((v)=>input['after']==null||(v['id'] as String).compareTo(input['after'] as String)>0).take(input['limit'] as int).toList();
    return {'items':page.map(clone).toList(),'nextAfter':page.length==input['limit']?page.last['id']:null};
   }
   if(action=='read'){final value=mail[id];if(value==null)throw denied(404);return clone(value);}
   final prior=receipts[input['key']];if(prior!=null)return clone(prior);
   if(action=='queue'){
    mail[id!]={'id':id,'tenantId':'tenant-a','version':1,'kind':'outbound_mail','ownerId':'alice','from':'owned@example.invalid','to':input['to'],'subject':input['subject'],'text':input['text'],'status':'queued'};
   }else if(action=='deliver'){
    final current=mail[id];if(current==null)throw denied(404);if(current['status']!='queued'||current['version']!=input['version'])throw denied(409);
    current['status']=deliveryStatus;current['version']=(current['version'] as int)+2;deliveries++;
   }else{throw StateError('Unknown mail fixture action');}
   final result=action=='queue'?<String,Object?>{'id':id,'version':1}:clone(mail[id]!);receipts[input['key'] as String]=result;
   if(action=='queue'&&loseMailQueue){loseMailQueue=false;throw denied(null);}if(action=='deliver'&&loseMailDeliver){loseMailDeliver=false;throw denied(null);}
   return clone(result);
  }
  final prior=receipts[input['key']];if(prior!=null)return clone(prior);
  if(input['id']!=record['id']||input['version']!=record['version'])throw denied(409);
  final calls=record['calls'] as List;
  if(action=='invite')calls.add({'id':input['callId'],'callerId':'alice','recipientId':input['recipientId'],'status':'ringing'});
  else {final call=calls.cast<Map>().singleWhere((v)=>v['id']==input['callId']);call['status']=switch(action){'accept'=>'accepted','decline'=>'declined','end'=>'ended',_=>throw StateError('Unknown call fixture action')};}
  record['version']=(record['version'] as int)+1;
  final result=<String,Object?>{'id':record['id'],'version':record['version']};receipts[input['key'] as String]=result;
  if(loseCall){loseCall=false;throw denied(null);}return result;
 }
 void received(String id,{String mailbox='owned-box'}){mail[id]={'id':id,'tenantId':'tenant-a','version':1,'kind':'inbound_mail','mailboxId':mailbox,'from':'outside@example.invalid','to':'owned@example.invalid','status':'quarantined','rawBase64':'PRIVATE RAW MIME','senderIdentityVerified':false};}
}
class MediaFixture extends CommunicationMediaSession {
 MediaFixture(this.onState);
 final void Function(String) onState;
 bool _closed=false,muted=false;int starts=0,closes=0;
 Completer<void>? permission;
 @override bool get closed=>_closed;
 @override Future<void> start() async {starts++;if(permission!=null)await permission!.future;if(!_closed)onState('connected');}
 @override void mute(bool value){muted=value;}
 @override void close(){if(_closed)return;_closed=true;closes++;onState('closed');}
}
