import 'dart:async';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeText;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/work_modules.dart';
import 'package:flutter_core/preference_sync/preference_protocol.dart';
import 'package:flutter_core/component_catalogue/prime_component_catalogue.dart';
final scope=PreferenceScope('tenant-fixture','actor-fixture','tenant_admin','live');
Map<String,Object?> data(String module,{int version=1,String title='Original task'})=>{'scope':scope.toJson(),'module':module,'items':[{'id':'Task-A','version':version,'title':title,'body':'Task instructions','date':'2026-11-05','lane':'open','meta':'','actions':module=='contacts'?<Map<String,Object?>>[]:[{'id':'edit','label':'Edit task','fields':['title','body','date'],'target':''}]}],'lanes':[{'id':'open','label':'Open'}],'offset':0,'total':1,'partial':false};
class Port implements WorkPort {final String module;int calls=0;bool lose=false,deny=false,loseRead=false;int readCalls=0;final keys=<String>[];Map<String,Object?> value;Port(this.module):value=data(module);@override Future<Object?> read(WorkQuery q)async=>value;@override Future<WorkReceipt> mutate(WorkCommand c,String key)async{calls++;keys.add(key);if(deny)throw const WorkFailure('denied',403);if(lose&&calls==1)throw Exception('lost response');value=data(module,version:c.version+1,title:c.fields['title']!);return WorkReceipt(c.itemId,c.version+1,c.action,{'title':c.fields['title']!});}@override Future<Object?> readItem(String id)async{readCalls++;if(loseRead&&readCalls==1)throw Exception('verification offline');return value;}@override void dispose(){}}
WorkModuleSession session(String module,Port p)=>WorkModuleSession(scope,module,port:p,requestId:()=> '00000000-0000-4000-8000-000000000001');
class DatePort extends Port {
 DatePort():super('tasks');
 @override Future<WorkReceipt> mutate(WorkCommand c,String key)async{
  calls++;final prior=Map<String,Object?>.from((value['items'] as List).single as Map);
  value={...value,'items':[{...prior,'version':c.version+1,...c.fields}]};
  return WorkReceipt(c.itemId,c.version+1,c.action,{...c.fields});
 }
}
class DelayedPort extends Port {
 final gate=Completer<void>();
 DelayedPort():super('tasks');
 @override Future<WorkReceipt> mutate(WorkCommand c,String key)async{await gate.future;return super.mutate(c,key);}
}
class DelayedRecoveryPort extends Port {
 final gate=Completer<void>();
 DelayedRecoveryPort():super('tasks'){loseRead=true;}
 @override Future<Object?> readItem(String id)async{if(readCalls==1)await gate.future;return super.readItem(id);}
}
class ReceiptReadPort extends Port {
 final int failureStatus;final bool mismatch;
 ReceiptReadPort(this.failureStatus,{this.mismatch=false}):super('tasks');
 @override Future<Object?> readItem(String id)async{
  readCalls++;
  if(readCalls==1){
   if(mismatch)return data(module);
   throw WorkFailure([401,403].contains(failureStatus)?'denied':failureStatus==409?'conflict':'error',failureStatus);
  }
  return value;
 }
}
class MutableReceiptPort extends Port {
 final expected=<String,String>{'title':'Verified'};
 MutableReceiptPort():super('tasks');
 @override Future<WorkReceipt> mutate(WorkCommand command,String key)async{
  calls++;return WorkReceipt(command.itemId,command.version+1,command.action,expected);
 }
 @override Future<Object?> readItem(String id)async{
  readCalls++;
  if(readCalls==1){expected['title']='Incorrect';return data(module,version:2,title:'Incorrect');}
  return data(module,version:2,title:'Verified');
 }
}
void main(){
 for(final failureStatus in [400,404,409,503])test('acknowledged receipt survives readback $failureStatus',()async{
  final p=ReceiptReadPort(failureStatus),s=session('tasks',p);await s.load();
  await expectLater(s.submit('Task-A','edit',{'title':'Verified','body':'Instructions','date':'2026-11-06'}),throwsA(isA<WorkFailure>()));
  final originalKey=s.pendingKey,receipt=s.pendingReceipt;
  expect(s.pending,isNotNull);expect(receipt,isNotNull);expect(s.snapshot!.items.single.title,'Original task');
  await expectLater(s.load(),throwsA(isA<WorkFailure>()));
  await expectLater(s.submit('Task-A','edit',{'title':'Different','body':'Instructions','date':'2026-11-06'}),throwsA(isA<WorkFailure>()));
  expect(s.pendingKey,originalKey);expect(s.pendingReceipt,same(receipt));
  await s.retryPending();expect(s.status,'success');expect(p.calls,1);expect(p.readCalls,2);s.dispose();
 });
 test('mismatched readback preserves acknowledgment for verification retry',()async{
  final p=ReceiptReadPort(409,mismatch:true),s=session('tasks',p);await s.load();
  await expectLater(s.submit('Task-A','edit',{'title':'Verified','body':'Instructions','date':'2026-11-06'}),throwsA(isA<WorkFailure>()));
  expect(s.pendingReceipt,isNotNull);expect(s.pending,isNotNull);
  await s.retryPending();expect(s.status,'success');expect(p.calls,1);expect(p.readCalls,2);s.dispose();
 });
 for(final failureStatus in [401,403])test('verification denial $failureStatus clears protected session',()async{
  final p=ReceiptReadPort(failureStatus),s=session('tasks',p);await s.load();
  await expectLater(s.submit('Task-A','edit',{'title':'Verified','body':'Instructions','date':'2026-11-06'}),throwsA(isA<WorkFailure>()));
  expect(s.status,'denied');expect(s.snapshot,isNull);expect(s.pending,isNull);expect(s.pendingReceipt,isNull);expect(s.pendingKey,isNull);s.dispose();
 });
 test('port-owned receipt mutation cannot alter independent verification',()async{
  final p=MutableReceiptPort(),s=session('tasks',p);await s.load();
  await expectLater(s.submit('Task-A','edit',{'title':'Verified','body':'Instructions','date':'2026-11-06'}),throwsA(isA<WorkFailure>()));
  expect(s.status,'conflict');expect(s.pending,isNotNull);expect(s.pendingReceipt!.expected['title'],'Verified');expect(s.snapshot!.items.single.title,'Original task');
  await s.retryPending();expect(s.status,'success');expect(p.calls,1);expect(p.readCalls,2);expect(s.snapshot!.items.single.title,'Verified');s.dispose();
 });
 final metadata=jsonDecode(File('../primecare_ui/catalogs/work-modules.registration.json').readAsStringSync());
 for(final locale in ['en','fr','es'])for(final firstWeekday in [0,1])testWidgets('calendar localized headings and date semantics $locale/$firstWeekday',(t)async{
  final semantics=t.ensureSemantics();
  addTearDown(()=>t.binding.setSurfaceSize(null));
  final p=Port('calendar');p.value={...data('calendar'),'items':<Object?>[],'total':0};
  final s=session('calendar',p),labels=CatalogueLabels.fromMetadata(metadata,locale);
  try{
  for(final width in [320.0,600.0])for(final scale in [1.0,2.0]){
   await t.binding.setSurfaceSize(Size(width,1800));
   await t.pumpWidget(MaterialApp(locale:Locale(locale),supportedLocales:const [Locale('en'),Locale('fr'),Locale('es')],localizationsDelegates:GlobalMaterialLocalizations.delegates,
    builder:(context,child)=>MediaQuery(data:MediaQuery.of(context).copyWith(textScaler:TextScaler.linear(scale)),child:child!),
    home:Scaffold(body:SingleChildScrollView(child:PrimeWorkModule(labels:labels,session:s,scope:'calendar-fixture',year:2026,month:11,firstWeekday:firstWeekday,gap:8,boardWidth:250)))));
   await t.pumpAndSettle();expect(t.takeException(),isNull);
   final days=workMonth(2026,11,firstWeekday),context=t.element(find.byType(PrimeWorkModule)),localizations=MaterialLocalizations.of(context);
   final headers=t.widgetList<Semantics>(find.byWidgetPredicate((w)=>w is Semantics&&w.properties.header==true)).toList();
   expect(headers.length,7);
   for(var i=0;i<7;i++){
    final date=DateTime.parse(days[i].date);
    expect(headers[i].properties.label,DateFormat.EEEE(locale).format(date));
    expect((headers[i].child! as PrimeText).data,localizations.narrowWeekdays[date.weekday%7]);
   }
   final fullDate=localizations.formatFullDate(DateTime(2026,11,5));
   final dateText=find.byWidgetPredicate((w)=>w is PrimeText&&w.semanticsLabel==fullDate);
   expect(dateText,findsOneWidget);await t.ensureVisible(dateText);await t.pumpAndSettle();
   expect(t.getSemantics(dateText).label,fullDate);
   expect(s.snapshot!.items,isEmpty);expect(p.calls,0);
  }
  }finally{await t.pumpWidget(const SizedBox());s.dispose();semantics.dispose();}
 });
 testWidgets('populated calendar owns horizontal scrolling at narrow widths and enlarged text',(t)async{
  addTearDown(()=>t.binding.setSurfaceSize(null));
  final p=Port('calendar'),s=session('calendar',p),labels=CatalogueLabels.fromMetadata(metadata,'en');
  for(final width in [320.0,600.0])for(final scale in [1.0,2.0,3.0]){
   await t.binding.setSurfaceSize(Size(width,1800));
   await t.pumpWidget(MaterialApp(builder:(context,child)=>MediaQuery(data:MediaQuery.of(context).copyWith(textScaler:TextScaler.linear(scale)),child:child!),home:Scaffold(body:SingleChildScrollView(child:PrimeWorkModule(labels:labels,session:s,scope:'populated-calendar',year:2026,month:11,gap:8,boardWidth:250)))));
   await t.pumpAndSettle();expect(t.takeException(),isNull);
   expect(find.text('Original task'),findsOneWidget);expect(s.snapshot!.items.single.date,'2026-11-05');expect(p.calls,0);
   final horizontal=find.byWidgetPredicate((w)=>w is SingleChildScrollView&&w.scrollDirection==Axis.horizontal);
   expect(horizontal,findsOneWidget);
   final scroll=t.state<ScrollableState>(find.descendant(of:horizontal,matching:find.byType(Scrollable)).first);
   expect(scroll.position.maxScrollExtent,greaterThan(0));
   await t.ensureVisible(find.text('Original task'));await t.pumpAndSettle();expect(t.takeException(),isNull);
  }
  await t.pumpWidget(const SizedBox());s.dispose();
 });
 test('strict calendar dates, first weekday, bounds and collision-free IDs',(){expect(workMonth(2028,2,1).length,42);expect(workMonth(2028,2,1).first.date,'2028-01-31');expect(workMonth(2028,2,1).where((d)=>d.inMonth).length,29);expect(validWorkDate('2027-02-29'),false);expect(recordSuffix('A'),isNot(recordSuffix('a')));expect(()=>workMonth(2026,13),throwsA(isA<WorkFailure>()));});
 test('snapshot rejects wrong scope, duplicate IDs and unknown fields',(){final raw=data('tasks');expect(WorkSnapshot.fromJson(raw,scope,'tasks').items.single.version,1);expect(()=>WorkSnapshot.fromJson(raw,PreferenceScope('other','actor-fixture','tenant_admin','live'),'tasks'),throwsA(isA<WorkFailure>()));final duplicate=data('tasks');(duplicate['items'] as List).add((duplicate['items'] as List).first);expect(()=>WorkSnapshot.fromJson(duplicate,scope,'tasks'),throwsA(isA<WorkFailure>()));raw['extra']=true;expect(()=>WorkSnapshot.fromJson(raw,scope,'tasks'),throwsA(isA<WorkFailure>()));});
 test('success requires receipt and fresh readback; editor version is checked',()async{final p=Port('tasks'),s=session('tasks',p);await s.load();await s.submit('Task-A','edit',{'title':'Saved','body':'Instructions','date':'2026-11-06'},expectedVersion:1);expect(s.status,'success');expect(s.snapshot!.items.single.title,'Saved');await expectLater(s.submit('Task-A','edit',{'title':'Stale','body':'Instructions','date':'2026-11-06'},expectedVersion:1),throwsA(isA<WorkFailure>()));expect(p.calls,1);s.dispose();});
 test('uncertain retry preserves command and idempotency key',()async{final p=Port('tasks')..lose=true,s=session('tasks',p);await s.load();await expectLater(s.submit('Task-A','edit',{'title':'Retry','body':'Instructions','date':'2026-11-06'}),throwsA(isA<WorkFailure>()));expect(s.pending,isNotNull);await s.retryPending();expect(s.status,'success');expect(p.keys[0],p.keys[1]);s.dispose();});
 test('acknowledged mutation retries only verification and retains pending context',()async{
  final p=Port('tasks')..loseRead=true,s=session('tasks',p);await s.load();
  await expectLater(s.submit('Task-A','edit',{'title':'Verified','body':'Instructions','date':'2026-11-06'}),throwsA(isA<WorkFailure>()));
  expect(s.pending,isNotNull);await expectLater(s.load(const WorkQuery('replacement')),throwsA(isA<WorkFailure>()));
  expect(s.snapshot!.items.single.title,'Original task');expect(s.query.search,'');
  await s.retryPending();expect(s.status,'success');expect(p.calls,1);expect(p.readCalls,2);s.dispose();
 });
 test('denied mutation removes protected data',()async{final p=Port('tasks')..deny=true,s=session('tasks',p);await s.load();await expectLater(s.submit('Task-A','edit',{'title':'Denied','body':'Instructions','date':'2026-11-06'}),throwsA(isA<WorkFailure>()));expect(s.status,'denied');expect(s.snapshot,isNull);s.dispose();});
 for(final module in ['calendar','contacts','tasks','notes','board']){testWidgets('$module uses registered semantics and renders its authorized projection',(t)async{await t.binding.setSurfaceSize(const Size(1400,1600));addTearDown(()=>t.binding.setSurfaceSize(null));final p=Port(module),s=session(module,p),labels=CatalogueLabels.fromMetadata(metadata,'en');await t.pumpWidget(MaterialApp(home:Scaffold(body:SingleChildScrollView(child:PrimeWorkModule(labels:labels,session:s,scope:'fixture',year:2026,month:11,gap:8,boardWidth:250)))));await t.pumpAndSettle();expect(t.takeException(),isNull);expect(find.text('Original task'),findsOneWidget);expect(find.text(labels.text(module)),findsWidgets);final create=t.widget<TextButton>(find.widgetWithText(TextButton,labels.text('create')).first);expect(create.onPressed,isNull);await t.tap(find.widgetWithText(TextButton,labels.text('open')).first);await t.pumpAndSettle();expect(t.takeException(),isNull);expect(find.text(labels.text('success')),findsNothing);await t.pumpWidget(const SizedBox());s.dispose();});}
 for(final module in ['calendar','contacts','tasks','notes','board'])testWidgets('$module editor focuses detail and restores its opener on Close',(t)async{
  await t.binding.setSurfaceSize(const Size(1400,1800));addTearDown(()=>t.binding.setSurfaceSize(null));
  final p=Port(module),s=session(module,p),labels=CatalogueLabels.fromMetadata(metadata,'en');
  await t.pumpWidget(MaterialApp(home:Scaffold(body:SingleChildScrollView(child:PrimeWorkModule(labels:labels,session:s,scope:'focus-$module',year:2026,month:11,gap:8,boardWidth:250)))));
  await t.pumpAndSettle();final open=find.widgetWithText(TextButton,labels.text('open')).first;final opener=t.widget<TextButton>(open).focusNode!;
  await t.ensureVisible(open);await t.tap(open);await t.pumpAndSettle();
  final detail=t.widget<Focus>(find.byWidgetPredicate((w)=>w is Focus&&w.focusNode?.debugLabel=='work-module-detail'));
  expect(detail.focusNode!.hasPrimaryFocus,true);
  if(module!='contacts')await t.enterText(find.byType(TextField).at(1),'Changed draft');
  final close=find.widgetWithText(TextButton,labels.text('close')).first;await t.ensureVisible(close);await t.tap(close);await t.pumpAndSettle();
  expect(opener.hasPrimaryFocus,true);expect(s.snapshot!.items.single.title,'Original task');expect(p.calls,0);expect(t.takeException(),isNull);
  await t.pumpWidget(const SizedBox());s.dispose();
 });
 testWidgets('verified Save restores keyboard focus to the same item',(t)async{
  await t.binding.setSurfaceSize(const Size(1400,1800));addTearDown(()=>t.binding.setSurfaceSize(null));
  final p=Port('tasks'),s=session('tasks',p),labels=CatalogueLabels.fromMetadata(metadata,'en');
  await t.pumpWidget(MaterialApp(home:Scaffold(body:SingleChildScrollView(child:PrimeWorkModule(labels:labels,session:s,scope:'save-focus',year:2026,month:11,gap:8,boardWidth:250)))));
  await t.pumpAndSettle();final open=find.widgetWithText(TextButton,labels.text('open')).first;final opener=t.widget<TextButton>(open).focusNode!;
  await t.tap(open);await t.pumpAndSettle();await t.enterText(find.byType(TextField).at(1),'Saved task title');
  final save=find.widgetWithText(TextButton,labels.text('save')).first;await t.ensureVisible(save);await t.tap(save);await t.pumpAndSettle();
  expect(s.status,'success');expect(p.calls,1);expect(s.snapshot!.items.single.title,'Saved task title');expect(opener.hasPrimaryFocus,true);expect(t.takeException(),isNull);
  await t.pumpWidget(const SizedBox());s.dispose();
 });
 testWidgets('late Save from an old actor cannot steal new actor keyboard focus',(t)async{
  await t.binding.setSurfaceSize(const Size(1400,1800));addTearDown(()=>t.binding.setSurfaceSize(null));
  final p=DelayedPort(),old=session('tasks',p),other=PreferenceScope('tenant-fixture','second-actor','tenant_admin','live');
  final q=Port('tasks');q.value={...data('tasks',title:'Second actor task'),'scope':other.toJson()};
  final current=WorkModuleSession(other,'tasks',port:q,requestId:()=> '00000000-0000-4000-8000-000000000002'),actor=ValueNotifier(false),labels=CatalogueLabels.fromMetadata(metadata,'en');
  await t.pumpWidget(MaterialApp(home:Scaffold(body:SingleChildScrollView(child:ValueListenableBuilder<bool>(valueListenable:actor,builder:(context,next,child)=>PrimeWorkModule(labels:labels,session:next?current:old,scope:next?'second-actor-view':'first-actor-view',year:2026,month:11,gap:8,boardWidth:250))))));
  await t.pumpAndSettle();await t.tap(find.widgetWithText(TextButton,labels.text('open')).first);await t.pumpAndSettle();await t.enterText(find.byType(TextField).at(1),'Old actor change');
  final save=find.widgetWithText(TextButton,labels.text('save')).first;await t.ensureVisible(save);await t.tap(save);await t.pump();actor.value=true;await t.pumpAndSettle();
  await t.showKeyboard(find.byType(TextField).first);final focus=t.widget<EditableText>(find.byType(EditableText).first).focusNode;expect(focus.hasFocus,true);
  p.gate.complete();await t.pumpAndSettle();expect(focus.hasFocus,true);expect(current.snapshot!.items.single.title,'Second actor task');expect(q.calls,0);expect(t.takeException(),isNull);
  await t.pumpWidget(const SizedBox());old.dispose();current.dispose();actor.dispose();
 });
 testWidgets('authorized due-date editor uses the shared picker and waits for save readback',(t)async{
  await t.binding.setSurfaceSize(const Size(1000,1600));addTearDown(()=>t.binding.setSurfaceSize(null));
  final p=DatePort(),s=session('tasks',p),labels=CatalogueLabels.fromMetadata(metadata,'en');
  await t.pumpWidget(MaterialApp(home:Scaffold(body:SingleChildScrollView(child:PrimeWorkModule(labels:labels,session:s,scope:'date-task',year:2026,month:11,gap:8,boardWidth:250)))));
  await t.pumpAndSettle();await t.tap(find.widgetWithText(TextButton,labels.text('open')).first);await t.pumpAndSettle();
  final date=find.byWidgetPredicate((w)=>w is TextField&&w.decoration?.labelText==labels.text('date'));
  expect(t.widget<TextField>(date).keyboardType,TextInputType.datetime);
  await t.ensureVisible(find.byTooltip(labels.text('date')));await t.tap(find.byTooltip(labels.text('date')));await t.pumpAndSettle();
  expect(find.byType(DatePickerDialog),findsOneWidget);await t.tap(find.text('6').last);await t.tap(find.text('OK'));await t.pumpAndSettle();
  expect(t.widget<TextField>(date).controller!.text,'2026-11-06');expect(s.snapshot!.items.single.date,'2026-11-05');expect(p.calls,0);
  await t.ensureVisible(find.widgetWithText(TextButton,labels.text('save')).first);await t.tap(find.widgetWithText(TextButton,labels.text('save')).first);await t.pumpAndSettle();
  expect(s.status,'success');expect(s.snapshot!.items.single.date,'2026-11-06');expect(p.calls,1);expect(t.takeException(),isNull);
  await t.pumpWidget(const SizedBox());s.dispose();
 });
 testWidgets('dirty editor survives internal reload and item selection',(t)async{
  await t.binding.setSurfaceSize(const Size(1400,1600));addTearDown(()=>t.binding.setSurfaceSize(null));
  final p=Port('tasks'),s=session('tasks',p),labels=CatalogueLabels.fromMetadata(metadata,'en');
  await t.pumpWidget(MaterialApp(home:Scaffold(body:SingleChildScrollView(child:PrimeWorkModule(labels:labels,session:s,scope:'fixture',year:2026,month:11,gap:8,boardWidth:250)))));
  await t.pumpAndSettle();await t.tap(find.widgetWithText(TextButton,labels.text('open')).first);await t.pumpAndSettle();
  await t.enterText(find.byType(TextField).at(1),'Retain unsaved title');
  await t.tap(find.widgetWithText(TextButton,labels.text('reload')).first);await t.pumpAndSettle();
  expect(t.widget<TextField>(find.byType(TextField).at(1)).controller!.text,'Retain unsaved title');
  await t.tap(find.widgetWithText(TextButton,labels.text('open')).first);await t.pumpAndSettle();
  expect(t.widget<TextField>(find.byType(TextField).at(1)).controller!.text,'Retain unsaved title');expect(p.calls,0);expect(t.takeException(),isNull);
  await t.pumpWidget(const SizedBox());s.dispose();
 });
 testWidgets('pending action locks navigation and fields and offers original verification retry',(t)async{
  await t.binding.setSurfaceSize(const Size(1400,1600));addTearDown(()=>t.binding.setSurfaceSize(null));
  final p=Port('tasks')..loseRead=true,s=session('tasks',p),labels=CatalogueLabels.fromMetadata(metadata,'en');
  await t.pumpWidget(MaterialApp(home:Scaffold(body:SingleChildScrollView(child:PrimeWorkModule(labels:labels,session:s,scope:'fixture',year:2026,month:11,gap:8,boardWidth:250)))));
  await t.pumpAndSettle();await t.tap(find.widgetWithText(TextButton,labels.text('open')).first);await t.pumpAndSettle();
  await t.enterText(find.byType(TextField).at(1),'Recovered task');
  await t.tap(find.widgetWithText(TextButton,labels.text('save')).first);await t.pumpAndSettle();
  expect(s.pending,isNotNull);expect(t.widget<TextField>(find.byType(TextField).first).enabled,false);
  expect(t.widget<TextButton>(find.widgetWithText(TextButton,labels.text('reload')).first).onPressed,isNull);
  // Recreating a view must expose the original recovery action without triggering a destructive load.
  await t.pumpWidget(const SizedBox());
  await t.pumpWidget(MaterialApp(home:Scaffold(body:SingleChildScrollView(child:PrimeWorkModule(labels:labels,session:s,scope:'fixture',year:2026,month:11,gap:8,boardWidth:250)))));
  await t.pumpAndSettle();expect(t.takeException(),isNull);
  await t.tap(find.widgetWithText(TextButton,labels.text('save')).first);await t.pumpAndSettle();
  expect(s.status,'success');expect(p.calls,1);expect(p.readCalls,2);expect(t.takeException(),isNull);
  await t.pumpWidget(const SizedBox());s.dispose();
 });

 testWidgets('verified toolbar recovery restores its originating keyboard opener without rewriting',(t)async{
  await t.binding.setSurfaceSize(const Size(1400,1800));addTearDown(()=>t.binding.setSurfaceSize(null));
  final p=Port('tasks')..loseRead=true,s=session('tasks',p),labels=CatalogueLabels.fromMetadata(metadata,'en');
  await t.pumpWidget(MaterialApp(home:Scaffold(body:SingleChildScrollView(child:PrimeWorkModule(labels:labels,session:s,scope:'recover-focus',year:2026,month:11,gap:8,boardWidth:250)))));
  await t.pumpAndSettle();final open=find.widgetWithText(TextButton,labels.text('open')).first;final opener=t.widget<TextButton>(open).focusNode!;
  await t.tap(open);await t.pumpAndSettle();await t.enterText(find.byType(TextField).at(1),'Recovered focus task');
  await t.tap(find.widgetWithText(TextButton,labels.text('save')).first);await t.pumpAndSettle();expect(s.pending,isNotNull);expect(p.calls,1);
  final recovery=find.widgetWithText(TextButton,labels.text('save')).first;await t.ensureVisible(recovery);await t.tap(recovery);await t.pumpAndSettle();
  expect(s.status,'success');expect(s.pending,isNull);expect(p.calls,1);expect(p.readCalls,2);expect(s.snapshot!.items.single.title,'Recovered focus task');expect(opener.hasPrimaryFocus,true);expect(t.takeException(),isNull);
  await t.pumpWidget(const SizedBox());s.dispose();
 });
 testWidgets('late toolbar recovery cannot steal replacement actor focus',(t)async{
  await t.binding.setSurfaceSize(const Size(1400,1800));addTearDown(()=>t.binding.setSurfaceSize(null));
  final p=DelayedRecoveryPort(),old=session('tasks',p),other=PreferenceScope('tenant-fixture','recovery-second-actor','tenant_admin','live');
  final q=Port('tasks');q.value={...data('tasks',title:'Current actor task'),'scope':other.toJson()};
  final current=WorkModuleSession(other,'tasks',port:q),actor=ValueNotifier(false),labels=CatalogueLabels.fromMetadata(metadata,'en');
  await t.pumpWidget(MaterialApp(home:Scaffold(body:SingleChildScrollView(child:ValueListenableBuilder<bool>(valueListenable:actor,builder:(context,next,child)=>PrimeWorkModule(labels:labels,session:next?current:old,scope:next?'recovery-second':'recovery-first',year:2026,month:11,gap:8,boardWidth:250))))));
  await t.pumpAndSettle();await t.tap(find.widgetWithText(TextButton,labels.text('open')).first);await t.pumpAndSettle();
  await t.enterText(find.byType(TextField).at(1),'Old recovered task');await t.tap(find.widgetWithText(TextButton,labels.text('save')).first);await t.pumpAndSettle();expect(old.pending,isNotNull);
  final recovery=find.widgetWithText(TextButton,labels.text('save')).first;await t.ensureVisible(recovery);await t.tap(recovery);await t.pump();actor.value=true;await t.pumpAndSettle();
  await t.showKeyboard(find.byType(TextField).first);final focus=t.widget<EditableText>(find.byType(EditableText).first).focusNode;expect(focus.hasFocus,true);
  p.gate.complete();await t.pumpAndSettle();expect(focus.hasFocus,true);expect(current.snapshot!.items.single.title,'Current actor task');expect(p.calls,1);expect(q.calls,0);expect(t.takeException(),isNull);
  await t.pumpWidget(const SizedBox());old.dispose();current.dispose();actor.dispose();
 });

 testWidgets('clean editor reload adopts refreshed title and version before Save',(t)async{
  await t.binding.setSurfaceSize(const Size(1400,1800));addTearDown(()=>t.binding.setSurfaceSize(null));
  final p=Port('tasks'),s=session('tasks',p),labels=CatalogueLabels.fromMetadata(metadata,'en');
  await t.pumpWidget(MaterialApp(home:Scaffold(body:SingleChildScrollView(child:PrimeWorkModule(labels:labels,session:s,scope:'refresh-clean',year:2026,month:11,gap:8,boardWidth:250)))));
  await t.pumpAndSettle();await t.tap(find.widgetWithText(TextButton,labels.text('open')).first);await t.pumpAndSettle();
  p.value=data('tasks',version:2,title:'Refreshed native task');
  await t.tap(find.widgetWithText(TextButton,labels.text('reload')).first);await t.pumpAndSettle();
  expect(t.widget<TextField>(find.byType(TextField).at(1)).controller!.text,'Refreshed native task');
  final save=find.widgetWithText(TextButton,labels.text('save')).first;await t.ensureVisible(save);await t.tap(save);await t.pumpAndSettle();
  expect(s.status,'success');expect(s.snapshot!.items.single.version,3);expect(p.calls,1);expect(t.takeException(),isNull);
  await t.pumpWidget(const SizedBox());s.dispose();
 });
 testWidgets('dirty draft keeps original version across external native refresh',(t)async{
  await t.binding.setSurfaceSize(const Size(1400,1800));addTearDown(()=>t.binding.setSurfaceSize(null));
  final p=Port('tasks'),s=session('tasks',p),labels=CatalogueLabels.fromMetadata(metadata,'en');
  await t.pumpWidget(MaterialApp(home:Scaffold(body:SingleChildScrollView(child:PrimeWorkModule(labels:labels,session:s,scope:'refresh-dirty',year:2026,month:11,gap:8,boardWidth:250)))));
  await t.pumpAndSettle();await t.tap(find.widgetWithText(TextButton,labels.text('open')).first);await t.pumpAndSettle();
  await t.enterText(find.byType(TextField).at(1),'Retained native draft');p.value=data('tasks',version:2,title:'New server title');await s.load();await t.pumpAndSettle();
  expect(t.widget<TextField>(find.byType(TextField).at(1)).controller!.text,'Retained native draft');
  final save=find.widgetWithText(TextButton,labels.text('save')).first;await t.ensureVisible(save);await t.tap(save);await t.pumpAndSettle();
  expect(p.calls,0);expect(s.snapshot!.items.single.title,'New server title');expect(t.widget<TextField>(find.byType(TextField).at(1)).controller!.text,'Retained native draft');expect(t.takeException(),isNull);
  await t.pumpWidget(const SizedBox());s.dispose();
 });
 testWidgets('clean native reload removes newly revoked editor actions',(t)async{
  await t.binding.setSurfaceSize(const Size(1400,1800));addTearDown(()=>t.binding.setSurfaceSize(null));
  final p=Port('tasks'),s=session('tasks',p),labels=CatalogueLabels.fromMetadata(metadata,'en');
  await t.pumpWidget(MaterialApp(home:Scaffold(body:SingleChildScrollView(child:PrimeWorkModule(labels:labels,session:s,scope:'refresh-denied',year:2026,month:11,gap:8,boardWidth:250)))));
  await t.pumpAndSettle();await t.tap(find.widgetWithText(TextButton,labels.text('open')).first);await t.pumpAndSettle();
  p.value=data('tasks',version:2);((p.value['items'] as List).single as Map)['actions']=<Object?>[];await s.load();await t.pumpAndSettle();
  expect(find.widgetWithText(TextButton,labels.text('save')),findsNothing);expect(p.calls,0);expect(t.takeException(),isNull);
  await t.pumpWidget(const SizedBox());s.dispose();
 });

}

