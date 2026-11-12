import 'dart:async';import 'dart:convert';import 'dart:io';import 'package:flutter_test/flutter_test.dart';import 'package:flutter_core/dashboard_widgets.dart';import 'package:flutter_core/preference_sync/preference_protocol.dart' show PreferenceScope;
Map<String,Object?> geometryJson(ChartGeometry g)=>{'min':g.min,'max':g.max,'base':g.base,'empty':g.empty,'series':[for(final s in g.series){'id':s.id,'points':[for(final p in s.points)p==null?null:{'x':p.x,'y':p.y,'barX':p.barX,'barWidth':p.barWidth,'value':p.value}]}],'slices':[for(final s in g.slices){'start':s.start,'end':s.end}]};
void equalJson(Object? actual,Object? expected){if(actual is num&&expected is num){expect(actual,closeTo(expected,1e-10));}else if(actual is List&&expected is List){expect(actual.length,expected.length);for(var i=0;i<actual.length;i++){equalJson(actual[i],expected[i]);}}else if(actual is Map&&expected is Map){expect(actual.keys.toSet(),expected.keys.toSet());for(final k in actual.keys){equalJson(actual[k],expected[k]);}}else{expect(actual,expected);}}
class MemoryPort implements DashboardPreferencePort {DashboardSnapshot state;String mode='ok';int reads=0;Completer<void>? pending;MemoryPort(this.state);@override Future<DashboardSnapshot> read(PreferenceScope scope,String resource)async{reads++;return mode=='mismatch'&&state.revision>0?DashboardSnapshot(scope,resource,state.revision+1,state.document):state;}@override Future<DashboardSnapshot> write(PreferenceScope scope,String resource,int revision,DashboardLayout document,String requestId)async{if(mode=='conflict')throw const DashboardConflict();await pending?.future;state=DashboardSnapshot(scope,resource,revision+1,document);return state;}}
class RecoveryPort implements DashboardPreferencePort {
 DashboardSnapshot state;final bool loseAck;bool failed=false;int writes=0,applied=0;final keys=<String>[];DashboardSnapshot? receipt;
 RecoveryPort(this.state,this.loseAck);
 @override Future<DashboardSnapshot> read(PreferenceScope scope,String resource)async{if(!loseAck&&writes>0&&!failed){failed=true;throw StateError('read offline');}return state;}
 @override Future<DashboardSnapshot> write(PreferenceScope scope,String resource,int revision,DashboardLayout document,String requestId)async{writes++;keys.add(requestId);if(receipt!=null)return receipt!;applied++;state=DashboardSnapshot(scope,resource,revision+1,document);receipt=state;if(loseAck&&!failed){failed=true;throw StateError('ack offline');}return state;}
}
class StaleReadbackPort implements DashboardPreferencePort {
 DashboardSnapshot state;bool stale=true;int writes=0;StaleReadbackPort(this.state);
 @override Future<DashboardSnapshot> read(PreferenceScope scope,String resource)async=>writes>0&&stale?DashboardSnapshot(scope,resource,0,null):state;
 @override Future<DashboardSnapshot> write(PreferenceScope scope,String resource,int revision,DashboardLayout document,String requestId)async{writes++;state=DashboardSnapshot(scope,resource,revision+1,document);return state;}
}
void main(){final fixture=jsonDecode(File('test/dashboard_widgets/model-fixtures.json').readAsStringSync()) as Map<String,Object?>,views=(fixture['views'] as List).map(ViewportSpec.fromJson).toList(),widgets=(fixture['widgets'] as List).map(WidgetSpec.fromJson).toList(),defaults=DashboardLayout.fromJson(fixture['defaults'],widgets,views),scope=PreferenceScope('fixture-tenant','fixture-user','fixture-role','demo');String uuid()=> '00000000-0000-4000-8000-000000000001';DashboardSession session([DashboardPreferencePort? port])=>DashboardSession(scope:scope,resource:'fixture',widgets:widgets,views:views,defaults:defaults,port:port,requestId:uuid);
 test('TypeScript/Dart chart, breakpoint and packing oracle',(){for(final raw in fixture['charts'] as List){final row=raw as Map<String,Object?>,data=ChartData.fromJson(row['data']);equalJson(geometryJson(chartGeometry(data)),row['geometry']);}for(final raw in fixture['breakpoints'] as List){final row=raw as List<Object?>;expect(activeViewport((row[0] as num).toDouble(),views),row[1]);}equalJson(packDashboard(defaults.views['wide']!,4).map((p)=>{'id':p.id,'span':p.span,'rows':p.rows,'x':p.x,'y':p.y}).toList(),fixture['packed']);expect(()=>ChartData.fromJson({'kind':'line','title':'bad','categories':['A'],'series':[{'id':'one','label':'One','values':[double.nan]}]}),throwsArgumentError);});
 test('view-specific editing and denied import validation',(){var d=editDashboard(defaults,'small','add','metric',widgets,views);d=editDashboard(d,'small','earlier','metric',widgets,views);expect(d.views['small']!.first.id,'metric');d=editDashboard(d,'small','wider','metric',widgets,views);expect(d.views['small']!.first.span,1);expect(d.views['wide']!.map((p)=>p.toJson()).toList(),defaults.views['wide']!.map((p)=>p.toJson()).toList());expect(()=>DashboardLayout.fromJson(defaults.toJson(),[widgets.first],views),throwsArgumentError);expect(()=>parseDashboard('{"version":1,"views":{"small":[{"id":"denied","span":1,"rows":2}],"wide":[]}}',widgets,views),throwsArgumentError);});
 test('save requires independent readback and reload preserves layout',()async{final port=MemoryPort(DashboardSnapshot(scope,'fixture',0,null)),s=session(port);await s.load();s.edit(defaults);await s.save();expect(s.status,'clean');expect(port.reads,2);final reloaded=session(port);await reloaded.load();expect(reloaded.revision,1);expect(reloaded.document.toJson(),defaults.toJson());s.dispose();reloaded.dispose();});
 test('mismatched readback and denied write retain draft and fail honestly',()async{for(final mode in ['mismatch','conflict']){final port=MemoryPort(DashboardSnapshot(scope,'fixture',0,null))..mode=mode;final s=session(port);await s.load();s.edit(defaults);await expectLater(s.save(),throwsStateError);expect(s.status,'conflict');expect(s.document.toJson(),defaults.toJson());s.dispose();}});
 test('edits during save survive old receipt; disposed completion ignored',()async{final port=MemoryPort(DashboardSnapshot(scope,'fixture',0,null)),s=session(port);await s.load();port.pending=Completer<void>();final save=s.save(),edited=editDashboard(defaults,'wide','remove','metric',widgets,views);s.edit(edited);port.pending!.complete();await save;expect(s.status,'dirty');expect(s.document.toJson(),edited.toJson());port.pending=Completer<void>();final next=s.save();s.dispose();port.pending!.complete();await next;expect(s.status,'disposed');});
 test('pending saves retain original identity and retry verification without another acknowledged write',()async{
  for(final loseAck in [true,false]){
   final port=RecoveryPort(DashboardSnapshot(scope,'fixture',0,null),loseAck),s=session(port);await s.load();s.edit(defaults);
   await expectLater(s.save(),throwsStateError);expect(s.pending,true);await expectLater(s.load(),throwsStateError);await expectLater(s.save(),throwsStateError);
   await s.retryPending();expect(s.status,'clean');expect(s.pending,false);expect(port.applied,1);expect(port.writes,loseAck?2:1);if(loseAck)expect(port.keys[0],port.keys[1]);s.dispose();
  }
 });

 for(final dirty in [false,true])test('stale reload preserves ${dirty?'draft':'saved layout'} and revision',()async{
  final port=MemoryPort(DashboardSnapshot(scope,'fixture',2,defaults)),s=session(port);await s.load();
  if(dirty)s.edit(editDashboard(defaults,'wide','remove','metric',widgets,views));
  final before=s.document.toJson();
  port.state=DashboardSnapshot(scope,'fixture',1,DashboardLayout.fromJson({'version':1,'views':{'small':<Object?>[],'wide':<Object?>[]}},widgets,views));
  await s.load();expect(s.status,'error');expect(s.revision,2);expect(s.document.toJson(),before);expect(s.loaded,true);
  port.state=DashboardSnapshot(scope,'fixture',3,defaults);await s.load();expect(s.status,'clean');expect(s.revision,3);expect(s.document.toJson(),defaults.toJson());s.dispose();
 });

 for(final dirty in [false,true])test('same revision cannot replace known ${dirty?'draft baseline':'saved content'}',()async{
  final port=MemoryPort(DashboardSnapshot(scope,'fixture',2,defaults)),s=session(port);await s.load();
  if(dirty)s.edit(editDashboard(defaults,'wide','remove','metric',widgets,views));final before=s.document.toJson();
  port.state=DashboardSnapshot(scope,'fixture',2,DashboardLayout.fromJson({'version':1,'views':{'small':<Object?>[],'wide':<Object?>[]}},widgets,views));
  await s.load();expect(s.status,'error');expect(s.revision,2);expect(s.document.toJson(),before);
  port.state=DashboardSnapshot(scope,'fixture',2,defaults);await s.load();expect(s.status,'clean');
  s.edit(editDashboard(defaults,'wide','remove','metric',widgets,views));await s.save();expect(s.revision,3);final saved=s.document.toJson();
  port.state=DashboardSnapshot(scope,'fixture',3,defaults);await s.load();expect(s.status,'error');expect(s.revision,3);expect(s.document.toJson(),saved);s.dispose();
 });

 test('stale readback retains acknowledgement and retries without write',()async{
  final port=StaleReadbackPort(DashboardSnapshot(scope,'fixture',0,null)),s=session(port);await s.load();await expectLater(s.save(),throwsStateError);
  expect(s.status,'error');expect(s.pending,true);expect(s.document.toJson(),defaults.toJson());
  final edited=editDashboard(defaults,'wide','remove','metric',widgets,views);s.edit(edited);port.stale=false;await s.retryPending();
  expect(port.writes,1);expect(s.pending,false);expect(s.status,'dirty');expect(s.revision,1);expect(s.document.toJson(),edited.toJson());s.dispose();
 });

 test('request ID callback cannot revive disposed session',()async{
  final port=MemoryPort(DashboardSnapshot(scope,'fixture',0,null));late DashboardSession s;
  s=DashboardSession(scope:scope,resource:'fixture',widgets:widgets,views:views,defaults:defaults,port:port,requestId:(){s.dispose();return uuid();});
  await s.load();await expectLater(s.save(),throwsStateError);expect(s.status,'disposed');expect(s.pending,false);expect(port.state.revision,0);
 });

}
