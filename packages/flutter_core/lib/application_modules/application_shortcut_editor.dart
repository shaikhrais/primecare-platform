import 'dart:math';
import 'package:flutter/foundation.dart';
import '../preference_sync/preference_sync_client.dart';
import '../work_modules/work_module_model.dart';
import 'application_settings_port.dart';
/// Native counterpart of the owned web picker. No auto retry or implicit conflict resolution.
class ApplicationShortcutEditor extends ChangeNotifier {
 final ApplicationSettingsPort port;
 late final ({PreferenceSyncClient client,Map<String,String> names,List<String> defaults}) _owned;
 bool _dead=false;
 ApplicationShortcutEditor(this.port){_owned=port.claimShortcutEditor(_uuid);if(_owned.names.keys.any((id)=>!RegExp(r'^[1-9][0-9]{0,9}$').hasMatch(id))){port.dispose();throw const WorkFailure('invalid');}_owned.client.addListener(_changed);}
 static String _uuid(){final random=Random.secure(),bytes=List.generate(16,(_)=>random.nextInt(256));bytes[6]=(bytes[6]&15)|64;bytes[8]=(bytes[8]&63)|128;final hex=bytes.map((b)=>b.toRadixString(16).padLeft(2,'0')).join();return '${hex.substring(0,8)}-${hex.substring(8,12)}-${hex.substring(12,16)}-${hex.substring(16,20)}-${hex.substring(20)}';}
 void _changed(){if(!_dead)notifyListeners();}
 PreferenceBinding get binding=>_owned.client.binding;
 Map<String,dynamic> get current{final state=_owned.client.current,draft=state['draft'] as Map?;return {...state,'selected':List<String>.from(draft?['screenIds'] as List? ?? _owned.defaults)};}
 List<({String id,String title})> destinations([String query='']){if(query.length>100)throw const WorkFailure('invalid');final search=query.toLowerCase();return [for(final e in _owned.names.entries)if(e.value.toLowerCase().contains(search))(id:e.key,title:e.value)];}
 void _open(){if(_dead)throw const WorkFailure('unavailable');}
 void _editable(){_open();final state=current;if(state['loaded']!=true||state['pending']!=null||state['remote']!=null||!['clean','dirty','offline'].contains(state['status']))throw const WorkFailure('conflict',409);}
 Future<void> load()async{_open();await _owned.client.load();}
 Future<void> toggle(String id)async{_editable();if(!_owned.names.containsKey(id))throw const WorkFailure('denied',403);final ids=List<String>.from(current['selected'] as List);if(ids.contains(id)){ids.remove(id);}else{ids.add(id);}await _owned.client.edit({'version':1,'screenIds':ids});}
 Future<void> useDefaults()async{_editable();await _owned.client.edit({'version':1,'screenIds':List<String>.from(_owned.defaults)});}
 Future<void> _verify()async{final state=current;if(state['status']=='clean'&&state['dirty']!=true&&state['pending']==null&&state['remote']==null)await _owned.client.load();}
 Future<void> save()async{_editable();if(current['dirty']!=true)throw const WorkFailure('invalid');await _owned.client.save();await _verify();}
 Future<void> retryPending()async{_open();await _owned.client.retryPending();await _verify();}
 Future<void> acceptRemote()async{_open();await _owned.client.acceptRemote();}
 Future<void> keepLocal()async{_open();await _owned.client.keepLocal();}
 @override void dispose(){if(_dead)return;_dead=true;_owned.client.removeListener(_changed);port.dispose();super.dispose();}
}
