import 'package:flutter/foundation.dart';
import '../preference_sync/preference_sync_client.dart';
import '../work_modules/work_module_model.dart';
import 'application_settings_port.dart';
/// Native counterpart of the owned web picker. No auto retry or implicit conflict resolution.
class ApplicationShortcutEditor extends ChangeNotifier {
 final ApplicationSettingsPort port;
 late final ({PreferenceSyncClient client,Map<String,String> names,List<String> defaults}) _owned;
 bool _dead=false;
 ApplicationShortcutEditor(this.port){_owned=port.claimShortcutEditor(PreferenceSyncClient.newRequestId);if(_owned.names.keys.any((id)=>!RegExp(r'^[1-9][0-9]{0,9}$').hasMatch(id))){port.dispose();throw const WorkFailure('invalid');}_owned.client.addListener(_changed);}
 void _changed(){if(!_dead)notifyListeners();}
 Map<String,dynamic>? get recoveryPreview=>_owned.client.recoveryPreview;
 Future<Map<String,dynamic>?> reviewRecovery()async{_open();return _owned.client.reviewRecovery();}
 void cancelRecovery(){_open();_owned.client.cancelRecovery();}
 Future<void> confirmRecovery(String token,String mode)async{_open();await _owned.client.confirmRecovery(token,mode);}
 PreferenceBinding get binding=>_owned.client.binding;
 Map<String,dynamic> get current{final state=_owned.client.current,draft=state['draft'] as Map?;return {...state,'selected':List<String>.from(draft?['screenIds'] as List? ?? _owned.defaults)};}
 List<({String id,String title})> destinations([String query='']){_open();if(query.length>100)throw const WorkFailure('invalid');final search=query.toLowerCase();return [for(final e in _owned.names.entries)if(e.value.toLowerCase().contains(search))(id:e.key,title:e.value)];}
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
