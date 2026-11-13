import 'package:http/http.dart' as http;
import '../preference_sync/preference_sync_client.dart';
import '../preference_sync/preference_adapters.dart';
import '../work_modules/work_module_model.dart';
import '../work_modules/work_module_session.dart';

class _SettingsCache implements PreferenceCache {
  final PreferenceCache cache;_SettingsCache(this.cache);String _key(String k)=>'application-modules.settings:$k';
  @override Future<String?> read(String key)=>cache.read(_key(key));
  @override Future<void> write(String key,String value)=>cache.write(_key(key),value);
  @override Future<void> remove(String key)=>cache.remove(_key(key));
}
class _SettingsCommand {final WorkCommand command;final Map<String,Object?> document;_SettingsCommand(this.command,this.document);}
/// WorkPort composition over B07's durable draft/CAS/receipt client, matching the existing web port.
class ApplicationSettingsPort implements WorkPort {
  final PreferenceBinding binding;final PreferenceTransport transport;final Map<String,String> names,labels;final List<String> defaults;
  final void Function()? closeTransport;late final PreferenceSyncClient _client;
  Map<String,dynamic>? _confirmed;Object? _lastError;String _wireKey='';bool _dead=false;final _commands=<String,_SettingsCommand>{};
  ApplicationSettingsPort({required this.binding,required this.transport,required PreferenceCache cache,required Map<String,String> names,
    required Map<String,String> labels,List<String> defaults=const [],this.closeTransport})
      :names=Map.unmodifiable(names),labels=Map.unmodifiable(labels),defaults=List.unmodifiable(defaults){
    if(binding.kind!='shortcuts'||binding.resource!='navigation'||binding.scope.dataset!='live'||
      names.entries.any((e)=>!binding.screenIds.contains(e.key)||e.value.trim().isEmpty||e.value!=e.value.trim()||e.value.length>100||RegExp(r'[\r\n]').hasMatch(e.value))||
      names.values.toSet().length!=names.length||defaults.any((id)=>!names.containsKey(id))||
      ['shortcuts','editShortcuts'].any((k)=>labels[k]==null||labels[k]!.trim().isEmpty))throw const WorkFailure('invalid',400);
    try{preferenceDocument('shortcuts',{'version':1,'screenIds':List<String>.from(defaults)},binding);}catch(_){throw const WorkFailure('invalid',400);}
    _client=PreferenceSyncClient(binding:binding,transport:(request)async{_lastError=null;try{return await transport(request);}catch(e){_lastError=e;rethrow;}},cache:_SettingsCache(cache),uuid:()=>_wireKey);
  }
  factory ApplicationSettingsPort.authenticated({required Uri origin,required String token,required PreferenceBinding binding,required PreferenceCache cache,
    required Map<String,String> names,required Map<String,String> labels,required String? Function() currentToken,required PreferenceScope? Function() currentScope,
    List<String> defaults=const [],http.Client? client}){
    final wire=PreferenceHttpTransport(origin:origin,token:token,client:client);
    void guard(){final now=currentScope();if(currentToken()!=token||now==null||!now.same(binding.scope))throw const PreferenceFailure('scope_changed',403);}
    try{return ApplicationSettingsPort(binding:binding,cache:cache,names:names,labels:labels,defaults:defaults,closeTransport:client==null?wire.close:null,
      transport:(request)async{guard();try{final raw=await wire.call(request);guard();return raw;}catch(_){guard();rethrow;}});}catch(_){if(client==null)wire.close();rethrow;}
  }
  void _open(){if(_dead)throw const WorkFailure('unavailable');}
  Never _fail([Object? error]){final e=error??_lastError;if(e==null&&_client.current['error']=='scope_changed')throw const WorkFailure('denied',403);if(e is WorkFailure)throw e;if(e is PreferenceFailure)throw WorkFailure([401,403].contains(e.status)?'denied':e.status==409?'conflict':e.status==400?'invalid':'error',e.status);throw const WorkFailure('error');}
  String _body(Map<String,dynamic> snapshot){final doc=snapshot['document'],ids=doc==null?defaults:List<String>.from((doc as Map)['screenIds'] as List);
    if(ids.any((id)=>!names.containsKey(id)))throw const WorkFailure('unavailable');return ids.map((id)=>names[id]!).join('\n');}
  WorkSnapshot _project(Map<String,dynamic> snapshot)=>WorkSnapshot.fromJson({'scope':binding.scope.toJson(),'module':'settings','items':[
    {'id':'navigation','version':(snapshot['revision'] as int)+1,'title':labels['shortcuts'],'body':_body(snapshot),'date':'','lane':'','meta':'',
      'actions':[{'id':'edit','label':labels['editShortcuts'],'fields':['body'],'target':''}]}],
    'lanes':<Object?>[],'offset':0,'total':1,'partial':false},binding.scope,'settings');
  Future<Map<String,dynamic>> _fresh()async{_open();try{final raw=await transport({'version':1,'expectedScope':binding.scope.toJson(),'dataset':binding.scope.dataset,
    'kind':'shortcuts','resource':'navigation','action':'read'});_open();return preferenceSnapshot(raw,binding);}catch(e){_fail(e);}}
  @override Future<Object?> read(WorkQuery query)async{
    _open();if(query.offset!=0||query.search.length>100)throw const WorkFailure('invalid',400);await _client.load();_open();final state=_client.current;
    if(['error','offline'].contains(state['status']))_fail();if(state['pending']!=null||state['dirty']==true||state['remote']!=null)throw const WorkFailure('conflict',409);
    final snapshot=await _fresh();_confirmed=snapshot;final out=_project(snapshot).toJson();
    if(query.search.isNotEmpty&&!_body(snapshot).toLowerCase().contains(query.search.toLowerCase())&&!labels['shortcuts']!.toLowerCase().contains(query.search.toLowerCase())){out['items']=<Object?>[];out['total']=0;}return out;
  }
  @override Future<WorkReceipt> mutate(WorkCommand command,String key)async{
    _open();if(!RegExp(r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',caseSensitive:false).hasMatch(key))throw const WorkFailure('invalid',400);if(command.itemId!='navigation'||command.action!='edit')throw const WorkFailure('denied',403);
    var pending=_commands[key];if(pending!=null&&canonicalPreference(pending.command.toJson())!=canonicalPreference(command.toJson()))throw const WorkFailure('conflict',409);
    if(pending==null){final confirmed=_confirmed,state=_client.current;if(confirmed==null||(confirmed['revision'] as int)+1!=command.version||state['pending']!=null||state['dirty']==true||state['remote']!=null)throw const WorkFailure('conflict',409);
      validateWorkCommand(_project(confirmed).items.single,command.action,command.fields);
      final body=command.fields['body']!,selected=body.trim().isEmpty?<String>[]:body.split(RegExp(r'\r?\n')).map((s)=>s.trim()).toList(),byName={for(final e in names.entries)e.value:e.key};
      if(selected.any((name)=>!byName.containsKey(name)))throw const WorkFailure('invalid',400);final document=<String,Object?>{'version':1,'screenIds':selected.map((name)=>byName[name]!).toList()};
      try{preferenceDocument('shortcuts',document,binding);}catch(_){throw const WorkFailure('invalid',400);}if(_commands.length>=10)throw const WorkFailure('unavailable');
      pending=_SettingsCommand(command,document);_commands[key]=pending;_wireKey=key;await _client.edit(document);_open();if(_client.current['status']!='dirty')_fail();await _client.save();
    }else{final state=_client.current;if(state['pending']!=null){if((state['pending'] as Map)['requestId']!=key)throw const WorkFailure('conflict',409);await _client.retryPending();}
      else if(state['status']!='clean'||(state['base'] as Map)['revision']!=command.version||canonicalPreference((state['base'] as Map)['document'])!=canonicalPreference(pending.document))throw const WorkFailure('conflict',409);}
    _open();final state=_client.current,base=Map<String,dynamic>.from(state['base'] as Map);
    if(state['status']!='clean'||base['revision']!=command.version||canonicalPreference(base['document'])!=canonicalPreference(pending.document))_fail();
    return WorkReceipt('navigation',(base['revision'] as int)+1,'edit',{'body':_body(base)});
  }
  @override Future<Object?> readItem(String id)async{_open();if(id!='navigation')throw const WorkFailure('denied',403);final snapshot=await _fresh(),expected=_commands.values.lastOrNull;
    if(expected!=null&&(snapshot['revision']!=expected.command.version||canonicalPreference(snapshot['document'])!=canonicalPreference(expected.document)))throw const WorkFailure('conflict',409);
    _confirmed=snapshot;_commands.clear();return _project(snapshot).toJson();}
  Map<String,dynamic> get recovery=>_client.current;
  @override void dispose(){if(_dead)return;_dead=true;_client.dispose();_commands.clear();_confirmed=null;closeTransport?.call();}
}

