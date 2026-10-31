import 'package:flutter/foundation.dart';
import '../preference_sync/preference_sync_client.dart';import 'shell_utilities_model.dart';
export 'shell_utilities_model.dart';
class UtilityPort {
 final Future<Object?> Function() load;final Future<Object?> Function(String,bool)? markRead;final void Function(String)? activate;
 const UtilityPort({required this.load,this.markRead,this.activate});
}
/// Authenticated host owns registered resource bindings. Missing ports stay unavailable.
class ShellUtilitiesController extends ChangeNotifier {
 final PreferenceScope scope;final PreferenceSyncClient favourites;final List<UtilityDestination> destinations;final void Function(String) navigate;
 final Map<String,UtilityPort> _ports;final _states=<String,UtilityState>{};bool _dead=false;
 ShellUtilitiesController({required this.scope,required this.favourites,required List<UtilityDestination> destinations,required this.navigate,Map<String,UtilityPort> ports=const {}}):destinations=List.unmodifiable(destinations),_ports=Map.unmodifiable(ports){if(!scope.same(favourites.binding.scope)||favourites.binding.kind!='shortcuts'||favourites.binding.resource!='navigation'||ports.keys.any((k)=>!utilityKinds.contains(k)))throw StateError('utility_scope_mismatch');final ids=<String>{};if(destinations.any((n)=>!ids.add(n.id)||!favourites.binding.screenIds.contains(n.id)))throw const FormatException('invalid_utility_destination');for(final k in utilityKinds){_states[k]=UtilityState(ports.containsKey(k)?'idle':'unavailable');}favourites.addListener(_emit);}
 Map<String,UtilityState> get current=>Map.unmodifiable(_states);
 void _emit(){if(!_dead)notifyListeners();}
 bool canActivate(String kind)=>_ports[kind]?.activate!=null;
 void activate(String kind,String id){if(_dead||!(_states[kind]?.items.any((i)=>i.id==id)??false)||_ports[kind]?.activate==null)throw StateError('action_unavailable');_ports[kind]!.activate!(id);}
 bool canMarkRead(String kind)=>_ports[kind]?.markRead!=null;
 Future<void> load(String kind)async{if(_dead||!utilityKinds.contains(kind)||_states[kind]!.busy)throw StateError('utility_unavailable');final port=_ports[kind];if(port==null){_states[kind]=const UtilityState('unavailable');_emit();return;}_states[kind]=UtilityState('loading',items:_states[kind]!.items,busy:true);_emit();try{final items=utilityItems(await port.load());if(_dead)return;_states[kind]=UtilityState('ready',items:items);}catch(_){if(_dead)return;_states[kind]=const UtilityState('error',error:'resource_unavailable');}_emit();}
 Future<void> markRead(String kind,String id,bool read)async{if(_dead||!utilityKinds.contains(kind)||_states[kind]!.busy)throw StateError('utility_unavailable');final state=_states[kind]!,port=_ports[kind],item=state.items.where((i)=>i.id==id).firstOrNull;if(port?.markRead==null||item==null||item.read==null)throw StateError('action_unavailable');_states[kind]=UtilityState(state.status,items:state.items,busy:true);_emit();try{final result=utilityItems([await port!.markRead!(id,read)]).single;if(result.id!=id||result.read!=read)throw StateError('invalid_utility_response');if(_dead)return;_states[kind]=UtilityState('ready',items:List.unmodifiable(state.items.map((i)=>i.id==id?result:i)));}catch(_){if(_dead)return;_states[kind]=UtilityState('error',items:state.items,error:'action_unavailable');}_emit();}
 List<UtilityDestination> search(String query,{String locale='en'}){if(_dead||query.length>100||!['en','fr','es'].contains(locale))throw StateError('invalid_utility_search');final q=query.trim().toLowerCase();return destinations.where((n)=>'${n.title} ${n.detail}'.toLowerCase().contains(q)).toList(growable:false);}
 void open(String id){if(_dead||!destinations.any((n)=>n.id==id&&!n.disabled))throw StateError('destination_unavailable');navigate(id);}
 Future<void> toggle(String id)async{if(_dead||!destinations.any((n)=>n.id==id&&!n.disabled))throw StateError('destination_unavailable');final draft=favourites.current['draft'] as Map?,ids=List<String>.from(draft?['screenIds'] as List? ?? const []);if(ids.contains(id)){ids.remove(id);}else{ids.add(id);}await favourites.edit({'version':1,'screenIds':ids});}
 @override void dispose(){if(_dead)return;_dead=true;favourites.removeListener(_emit);favourites.dispose();_states.clear();super.dispose();}
}
