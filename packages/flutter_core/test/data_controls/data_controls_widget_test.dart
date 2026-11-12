import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeCheckbox, PrimeTextFormField;
import 'dart:async';import 'dart:convert';import 'dart:io';import 'package:flutter/material.dart';import 'package:flutter_test/flutter_test.dart';import 'package:flutter_core/component_catalogue.dart' show CatalogueLabels,PrimeCatalogueAction;import 'package:flutter_core/data_controls.dart';
void main(){final l=CatalogueLabels.fromMetadata(jsonDecode(File('../primecare_ui/catalogs/data-controls.registration.json').readAsStringSync()),'en');Widget app(Widget child)=>MaterialApp(home:Scaffold(body:SingleChildScrollView(child:child)));
 testWidgets('large virtual table mounts bounded rows and filters real supplied projection',(t)async{final rows=List.generate(50000,(i)=>DataRowSpec('r$i',{'n':i,'text':'row $i'}));await t.pumpWidget(app(PrimeVirtualTable(labels:l,scope:'table',columns:[DataColumnSpec('n','Number',120),DataColumnSpec('text','Text',150)],rows:rows,rowHeight:56,height:200,minWidth:80,maxWidth:400,actionWidth:120,pageSize:1000)));expect(find.byType(SelectableText).evaluate().length,lessThan(30));await t.enterText(find.byType(TextField).first,'row 49999');await t.pump();expect(find.byWidgetPredicate((w)=>w is SelectableText&&w.data=='row 49999'),findsOneWidget);expect(find.textContaining('/ 1'),findsOneWidget);});
 testWidgets('required typed fields and rejected submit preserve input',(t)async{final kit=PrimeDataKit(l,'form'),key=GlobalKey<FormState>(),number=TextEditingController(),date=TextEditingController();var calls=0;await t.pumpWidget(app(kit.form(key,[kit.field('number',number,required:true,min:0,max:10,step:0.5),kit.field('date',date,required:true)],()async{calls++;throw StateError('denied');})));await t.tap(find.text(l.text('submit')));await t.pumpAndSettle();expect(calls,0);await t.enterText(find.byType(PrimeTextFormField).first,'1.5');await t.enterText(find.byType(PrimeTextFormField).last,'2024-02-29');await t.tap(find.text(l.text('submit')));await t.pumpAndSettle();expect(calls,1);expect(number.text,'1.5');expect(find.text(l.text('error')),findsOneWidget);await t.pumpWidget(const SizedBox());number.dispose();date.dispose();});
 testWidgets('structured editor formatting and failed save retain literal source',(t)async{var calls=0;final doc={'version':1,'blocks':[{'text':'<script>literal</script>','bold':false,'italic':false,'kind':'paragraph'}]};await t.pumpWidget(app(PrimeStructuredEditor(labels:l,scope:'editor',document:doc,save:(d)async{calls++;throw StateError('denied');})));await t.tap(find.text(l.text('bold')));await t.pumpAndSettle();await t.ensureVisible(find.text(l.text('save')));await t.tap(find.text(l.text('save')));await t.pumpAndSettle();expect(calls,1);expect(find.text(l.text('error')),findsOneWidget);expect(find.byWidgetPredicate((w)=>w is SelectableText&&w.data=='<script>literal</script>'&&w.style?.fontWeight==FontWeight.bold),findsOneWidget);});
 testWidgets('opt-in range formatting previews and retains spans across failed saves and text edits',(t)async{
  await t.binding.setSurfaceSize(const Size(1000,1600));addTearDown(()=>t.binding.setSurfaceSize(null));
  final doc={'version':1,'blocks':[{'text':'Hello world','bold':false,'italic':false,'kind':'paragraph'}]};Map<String,Object?>? saved;var fail=true;
  await t.pumpWidget(app(PrimeStructuredEditor(labels:l,scope:'ranges',document:doc,inlineRanges:true,save:(d)async{saved=d;if(fail)throw StateError('denied');})));
  final controller=t.widget<TextField>(find.byType(TextField).first).controller!;controller.selection=const TextSelection(baseOffset:0,extentOffset:5);
  await t.tap(find.text(l.text('bold')));await t.pumpAndSettle();expect(find.byWidgetPredicate((w)=>w is SelectableText&&w.textSpan!=null),findsOneWidget);
  await t.ensureVisible(find.text(l.text('save')));await t.tap(find.text(l.text('save')));await t.pumpAndSettle();
  expect(((saved!['blocks'] as List).single as Map)['marks'],[{'start':0,'end':5,'bold':true,'italic':false}]);expect(find.text(l.text('error')),findsOneWidget);
  await t.ensureVisible(find.byType(TextField).first);await t.enterText(find.byType(TextField).first,'XHello world');await t.pumpAndSettle();fail=false;
  await t.ensureVisible(find.text(l.text('save')));await t.tap(find.text(l.text('save')));await t.pumpAndSettle();expect(((saved!['blocks'] as List).single as Map)['marks'],[{'start':0,'end':6,'bold':true,'italic':false}]);expect(t.takeException(),isNull);
 });
 testWidgets('range editor tracks the caret when identical characters are inserted',(t)async{
  await t.binding.setSurfaceSize(const Size(1000,1600));addTearDown(()=>t.binding.setSurfaceSize(null));
  final doc={'version':2,'blocks':[{'text':'aaaa','bold':false,'italic':false,'kind':'paragraph','marks':[{'start':1,'end':2,'bold':true,'italic':false}]}]};Map<String,Object?>? saved;
  await t.pumpWidget(app(PrimeStructuredEditor(labels:l,scope:'repeated',document:doc,inlineRanges:true,save:(d)async{saved=d;})));
  final controller=t.widget<TextField>(find.byType(TextField).first).controller!;await t.showKeyboard(find.byType(TextField).first);controller.selection=const TextSelection.collapsed(offset:0);t.testTextInput.updateEditingValue(const TextEditingValue(text:'aaaaa',selection:TextSelection.collapsed(offset:1)));await t.pumpAndSettle();
  await t.ensureVisible(find.text(l.text('save')));await t.tap(find.text(l.text('save')));await t.pumpAndSettle();
  expect(((saved!['blocks'] as List).single as Map)['marks'],[{'start':2,'end':3,'bold':true,'italic':false}]);expect(t.takeException(),isNull);
 });
 testWidgets('marked input requires an explicit range capability',(t)async{
  final doc={'version':2,'blocks':[{'text':'ab','bold':false,'italic':false,'kind':'paragraph','marks':[{'start':0,'end':1,'bold':true,'italic':false}]}]};
  await t.pumpWidget(app(PrimeStructuredEditor(labels:l,scope:'legacy-marked',document:doc)));expect(t.takeException(),isArgumentError);
 });
 testWidgets('upload picker, cancellation and late result never produce false success',(t)async{final pending=Completer<String>();var calls=0;await t.pumpWidget(app(PrimeUploadControl(labels:l,scope:'upload-session',policy:const UploadPolicy(maxFiles:1,maxBytes:100,types:['text/plain']),retrySafe:true,pick:()async=>[const UploadCandidate('a.txt',5,'text/plain','opaque')],port:(scope,key,files,cancel,progress){calls++;progress(0.5);return pending.future;})));await t.tap(find.text(l.text('upload')));await t.pumpAndSettle();await t.tap(find.text(l.text('send')));await t.pump();expect(calls,1);await t.tap(find.text(l.text('cancel')));await t.pumpAndSettle();pending.complete('late');await t.pumpAndSettle();expect(find.text(l.text('success')),findsNothing);await t.pumpWidget(const SizedBox());});
 testWidgets('missing autocomplete and upload adapters show unavailable state',(t)async{await t.pumpWidget(app(Column(children:[PrimeDataAutocomplete(labels:l,scope:'none'),PrimeUploadControl(labels:l,scope:'none2',policy:const UploadPolicy(maxFiles:1,maxBytes:100,types:['text/plain']))])));expect(find.text(l.text('unsupported')),findsNWidgets(2));final field=t.widget<TextField>(find.byType(TextField).first);expect(field.enabled,false);});
 testWidgets('autocomplete ignores an older completion and reports denied loading',(t)async{final old=Completer<List<({String value,String label})>>();await t.pumpWidget(app(PrimeDataAutocomplete(labels:l,scope:'search',load:(q)async{if(q=='old')return old.future;if(q=='fail')throw StateError('denied');return [(value:q,label:'$q label')];})));await t.enterText(find.byType(TextField),'old');await t.pump();await t.enterText(find.byType(TextField),'new');await t.pumpAndSettle();old.complete([(value:'old',label:'old label')]);await t.pumpAndSettle();expect(find.text('old label'),findsNothing);expect(find.text('new label'),findsOneWidget);await t.enterText(find.byType(TextField),'fail');await t.pumpAndSettle();expect(find.text(l.text('error')),findsOneWidget);});
 testWidgets('native date and time picker access preserves cancelled values',(t)async{final kit=PrimeDataKit(l,'picker'),date=TextEditingController(text:'2024-02-29'),time=TextEditingController(text:'23:59');await t.pumpWidget(app(Column(children:[kit.field('date',date,firstDate:DateTime(2024),lastDate:DateTime(2025)),kit.field('time',time)])));await t.tap(find.byTooltip(l.text('date')));await t.pumpAndSettle();expect(find.byType(DatePickerDialog),findsOneWidget);await t.tap(find.text('Cancel'));await t.pumpAndSettle();expect(date.text,'2024-02-29');await t.tap(find.byTooltip(l.text('time')));await t.pumpAndSettle();expect(find.byType(TimePickerDialog),findsOneWidget);await t.tap(find.text('Cancel'));await t.pumpAndSettle();expect(time.text,'23:59');await t.pumpWidget(const SizedBox());date.dispose();time.dispose();});

 testWidgets('disabled typed date field blocks both typing and picker dispatch',(t)async{
  final date=TextEditingController(text:'2024-02-29');
  await t.pumpWidget(app(PrimeDataKit(l,'disabled-date').field('date',date,enabled:false,firstDate:DateTime(2024),lastDate:DateTime(2025))));
  expect(t.widget<TextField>(find.byType(TextField)).enabled,false);
  expect(t.widget<IconButton>(find.byType(IconButton)).onPressed,isNull);
  expect(date.text,'2024-02-29');await t.pumpWidget(const SizedBox());date.dispose();
 });
 for(final change in ['scope','controller'])for(final kind in ['date','time'])testWidgets('$kind picker is dismissed after $change changes',(t)async{
  final old=TextEditingController(text:kind=='date'?'2024-02-29':'23:59'),current=TextEditingController(text:kind=='date'?'2024-03-01':'12:30'),changed=ValueNotifier(false);
  final target=change=='controller'?current:old;
  Widget field(bool next)=>PrimeDataKit(l,next&&change=='scope'?'new-actor':'old-actor').field(kind,next?target:old,firstDate:DateTime(2024),lastDate:DateTime(2025));
  await t.pumpWidget(app(ValueListenableBuilder<bool>(valueListenable:changed,builder:(context,next,child)=>field(next))));await t.tap(find.byTooltip(l.text(kind)));await t.pumpAndSettle();
  expect(find.byType(kind=='date'?DatePickerDialog:TimePickerDialog,skipOffstage:false),findsOneWidget);
  changed.value=true;await t.pumpAndSettle();
  expect(find.byType(kind=='date'?DatePickerDialog:TimePickerDialog,skipOffstage:false),findsNothing);
  expect(target.text,change=='controller'?(kind=='date'?'2024-03-01':'12:30'):(kind=='date'?'2024-02-29':'23:59'));expect(t.takeException(),isNull);
  await t.pumpWidget(const SizedBox());old.dispose();current.dispose();changed.dispose();
 });
 testWidgets('date picker never overwrites a newer controller edit',(t)async{
  final date=TextEditingController(text:'2024-02-29');
  await t.pumpWidget(app(PrimeDataKit(l,'date-edit').field('date',date,firstDate:DateTime(2024),lastDate:DateTime(2025))));
  await t.tap(find.byTooltip(l.text('date')));await t.pumpAndSettle();date.text='2024-03-01';
  await t.tap(find.text('OK'));await t.pumpAndSettle();expect(date.text,'2024-03-01');expect(t.takeException(),isNull);
  await t.pumpWidget(const SizedBox());date.dispose();
 });
 testWidgets('disabling a picker closes only its own route',(t)async{
  final enabled=ValueNotifier(true),date=TextEditingController(text:'2024-02-29'),nav=GlobalKey<NavigatorState>();
  await t.pumpWidget(MaterialApp(navigatorKey:nav,home:Scaffold(body:ValueListenableBuilder<bool>(valueListenable:enabled,builder:(context,on,child)=>PrimeDataKit(l,'route-owner').field('date',date,enabled:on,firstDate:DateTime(2024),lastDate:DateTime(2025))))));
  await t.tap(find.byTooltip(l.text('date')));await t.pumpAndSettle();
  unawaited(showDialog<void>(context:nav.currentState!.overlay!.context,builder:(context)=>const AlertDialog(content:Text('Another dialog owner'))));await t.pumpAndSettle();
  enabled.value=false;await t.pumpAndSettle();
  expect(find.byType(DatePickerDialog,skipOffstage:false),findsNothing);expect(find.text('Another dialog owner'),findsOneWidget);
  expect(date.text,'2024-02-29');expect(t.takeException(),isNull);
  nav.currentState!.pop();await t.pumpAndSettle();await t.pumpWidget(const SizedBox());enabled.dispose();date.dispose();
 });

 testWidgets('native editor links use the host adapter and report failures',(t)async{
  final doc={'version':1,'blocks':[{'kind':'paragraph','text':'Read policy','bold':false,'italic':false,'link':'https://example.test/policy'}]};
  String? opened;
  await t.pumpWidget(app(PrimeStructuredEditor(labels:l,scope:'link-reader',document:doc,openLink:(url)async{opened=url;})));
  await t.ensureVisible(find.text('https://example.test/policy'));await t.pumpAndSettle();await t.tap(find.text('https://example.test/policy'));await t.pumpAndSettle();expect(opened,'https://example.test/policy');
  await t.pumpWidget(app(PrimeStructuredEditor(labels:l,scope:'link-reader-failed',document:doc,openLink:(_)async{throw StateError('blocked');})));
  await t.ensureVisible(find.text('https://example.test/policy'));await t.pumpAndSettle();await t.tap(find.text('https://example.test/policy'));await t.pumpAndSettle();expect(find.text(l.text('error')),findsOneWidget);
 });
 testWidgets('native editor suppresses link completion after scope replacement',(t)async{
  final doc={'version':1,'blocks':[{'kind':'paragraph','text':'Policy','bold':false,'italic':false,'link':'https://example.test/policy'}]},pending=Completer<void>();
  await t.pumpWidget(app(PrimeStructuredEditor(labels:l,scope:'old-scope',document:doc,openLink:(_)async=>pending.future)));
  await t.ensureVisible(find.text('https://example.test/policy'));await t.pumpAndSettle();await t.tap(find.text('https://example.test/policy'));await t.pump();
  await t.pumpWidget(app(PrimeStructuredEditor(labels:l,scope:'new-scope',document:doc,openLink:(_)async{})));
  pending.completeError(StateError('late failure'));await t.pumpAndSettle();expect(find.text(l.text('error')),findsNothing);expect(t.takeException(),isNull);
 });

  for (final direction in [TextDirection.ltr, TextDirection.rtl]) {
    testWidgets(
      'pinned native cells retain position and actions in $direction',
      (t) async {
        await t.pumpWidget(
          app(
            Directionality(
              textDirection: direction,
              child: SizedBox(
                width: 600,
                child: PrimeVirtualTable(
                  labels: l,
                  scope: 'sticky',
                  columns: [
                    DataColumnSpec('p', 'Pinned', 160, pinned: true),
                    DataColumnSpec('u', 'Moving', 700),
                  ],
                  rows: [
                    DataRowSpec('r', {'p': 'fixed value', 'u': 'moving value'}),
                  ],
                  rowHeight: 56,
                  height: 200,
                  minWidth: 80,
                  maxWidth: 800,
                  actionWidth: 120,
                ),
              ),
            ),
          ),
        );
        final fixed = find.byWidgetPredicate(
          (w) => w is SelectableText && w.data == 'fixed value',
        );
        final moving = find.byWidgetPredicate(
          (w) => w is SelectableText && w.data == 'moving value',
        );
        final before = t.getTopLeft(fixed), beforeMoving = t.getTopLeft(moving);
        final horizontal = find
            .byWidgetPredicate(
              (w) =>
                  w is SingleChildScrollView &&
                  w.scrollDirection == Axis.horizontal,
            )
            .last;
        final controller = t
            .widget<SingleChildScrollView>(horizontal)
            .controller!;
        controller.jumpTo(220);
        await t.pump();
        expect(t.getTopLeft(fixed).dx, closeTo(before.dx, 0.1));
        expect(
          (t.getTopLeft(moving).dx - beforeMoving.dx).abs(),
          closeTo(220, 0.1),
        );
        expect(find.text('Pinned'), findsOneWidget);
        final checkbox = find.byType(PrimeCheckbox).first;
        await t.tap(checkbox);
        await t.pump();
        expect(t.widget<Checkbox>(checkbox).value, true);
        expect(t.takeException(), isNull);
        await t.pumpWidget(const SizedBox());
      },
    );
  }
 testWidgets('upload selection removal and verified remote deletion are visible',(t)async{
  var writes=0,reads=0,present=true;
  final sent=<String>[];
  await t.pumpWidget(app(PrimeUploadControl(labels:l,scope:'removal-ui',policy:const UploadPolicy(maxFiles:2,maxBytes:100,types:['text/plain']),pick:()async=>[const UploadCandidate('a.txt',5,'text/plain','a'),const UploadCandidate('b.txt',5,'text/plain','b')],port:(a,b,c,d,e)async{sent.addAll(c.map((f)=>f.name));return 'r1';},removalPort:(a,b,c,d)async{writes++;present=false;return UploadRemovalReceipt(b,true);},receiptPort:(a,b,c)async{if(++reads==1)throw StateError('read unavailable');return UploadReceiptState(a,b,present);})));
  await t.tap(find.text(l.text('upload')));await t.pumpAndSettle();
  await t.tap(find.text(l.text('remove')).first);await t.pumpAndSettle();expect(find.text('a.txt'),findsNothing);
  await t.tap(find.text(l.text('send')));await t.pumpAndSettle();expect(sent,['b.txt']);
  final remove=find.descendant(of:find.byWidgetPredicate((w)=>w is PrimeCatalogueAction&&w.control=='remove'&&w.suffix=='-receipt'),matching:find.byType(TextButton));
  await t.ensureVisible(remove);await t.tap(remove);await t.pumpAndSettle();expect(find.text('b.txt'),findsOneWidget);expect(writes,1);
  await t.ensureVisible(remove);await t.tap(remove);await t.pumpAndSettle();expect(find.text('b.txt'),findsNothing);expect(writes,1);expect(t.takeException(),isNull);
 });

}
