import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/dashboard_pages.dart';
import 'package:flutter_core/preference_sync/preference_protocol.dart' show PreferenceScope;

void main() {
  final fixture=jsonDecode(File('test/dashboard_pages/parity-fixtures.json').readAsStringSync()) as Map<String,dynamic>;
  final scope=PreferenceScope.fromJson(fixture['scope']);
  Map<String,dynamic> raw()=>jsonDecode(jsonEncode(fixture['raw'])) as Map<String,dynamic>;
  final labels=<String,String>{'project':'Task <overview>','analytics':'Operations','finance':'Finance','crypto':'Crypto','live':'LIVE','demo':'DEMO','denied':'Denied','unavailable':'Unavailable',
    'open':'Open','review':'Review','blocked':'Blocked','overdue':'Overdue','completed':'Completed','invoice':'Invoice','pricing':'Pricing','authentication':'Account access','coming-soon':'Coming soon','maintenance':'Maintenance','error':'Error','static-coming-soon':'Not activated','static-maintenance':'Presentation only','static-error':'Use approved workflow'};
  test('web/native projections and supporting statuses match shared fixtures',(){
    for(final expected in fixture['projections'] as List){
      final projected=DashboardPageProjection.fromResponse(expected['family'] as String,raw(),scope);
      expect(projected.toJson(),expected);
      expect(()=>projected.metrics.clear(),throwsUnsupportedError);
    }
    for(final row in fixture['supportingPages'] as List){expect(supportingPageStatus(row['kind'] as String),row['status']);}
  });
  test('scope, synthetic marker, invalid counts and view denial fail closed',(){
    for(final count in [null,'2',-1,1.5,double.nan,double.infinity,9007199254740992]){
      final response=raw();(response['taskStats'] as Map)['open']=count;
      expect(()=>DashboardPageProjection.fromResponse('project',response,scope),throwsArgumentError);
    }
    final wrong=raw();(wrong['organization'] as Map)['id']='foreign';
    expect(()=>DashboardPageProjection.fromResponse('project',wrong,scope),throwsArgumentError);
    final marked=raw()..['synthetic']=true;
    expect(()=>DashboardPageProjection.fromResponse('project',marked,scope),throwsArgumentError);
    final denied=raw()..['allowedViews']=['tasks'];
    expect(DashboardPageProjection.fromResponse('analytics',denied,scope).status,'denied');
    expect(DashboardPageProjection.fromResponse('analytics',denied,scope).metrics,isEmpty);
  });
  Widget app(Widget child)=>MaterialApp(home:Scaffold(body:SingleChildScrollView(child:child)));
  testWidgets('literal labels, metric semantics and narrow layout', (tester)async{
    tester.view.physicalSize=const Size(360,740);tester.view.devicePixelRatio=1;
    addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
    final semantics=tester.ensureSemantics();addTearDown(semantics.dispose);
    await tester.pumpWidget(app(PrimeDashboardPage(projection:DashboardPageProjection.fromResponse('project',raw(),scope),labels:labels)));
    expect(find.text('Task <overview>'),findsOneWidget);expect(find.text('LIVE'),findsOneWidget);
    expect(find.bySemanticsLabel('Open: 5'),findsOneWidget);expect(tester.takeException(),isNull);
    await tester.pumpWidget(app(PrimeDashboardPage(projection:DashboardPageProjection.fromResponse('finance',raw(),scope),labels:labels)));
    expect(find.text('Unavailable'),findsOneWidget);expect(find.text('Open: 5'),findsNothing);
  });
  testWidgets('supporting pages expose no billing or authentication actions', (tester)async{
    for(final kind in supportingPageKinds){
      await tester.pumpWidget(app(PrimeSupportingPage(kind:kind,labels:labels)));
      expect(find.text(labels[kind]!),findsOneWidget);
      expect(find.text(labels[supportingPageStatus(kind)]!),findsOneWidget);
      expect(find.byType(TextField),findsNothing);expect(find.byType(TextButton),findsNothing);
    }
  });
  test('record projections match web fixtures and do not expose denied sources',(){
    for(final expected in fixture['recordProjections'] as List){
      expect(RecordPageProjection.fromResponse(expected['kind'] as String,raw(),scope).toJson(),expected);
    }
    expect(RecordPageProjection.fromResponse('search',raw(),scope,query:'<literal>').rows.length,1);
    expect(RecordPageProjection.fromResponse('search',raw(),scope,query:'absent').status,'empty');
    final denied=raw()..['allowedViews']=<String>[];
    expect(RecordPageProjection.fromResponse('activity',denied,scope).rows,isEmpty);
    expect(RecordPageProjection.fromResponse('search',denied,scope).status,'denied');
    for(final date in ['2026-02-30T10:00:00Z','2026-11-01','2026-11-01T10:00:00','2026-11-01T10:00:60Z']){
      final invalid=raw()..['events']=[{'action':'create','created_at':date}];
      expect(()=>RecordPageProjection.fromResponse('activity',invalid,scope),throwsArgumentError);
    }
    final oversized=raw()..['tasks']=List.filled(101,{'id':'t','title':'Task'});
    expect(()=>RecordPageProjection.fromResponse('search',oversized,scope),throwsArgumentError);
  });
  testWidgets('record presentation shows bounded scope and clears on replacement',(tester)async{
    final recordLabels=<String,String>{'activity':'Activity','search':'Search','bounded':'Only loaded records','ready':'Ready','empty':'Empty','denied':'Denied','live':'LIVE','demo':'DEMO'};
    await tester.pumpWidget(app(PrimeRecordPage(projection:RecordPageProjection.fromResponse('search',raw(),scope),labels:recordLabels)));
    expect(find.text('Only loaded records'),findsOneWidget);expect(find.text('Task <literal>'),findsOneWidget);
    final denied=raw()..['allowedViews']=<String>[];
    await tester.pumpWidget(app(PrimeRecordPage(projection:RecordPageProjection.fromResponse('search',denied,scope),labels:recordLabels)));
    expect(find.text('Denied'),findsOneWidget);expect(find.text('Task <literal>'),findsNothing);
  });

}
