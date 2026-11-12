import 'dart:convert';
import 'package:http/http.dart' as http;
import '../communications/communication_core.dart';
import '../preference_sync/preference_protocol.dart' show PreferenceScope,canonicalPreference;
import '../work_modules/work_module_model.dart';
import '../work_modules/work_module_session.dart';
import 'registered_module_transport.dart';

class _PendingMessage {final WorkCommand command;final int sequence;_PendingMessage(this.command,this.sequence);}
/// Collection projections compose the inherited channel clients; no authorization/provider logic is copied.
class CommunicationModulePort implements WorkPort {
  final PreferenceScope scope;final String module;final Map<String,String> labels;
  final String? mailboxDirection,mailboxId;final void Function()? closeTransport;
  final MessageChannelClient _message;final EmailChannelClient _email;
  final _records=<String,Map<String,dynamic>>{},_pending=<String,_PendingMessage>{};
  Map<int,String?> _cursors={0:null};bool _dead=false;int _epoch=0;
  CommunicationModulePort({required this.scope,required this.module,required CommunicationTransport transport,required Map<String,String> labels,
    this.mailboxDirection,this.mailboxId,this.closeTransport}):labels=Map.unmodifiable(labels),_message=MessageChannelClient(transport),_email=EmailChannelClient(transport){
    if(scope.dataset!='live'||!['mailbox','messenger','files'].contains(module)||module=='mailbox'&&
      (!['inbound','outbound'].contains(mailboxDirection)||mailboxDirection=='inbound'&&(mailboxId==null||mailboxId!.isEmpty)||mailboxDirection=='outbound'&&mailboxId!=null))throw const WorkFailure('unavailable');
  }
  factory CommunicationModulePort.authenticated({required Uri origin,required String token,required PreferenceScope scope,required String module,
    required Map<String,String> labels,required String? Function() currentToken,required PreferenceScope? Function() currentScope,
    String? mailboxDirection,String? mailboxId,http.Client? client,int maxBytes=1048576}){
    final wire=RegisteredModuleHttpTransport(origin:origin,token:token,scope:scope,currentToken:currentToken,currentScope:currentScope,client:client,maxBytes:maxBytes);
    try{return CommunicationModulePort(scope:scope,module:module,transport:wire,labels:labels,mailboxDirection:mailboxDirection,mailboxId:mailboxId,closeTransport:wire.dispose);}catch(_){wire.dispose();rethrow;}
  }
  void _open(){if(_dead)throw const WorkFailure('unavailable');}
  String _word(String key){final value=labels[key];if(value==null||value.trim().isEmpty)throw const WorkFailure('invalid');return value;}
  Map<String,dynamic> _conversation(Object? value){_open();if(value is! Map)throw const WorkFailure('denied',403);final r=Map<String,dynamic>.from(value);
    if(r['kind']!='conversation'||r['tenantId']!=scope.tenantId||r['members'] is! List||!(r['members'] as List).contains(scope.userId)||
      r['messages'] is! List||(r['messages'] as List).cast<Map<dynamic,dynamic>>().length>10000||r['readThrough'] is! Map||r['businessReference'] is! String)throw const WorkFailure('denied',403);
    final messages=<Map<String,dynamic>>[];
    for(final raw in r['messages'] as List){if(raw is! Map||raw['id'] is! String||raw['authorId'] is! String||raw['text'] is! String||
      raw['pictureIds'] is! List||(raw['pictureIds'] as List).any((p)=>p is! String)||raw['sequence'] is! int)throw const WorkFailure('invalid');messages.add(Map<String,dynamic>.from(jsonDecode(jsonEncode(raw)) as Map));}
    return {'id':r['id'],'version':r['version'],'tenantId':r['tenantId'],'businessReference':r['businessReference'],'messages':messages,
      'readThrough':{scope.userId:(r['readThrough'] as Map)[scope.userId]??0}};
  }
  Map<String,Object?> _thread(Map<String,dynamic> r){final messages=r['messages'] as List;return {'id':r['id'],'version':r['version'],'title':r['businessReference'],
    'body':messages.isEmpty?'':(messages.last as Map)['text'],'date':'','lane':'','meta':_word((r['readThrough'] as Map)[scope.userId]==messages.length?'read':'unread'),
    'actions':[{'id':'send','label':_word('send'),'fields':['body'],'target':''},{'id':'mark_read','label':_word('markRead'),'fields':<String>[],'target':''}]};}
  Map<String,Object?> _mail(Object? value){if(value is! Map)throw const WorkFailure('denied',403);final r=value,direction=mailboxDirection;
    if(r['tenantId']!=scope.tenantId||r['kind']!=(direction=='inbound'?'inbound_mail':'outbound_mail')||direction=='outbound'&&r['ownerId']!=scope.userId||
      direction=='inbound'&&(r['mailboxId']!=mailboxId||r['senderIdentityVerified']!=false||r['status']!='quarantined')||
      !['queued','sending','accepted','unknown','quarantined'].contains(r['status'])||r['from'] is! String||r['to'] is! String)throw const WorkFailure('denied',403);
    Object? subject=r['subject'];String body;
    if(direction=='outbound'){if(r['text'] is! String||subject is! String)throw const WorkFailure('invalid');body=r['text'] as String;}
    else{final preview=r['contentPreview'];if(preview is! Map||!['available','unavailable'].contains(preview['status']))throw const WorkFailure('invalid');
      if(preview['status']=='available'){if(preview['text'] is! String||preview['subject']!=null&&preview['subject'] is! String)throw const WorkFailure('invalid');body=preview['text'] as String;subject=preview['subject'];}
      else{if(preview.length!=1)throw const WorkFailure('invalid');body=_word('unavailable');}}
    return {'id':r['id'],'version':r['version'],'title':subject==null||subject==''?_word('mailbox'):subject,'body':body,'date':'','lane':'',
      'meta':"${r['from']} → ${r['to']} · ${_word(r['status'] as String)}",'actions':<Object?>[]};
  }
  WorkSnapshot _snapshot(List<Map<String,Object?>> items,int offset,int total,bool partial)=>WorkSnapshot.fromJson(
    {'scope':scope.toJson(),'module':module,'items':items,'lanes':<Object?>[],'offset':offset,'total':total,'partial':partial},scope,module);
  @override Future<Object?> read(WorkQuery query)async{
    _open();if(query.search.length>100||query.offset<0||query.offset>100000)throw const WorkFailure('invalid',400);final epoch=++_epoch;
    final records=<String,Map<String,dynamic>>{},cursors=query.offset==0?<int,String?>{0:null}:Map<int,String?>.from(_cursors);
    var items=<Map<String,Object?>>[],partial=false,total=0;
    void check(){_open();if(epoch!=_epoch)throw const WorkFailure('unavailable');}
    if(module=='mailbox'){
      if(!cursors.containsKey(query.offset))throw const WorkFailure('invalid',400);
      final page=await _email.inbox(direction:mailboxDirection!,mailboxId:mailboxId,limit:100,after:cursors[query.offset]);check();
      if(page['items'] is! List||(page['items'] as List).length>100||page['nextAfter']!=null&&page['nextAfter'] is! String)throw const WorkFailure('invalid');
      for(final summary in page['items'] as List){if(summary is! Map||summary['id'] is! String)throw const WorkFailure('invalid');final raw=await _email.read(summary['id'] as String);check();final item=_mail(raw);
        if(item['id']!=summary['id']||item['version']!=summary['version'])throw const WorkFailure('conflict',409);items.add(item);records[item['id'] as String]=Map<String,dynamic>.from(item);}
      if(page['nextAfter']!=null)cursors[query.offset+100]=page['nextAfter'] as String;else cursors.remove(query.offset+100);
      items=items.where((i)=>'${i['title']} ${i['body']}'.toLowerCase().contains(query.search.toLowerCase())).toList();total=query.offset+items.length+(page['nextAfter']==null?0:1);partial=query.offset>0||page['nextAfter']!=null||query.search.isNotEmpty;
    }else{
      final page=await _message.inbox(limit:100);check();if(page['items'] is! List||(page['items'] as List).length>100)throw const WorkFailure('invalid');
      final rows=[for(final r in page['items'] as List)_conversation(r)];for(final r in rows){records[r['id'] as String]=r;}
      if(module=='messenger'){items=rows.map(_thread).toList();}else{final refs=<String,Map<String,Object?>>{};
        for(final r in rows){for(final value in r['messages'] as List){final m=value as Map;for(final id in m['pictureIds'] as List){if(refs.containsKey(id))continue;if(refs.length>=1000)throw const WorkFailure('unavailable');refs[id as String]={'id':id,'version':r['version'],'title':_word('attachment'),'body':r['businessReference'],'date':'','lane':'','meta':id,'actions':<Object?>[]};}}}items=refs.values.toList();}
      items=items.where((i)=>'${i['title']} ${i['body']} ${i['meta']}'.toLowerCase().contains(query.search.toLowerCase())).toList();total=items.length;items=items.skip(query.offset).take(100).toList();partial=(page['items'] as List).length==100||total>items.length;
    }
    check();final snapshot=_snapshot(items,query.offset,total,partial);_records..clear()..addAll(records);_cursors=cursors;return snapshot.toJson();
  }
  @override Future<WorkReceipt> mutate(WorkCommand command,String key)async{
    _open();if(module!='messenger')throw const WorkFailure('denied',403);if(key.isEmpty||key.length>200||RegExp(r'[\x00-\x1f\x7f]').hasMatch(key))throw const WorkFailure('invalid',400);var pending=_pending[key];
    if(pending!=null&&canonicalPreference(pending.command.toJson())!=canonicalPreference(command.toJson()))throw const WorkFailure('conflict',409);
    if(pending==null){final raw=_records[command.itemId];if(raw==null)throw const WorkFailure('denied',403);final item=WorkSnapshot.fromJson(_snapshot([_thread(raw)],0,1,false).toJson(),scope,module).items.single;
      validateWorkCommand(item,command.action,command.fields);if(raw['version']!=command.version)throw const WorkFailure('conflict',409);
      if(command.action=='send'&&(command.fields['body']??'').trim().isEmpty)throw const WorkFailure('invalid',400);if(_pending.length>=10)throw const WorkFailure('unavailable');
      pending=_PendingMessage(command,(raw['messages'] as List).cast<Map<dynamic,dynamic>>().length);_pending[key]=pending;}
    Map<String,Object?> ack;
    try{ack=command.action=='send'?await _message.send(command.itemId,key,command.version,command.fields['body']!):await _message.markRead(command.itemId,key,command.version,pending.sequence);}
    on WorkFailure catch(e){if([400,403,404,409].contains(e.status))_pending.remove(key);rethrow;}
    _open();if(ack['id']!=command.itemId||ack['version']!=command.version+1)throw const WorkFailure('conflict',409);
    return WorkReceipt(command.itemId,command.version+1,command.action,command.action=='send'?{'body':command.fields['body']!.trim()}:{'meta':_word('read')});
  }
  @override Future<Object?> readItem(String id)async{
    _open();if(module!='messenger')throw const WorkFailure('denied',403);final raw=_conversation(await _message.read(id));_open();if(raw['id']!=id)throw const WorkFailure('denied',403);
    final pending=_pending.entries.where((e)=>e.value.command.itemId==id).toList();
    if(pending.isNotEmpty){final entry=pending.last,p=entry.value,c=p.command;if(raw['version']!=c.version+1)throw const WorkFailure('conflict',409);
      if(c.action=='send'&&!(raw['messages'] as List).cast<Map<dynamic,dynamic>>().any((m)=>m['id']==entry.key&&m['authorId']==scope.userId&&m['text']==c.fields['body']!.trim())||
        c.action=='mark_read'&&(raw['readThrough'] as Map)[scope.userId]!=p.sequence)throw const WorkFailure('conflict',409);_pending.remove(entry.key);}
    final snapshot=_snapshot([_thread(raw)],0,1,false);_records[id]=raw;return snapshot.toJson();
  }
  @override void dispose(){if(_dead)return;_dead=true;_epoch++;_records.clear();_pending.clear();_cursors.clear();closeTransport?.call();}
}
