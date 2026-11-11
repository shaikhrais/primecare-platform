import 'dart:convert';
import 'package:http/http.dart' as http;
import '../preference_sync/preference_protocol.dart' show PreferenceScope,canonicalPreference;
import 'work_module_model.dart';
import 'work_module_session.dart';
import 'tenant_task_transport.dart';

const _lanes=['open','in_progress','blocked','submitted','completed','cancelled'];
const _actions=['edit','start','block','submit','complete','return','cancel'];
class _PendingTask {
  final String fingerprint,search,itemId;final Map<String,Object?> body;final Map<String,String> expected;
  _PendingTask(this.fingerprint,this.search,this.itemId,this.body,this.expected);
}
/// Native counterpart of the task-backed web adapter; no standalone CRUD or host activation.
class TenantTaskModulePort implements WorkPort {
  final PreferenceScope scope;final String module;final TenantTaskTransport transport;
  final Map<String,String> labels;final void Function()? closeTransport;
  Map<String,dynamic>? _raw;bool _dead=false;int _readEpoch=0;final _payloads=<String,_PendingTask>{};
  TenantTaskModulePort({required this.scope,required this.module,required this.transport,
    required Map<String,String> labels,this.closeTransport}):labels=Map.unmodifiable(labels){
    if(!['calendar','contacts','tasks','notes','board'].contains(module)||
      [..._lanes,..._actions].any((k)=>labels[k]==null||labels[k]!.trim().isEmpty||labels[k]!.length>200))throw const WorkFailure('invalid',400);
  }
  factory TenantTaskModulePort.authenticated({required Uri origin,required String token,required PreferenceScope scope,
    required String module,required Map<String,String> labels,required String? Function() currentToken,
    required PreferenceScope? Function() currentScope,int maxBytes=1048576,http.Client? client}){
    final wire=TenantTaskHttpTransport(origin:origin,token:token,scope:scope,currentToken:currentToken,currentScope:currentScope,maxBytes:maxBytes,client:client);
    try{return TenantTaskModulePort(scope:scope,module:module,labels:labels,transport:wire.call,closeTransport:wire.dispose);}
    catch(_){wire.dispose();rethrow;}
  }
  void _open(){if(_dead)throw const WorkFailure('unavailable');}
  Map<String,dynamic> _check(Object? value){_open();
    if(value is! Map)throw const WorkFailure('denied',403);
    final raw=Map<String,dynamic>.from(jsonDecode(jsonEncode(value)) as Map);
    final organization=raw['organization'],identity=raw['identity'];
    if(organization is! Map||identity is! Map||organization['id']!=scope.tenantId||identity['userId']!=scope.userId||
      identity['role']!=scope.role||raw['dataset']!=scope.dataset||raw['synthetic']!=(scope.dataset=='demo')||
      raw['database']!='PostgreSQL'||raw['taskActorId'] is! String||(raw['taskActorId'] as String).isEmpty||raw['canManage'] is! bool||raw['tasks'] is! List||raw['users'] is! List||raw['clients'] is! List)throw const WorkFailure('denied',403);
    return raw;
  }
  String _target(Map<dynamic,dynamic> task,String action,String evidence,Map<dynamic,dynamic> raw){
    if(evidence.trim().length<10||evidence.length>2000||RegExp(r'[\x00-\x08\x0b\x0c\x0e-\x1f\x7f]').hasMatch(evidence)||
      ['completed','cancelled'].contains(task['status']))throw const WorkFailure('invalid',400);
    final own=task['owner_id']==raw['taskActorId'],manager=raw['canManage']==true,status=task['status'];
    if(['start','block','submit'].contains(action)&&!own&&!manager)throw const WorkFailure('denied',403);
    if(action=='start'&&['open','blocked'].contains(status))return 'in_progress';
    if(action=='block'&&['open','in_progress'].contains(status))return 'blocked';
    if(action=='submit'&&['open','in_progress','blocked'].contains(status))return 'submitted';
    if(action=='complete'&&status=='submitted'&&manager&&!own&&task['submitted_by']!=raw['taskActorId'])return 'completed';
    if(action=='return'&&status=='submitted'&&manager&&task['submitted_by']!=raw['taskActorId'])return 'in_progress';
    if(action=='cancel'&&manager)return 'cancelled';
    throw const WorkFailure('invalid',400);
  }
  WorkSnapshot _project(Map<String,dynamic> raw,[int offset=0,String search='']){
    _open();final lanes=[for(final id in _lanes){'id':id,'label':labels[id]}];
    final items=<Map<String,Object?>>[];int total;bool partial;
    if(module=='contacts'){
      final rows=<Map<String,Object?>>[
        for(final user in (raw['users'] as List).cast<Map<dynamic,dynamic>>()){'id':'staff:${user['id']}','title':user['name'],'meta':user['email']??''},
        for(final client in (raw['clients'] as List).cast<Map<dynamic,dynamic>>()){'id':'client:${client['id']}','title':client['name'],'meta':''},
      ].where((r)=>'${r['title']} ${r['meta']}'.toLowerCase().contains(search.toLowerCase())).toList();
      total=rows.length;for(final row in rows.skip(offset).take(100)){items.add({...row,'version':1,'body':'','date':'','lane':'','actions':<Object?>[]});}
      partial=raw['directoryTruncated']==true||total>items.length;
    }else{
      for(final value in raw['tasks'] as List){if(value is! Map||value['actions'] is! List)throw const WorkFailure('invalid');
        final actions=<Map<String,Object?>>[];
        for(final action in value['actions'] as List){
          if(action=='edit'){if(module!='board')actions.add({'id':module=='calendar'?'reschedule':'edit','label':labels['edit'],
            'fields':module=='calendar'?['date']:module=='notes'?['body']:['title','body','date'],'target':''});continue;}
          if(module=='notes'||module=='calendar')continue;
          String target;try{target=_target(value,action as String,'Projection only; no mutation performed.',raw);}on WorkFailure{continue;}
          if(!_actions.contains(action))throw const WorkFailure('unavailable');
          actions.add({'id':action,'label':labels[action],'fields':['body'],'target':target});
        }
        items.add({'id':'${value['id']}','version':value['version'],'title':value['title'],'body':value['notes']??'',
          'date':value['due_on'],'lane':value['status'],'meta':value['evidence']??'','actions':actions});
      }
      final page=raw['taskPage'];final count=page is Map?page['total']:null;
      if(count!=null&&count is! int)throw const WorkFailure('invalid');total=count as int? ?? items.length;partial=total>items.length;
    }
    return WorkSnapshot.fromJson({'scope':scope.toJson(),'module':module,'items':items,'lanes':lanes,
      'offset':offset,'total':total,'partial':partial},scope,module);
  }
  @override Future<Object?> read(WorkQuery query)async{
    _open();final epoch=++_readEpoch;if(query.search.length>100||query.offset<0||query.offset>100000)throw const WorkFailure('invalid',400);
    final raw=_check(await transport(TenantTaskRequest('GET',{'dataset':scope.dataset,'search':module=='contacts'?'':query.search,
      'taskOffset':module=='contacts'?'0':'${query.offset}','status':'all'})));
    if(epoch!=_readEpoch)throw const WorkFailure('unavailable');final snapshot=_project(raw,query.offset,query.search);_raw=raw;return snapshot.toJson();
  }
  @override Future<WorkReceipt> mutate(WorkCommand command,String requestId)async{
    _open();final raw=_raw;if(module=='contacts'||raw==null)throw const WorkFailure('denied',403);
    if(!RegExp(r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',caseSensitive:false).hasMatch(requestId))throw const WorkFailure('invalid',400);
    final tasks=(raw['tasks'] as List).cast<Map<dynamic,dynamic>>().where((t)=>'${t['id']}'==command.itemId).toList();
    if(tasks.length!=1)throw const WorkFailure('denied',403);final task=tasks.single;
    final fingerprint=canonicalPreference(command.toJson());var payload=_payloads[requestId];
    if(payload!=null&&payload.fingerprint!=fingerprint)throw const WorkFailure('conflict',409);
    if(payload==null){
      final item=_project(raw).items.where((i)=>i.id==command.itemId).single;
      validateWorkCommand(item,command.action,command.fields);
      if(task['version']!=command.version)throw const WorkFailure('conflict',409);
      final action=command.action=='reschedule'?'edit':command.action,expected=<String,String>{};Map<String,Object?> value;
      if(action=='edit'){
        value={'title':command.fields['title']??task['title'],'ownerId':task['owner_id'],'dueOn':command.fields['date']??task['due_on'],
          'priority':task['priority'],'flowId':task['flow_id'],'notes':command.fields['body']??task['notes']};
        for(final key in ['title','body','date']){if(command.fields.containsKey(key))expected[key]=command.fields[key]!.trim();}
      }else{expected['lane']=_target(task,action,command.fields['body']??'',raw);expected['meta']=command.fields['body']!.trim();value={'evidence':command.fields['body']};}
      if(_payloads.length>=10)throw const WorkFailure('unavailable');
      payload=_PendingTask(fingerprint,expected['title']??task['title'] as String,command.itemId,
        {'action':action,'id':command.itemId,'version':command.version,'value':value,if(scope.dataset=='demo')'workspaceVersion':raw['workspaceVersion']},expected);
      _payloads[requestId]=payload;
    }
    Map<String,dynamic> response;
    try{response=_check(await transport(TenantTaskRequest('POST',{'dataset':scope.dataset},body:payload.body,requestId:requestId)));}
    on WorkFailure catch(e){if([400,403,404,409].contains(e.status))_payloads.remove(requestId);rethrow;}
    final acknowledged=(response['tasks'] as List).cast<Map<dynamic,dynamic>>().where((t)=>'${t['id']}'==command.itemId).toList();
    if(acknowledged.length>1||acknowledged.isNotEmpty&&acknowledged.single['version']!=command.version+1)throw const WorkFailure('conflict',409);
    return WorkReceipt(command.itemId,command.version+1,command.action,Map.unmodifiable(payload.expected));
  }
  @override Future<Object?> readItem(String id)async{
    _open();final raw=_raw;if(raw==null)throw const WorkFailure('unavailable');
    final original=(raw['tasks'] as List).cast<Map<dynamic,dynamic>>().where((t)=>'${t['id']}'==id).toList();if(original.length!=1)throw const WorkFailure('unavailable');
    final pending=_payloads.values.where((p)=>p.itemId==id).firstOrNull;
    for(var offset=0;offset<=10000;offset+=100){
      final fresh=_check(await transport(TenantTaskRequest('GET',{'dataset':scope.dataset,'search':pending?.search??original.single['title'] as String,'taskOffset':'$offset','status':'all'})));
      if((fresh['tasks'] as List).cast<Map<dynamic,dynamic>>().any((t)=>'${t['id']}'==id)){final snapshot=_project(fresh,offset);_raw=fresh;_payloads.removeWhere((_,p)=>p.itemId==id);return snapshot.toJson();}
      final page=fresh['taskPage'];if(offset+(fresh['tasks'] as List).cast<Map<dynamic,dynamic>>().length>=(page is Map?page['total'] as int? ?? 0:0))break;
    }
    throw const WorkFailure('conflict',409);
  }
  @override void dispose(){if(_dead)return;_dead=true;_readEpoch++;_raw=null;_payloads.clear();closeTransport?.call();}
}
