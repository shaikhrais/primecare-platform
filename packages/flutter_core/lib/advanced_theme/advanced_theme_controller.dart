import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'advanced_theme_model.dart';
class AdvancedThemeController extends ChangeNotifier {
 final String scope;final Future<String?> Function(String) read;final Future<void> Function(String,String) write;
 Map<String,Object?> _value={'version':2,'active':null,'items':<Object>[]};bool _disposed=false,_busy=false,_ready=false;
 AdvancedThemeController({required this.scope,required this.read,required this.write}){if(scope.trim().isEmpty||scope.length>1024)throw ArgumentError('Actor scope required');}
 String get key=>'primecare.advanced-theme.v2:$scope';bool get busy=>_busy;bool get ready=>_ready;
 Map<String,Object?> get current=>jsonDecode(jsonEncode(_value)) as Map<String,Object?>;
 AdvancedTheme? get active=>_value['active']==null?null:AdvancedTheme.fromJson(_value['active']);
 List<Map<String,Object?>> get items=>(current['items']! as List).cast<Map<String,Object?>>();
 Future<void> initialize()async{if(_disposed||_busy||_ready)throw StateError('Controller not available');_busy=true;try{final raw=await read(key);if(_disposed)throw StateError('Actor disposed');if(raw!=null){if(utf8.encode(raw).length>1048576)throw const FormatException('Theme library too large');_value=validateAdvancedLibrary(jsonDecode(raw));}_ready=true;}finally{_busy=false;if(!_disposed)notifyListeners();}}
 Future<void> _commit(Object next)async{if(_disposed||_busy||!_ready)throw StateError('Controller not available');final validated=validateAdvancedLibrary(next);_busy=true;notifyListeners();try{await write(key,jsonEncode(validated));if(_disposed)throw StateError('Actor disposed');_value=validated;}finally{_busy=false;if(!_disposed)notifyListeners();}}
 String _id(){final random=Random.secure(),bytes=List.generate(16,(_)=>random.nextInt(256));bytes[6]=(bytes[6]&15)|64;bytes[8]=(bytes[8]&63)|128;final h=bytes.map((b)=>b.toRadixString(16).padLeft(2,'0')).join();return '${h.substring(0,8)}-${h.substring(8,12)}-${h.substring(12,16)}-${h.substring(16,20)}-${h.substring(20)}';}
 Future<String> save(AdvancedTheme theme,{String? id})async{final next=current,list=(next['items']! as List).cast<Map<String,Object?>>();if(id!=null&&!list.any((i)=>i['id']==id))throw StateError('Theme no longer exists');final key=id??_id(),index=list.indexWhere((i)=>i['id']==key);if(id==null&&index>=0)throw StateError('Duplicate generated identity');if(index<0){list.add({'id':key,'theme':theme.toJson()});}else{list[index]={'id':key,'theme':theme.toJson()};}next['items']=list;await _commit(next);return key;}
 Future<void> apply(AdvancedTheme? theme)=>_commit({...current,'active':theme?.toJson()});
 Future<void> rename(String id,String name)async{final next=current,list=(next['items']! as List).cast<Map<String,Object?>>(),index=list.indexWhere((i)=>i['id']==id);if(index<0)throw StateError('Theme no longer exists');final old=list[index]['theme'],theme=AdvancedTheme.fromJson(old).patch('name',name);list[index]={'id':id,'theme':theme.toJson()};next['items']=list;if(jsonEncode(next['active'])==jsonEncode(old))next['active']=theme.toJson();await _commit(next);}
 Future<String> duplicate(String id,String name){final item=items.where((i)=>i['id']==id).firstOrNull;if(item==null)throw StateError('Theme no longer exists');return save(AdvancedTheme.fromJson(item['theme']).patch('name',name));}
 Future<void> remove(String id){if(!items.any((i)=>i['id']==id))throw StateError('Theme no longer exists');return _commit({...current,'items':items.where((i)=>i['id']!=id).toList()});}
 @override void dispose(){_disposed=true;super.dispose();}
}
