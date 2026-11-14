import 'package:flutter/foundation.dart';import '../preference_sync/preference_protocol.dart' show PreferenceScope,canonicalPreference;import 'dashboard_widgets_model.dart';
class DashboardSnapshot {final PreferenceScope scope;final String resource;final int revision;final DashboardLayout? document;const DashboardSnapshot(this.scope,this.resource,this.revision,this.document);}
abstract interface class DashboardPreferencePort {Future<DashboardSnapshot> read(PreferenceScope scope,String resource);Future<DashboardSnapshot> write(PreferenceScope scope,String resource,int revision,DashboardLayout document,String requestId);}
class DashboardSession extends ChangeNotifier {final PreferenceScope scope;final String resource;final List<WidgetSpec> widgets;final List<ViewportSpec> views;final DashboardLayout defaults;final DashboardPreferencePort? port;final String Function()? requestId;late DashboardLayout _document;({DashboardLayout document,int revision,String requestId,int edits})? _pending;DashboardSnapshot? _acknowledged;bool get pending=>_pending!=null;int revision=0,_epoch=0,_edits=0;String? _knownContent;bool loaded=false,_dead=false;String status;
 DashboardSession({required this.scope,required this.resource,required List<WidgetSpec> widgets,required List<ViewportSpec> views,required this.defaults,this.port,this.requestId}):widgets=List.unmodifiable(widgets),views=List.unmodifiable(views),status=port==null?'unavailable':'idle'{if(!RegExp(r'^[a-z][a-z0-9-]{0,63}$').hasMatch(resource))throw ArgumentError('invalid_resource');validateRegistry(widgets,views);_document=DashboardLayout.fromJson(defaults.toJson(),widgets,views);}
 DashboardLayout get document=>DashboardLayout.fromJson(_document.toJson(),widgets,views);
 DashboardSnapshot _snapshot(DashboardSnapshot s){if(!scope.same(s.scope)||s.resource!=resource||s.revision<0||s.revision>9007199254740991||s.revision==0&&s.document!=null)throw StateError('invalid_snapshot');if(s.document!=null)DashboardLayout.fromJson(s.document!.toJson(),widgets,views);return s;}
 void edit(DashboardLayout d){if(_dead||status=='loading')throw StateError('dashboard_busy');_document=DashboardLayout.fromJson(d.toJson(),widgets,views);_edits++;if(!['saving','conflict'].contains(status))status='dirty';notifyListeners();}
 Future<void> load()async{if(_dead||port==null||['loading','saving'].contains(status))return;if(pending)throw StateError('dashboard_pending_resolution');final g=++_epoch;status='loading';notifyListeners();try{final s=_snapshot(await port!.read(scope,resource));if(_dead||g!=_epoch)return;if(s.revision<revision)throw StateError('stale_dashboard_snapshot');final content=canonicalPreference(s.document?.toJson());if(loaded&&s.revision==revision&&content!=_knownContent)throw StateError('inconsistent_dashboard_snapshot');revision=s.revision;_knownContent=content;_document=s.document??DashboardLayout.fromJson(defaults.toJson(),widgets,views);loaded=true;status=s.document==null?'ready':'clean';}catch(_){if(_dead||g!=_epoch)return;status='error';}notifyListeners();}
 Future<void> save()async{
  if(_dead||port==null||!loaded||pending||['loading','saving','conflict'].contains(status)||revision>=9007199254740991)throw StateError('dashboard_unavailable');
  final generation=_epoch,key=requestId?.call();if(_dead||generation!=_epoch)throw StateError('dashboard_unavailable');if(key==null||!RegExp(r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',caseSensitive:false).hasMatch(key))throw StateError('request_id_required');
  _pending=(document:document,revision:revision,requestId:key,edits:_edits);await _sendPending();
 }
 Future<void> retryPending()async{if(_dead||port==null||!pending||['loading','saving','conflict'].contains(status))throw StateError('dashboard_unavailable');await _sendPending();}
 Future<void> _sendPending()async{
  final g=++_epoch,p=_pending!;status='saving';notifyListeners();
  try{
   if(_acknowledged==null){
    final acknowledged=_snapshot(await port!.write(scope,resource,p.revision,DashboardLayout.fromJson(p.document.toJson(),widgets,views),p.requestId));
    if(_dead||g!=_epoch)return;
    if(acknowledged.revision!=p.revision+1||canonicalPreference(acknowledged.document?.toJson())!=canonicalPreference(p.document.toJson()))throw StateError('invalid_acknowledgement');
    _acknowledged=DashboardSnapshot(scope,resource,acknowledged.revision,DashboardLayout.fromJson(acknowledged.document!.toJson(),widgets,views));
   }
   final verified=_snapshot(await port!.read(scope,resource));if(_dead||g!=_epoch)return;
   if(verified.revision<_acknowledged!.revision)throw StateError('stale_dashboard_readback');
   if(verified.revision!=_acknowledged!.revision||canonicalPreference(verified.document?.toJson())!=canonicalPreference(p.document.toJson()))throw const DashboardConflict();
   revision=verified.revision;_knownContent=canonicalPreference(verified.document?.toJson());_pending=null;_acknowledged=null;status=_edits==p.edits?'clean':'dirty';
  }catch(e){if(_dead||g!=_epoch)return;status=e is DashboardConflict?'conflict':'error';if(status=='conflict'){_pending=null;_acknowledged=null;}}
  final failed=['error','conflict'].contains(status);notifyListeners();if(failed)throw StateError('dashboard_save_failed');
 }

 @override void dispose(){_dead=true;_epoch++;_pending=null;_acknowledged=null;status='disposed';super.dispose();}}
class DashboardConflict implements Exception {const DashboardConflict();}
