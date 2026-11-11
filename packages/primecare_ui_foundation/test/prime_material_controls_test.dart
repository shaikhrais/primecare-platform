import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart';

Widget host(Widget control,ThemeData theme)=>MaterialApp(theme:theme,home:DefaultTabController(length:2,child:Scaffold(body:Center(child:ConstrainedBox(constraints:const BoxConstraints(maxWidth:700,maxHeight:600),child:KeyedSubtree(key:const Key('control'),child:control))))));
List<(Widget,Widget)> controls()=>[
 (const PrimeDrawer(child:Text('Drawer')),const Drawer(child:Text('Drawer'))),
 (PrimeFloatingActionButton(onPressed:(){},child:const Icon(Icons.add)),FloatingActionButton(onPressed:(){},child:const Icon(Icons.add))),
 (PrimeListTile(title:const Text('Tile'),onTap:(){}),ListTile(title:const Text('Tile'),onTap:(){})),
 (PrimeDropdownButton<int>(value:1,items:const[DropdownMenuItem(value:1,child:Text('One')),DropdownMenuItem(value:2,child:Text('Two'))],onChanged:(_){}),DropdownButton<int>(value:1,items:const[DropdownMenuItem(value:1,child:Text('One')),DropdownMenuItem(value:2,child:Text('Two'))],onChanged:(_){})),
 (PrimeDropdownButtonFormField<int>(initialValue:1,items:const[DropdownMenuItem(value:1,child:Text('One'))],onChanged:(_){}),DropdownButtonFormField<int>(initialValue:1,items:const[DropdownMenuItem(value:1,child:Text('One'))],onChanged:(_){})),
 (PrimePopupMenuButton<int>(itemBuilder:(_)=>const[PopupMenuItem(value:1,child:Text('Pick'))]),PopupMenuButton<int>(itemBuilder:(_)=>const[PopupMenuItem(value:1,child:Text('Pick'))])),
 (PrimeTextFormField(initialValue:'Value'),TextFormField(initialValue:'Value')),
 (PrimeFilterChip(label:const Text('Filter'),onSelected:(_){}),FilterChip(label:const Text('Filter'),onSelected:(_){})),
 (const PrimeTabBar(tabs:[Tab(text:'One'),Tab(text:'Two')]),const TabBar(tabs:[Tab(text:'One'),Tab(text:'Two')])),
 (PrimeDataTable(columns:const[DataColumn(label:Text('Column'))],rows:const[DataRow(cells:[DataCell(Text('Cell'))])]),DataTable(columns:const[DataColumn(label:Text('Column'))],rows:const[DataRow(cells:[DataCell(Text('Cell'))])])),
 (PrimeCheckboxListTile(value:false,onChanged:(_){},title:const Text('Check')),CheckboxListTile(value:false,onChanged:(_){},title:const Text('Check'))),
 (PrimeRadioListTile<int>(value:1,groupValue:0,onChanged:(_){},title:const Text('Radio')),RadioListTile<int>(value:1,groupValue:0,onChanged:(_){},title:const Text('Radio'))),
 (PrimeSwitchListTile(value:false,onChanged:(_){},title:const Text('Switch')),SwitchListTile(value:false,onChanged:(_){},title:const Text('Switch'))),
 (PrimeSlider(value:.5,onChanged:(_){}),Slider(value:.5,onChanged:(_){})),
 (PrimeCheckbox(value:false,onChanged:(_){}),Checkbox(value:false,onChanged:(_){})),
 (const PrimeLinearProgressIndicator(value:.5),const LinearProgressIndicator(value:.5)),
 (PrimeChoiceChip(label:const Text('Choice'),selected:false,onSelected:(_){}),ChoiceChip(label:const Text('Choice'),selected:false,onSelected:(_){})),
 (PrimeFilledButton(onPressed:(){},child:const Text('Action')),FilledButton(onPressed:(){},child:const Text('Action'))),
 (const PrimeAlertDialog(title:Text('Title'),content:Text('Content')),const AlertDialog(title:Text('Title'),content:Text('Content'))),
];
void main() {
 testWidgets('all 19 actual adapters retain Material geometry under light and dark themes', (tester) async {
  tester.view.physicalSize=const Size(1200,1000);tester.view.devicePixelRatio=1;
  addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
  for(final theme in [ThemeData.light(),ThemeData.dark()]) {
   final pairs=controls();expect(pairs,hasLength(19));
   for(var i=0;i<pairs.length;i++) {
    await tester.pumpWidget(host(pairs[i].$2,theme));await tester.pumpAndSettle();final expected=tester.getRect(find.byKey(const Key('control')));
    await tester.pumpWidget(host(pairs[i].$1,theme));await tester.pumpAndSettle();final actual=tester.getRect(find.byKey(const Key('control')));
    expect(actual,expected,reason:'adapter $i');expect(tester.takeException(),isNull,reason:'adapter $i');
   }
  }
 });
 testWidgets('input values, validation, selection and tap callbacks remain live', (tester) async {
  var taps=0;String? text;int? picked;
  final form=GlobalKey<FormState>();
  await tester.pumpWidget(host(Form(key:form,child:Column(mainAxisSize:MainAxisSize.min,children:[
   PrimeTextFormField(onChanged:(v){text=v;},validator:(v)=>v==null||v.isEmpty?'Required':null),
   PrimeListTile(title:const Text('Open'),onTap:(){taps++;}),
   PrimeFilledButton(onPressed:(){taps++;},child:const Text('Save')),
   PrimePopupMenuButton<int>(itemBuilder:(_)=>const[PopupMenuItem(value:7,child:Text('Pick seven'))],onSelected:(v){picked=v;},child:const Text('Menu')),
  ])),ThemeData()));
  expect(form.currentState!.validate(),isFalse);await tester.pump();
  await tester.enterText(find.byType(PrimeTextFormField),'kept');expect(text,'kept');expect(form.currentState!.validate(),isTrue);
  await tester.tap(find.text('Open'));await tester.tap(find.text('Save'));expect(taps,2);
  FocusManager.instance.primaryFocus?.unfocus();await tester.pumpAndSettle();
  await tester.tap(find.text('Menu'));await tester.pumpAndSettle();await tester.tap(find.text('Pick seven'));await tester.pumpAndSettle();expect(picked,7);
 });
 testWidgets('nullable icon and named filled-button constructors retain SDK behavior', (tester) async {
  for(final pair in <(Widget,Widget)>[
   (PrimeFilledButton.icon(onPressed:(){},icon:null,label:const Text('Action')),FilledButton.icon(onPressed:(){},icon:null,label:const Text('Action'))),
   (PrimeFilledButton.tonal(onPressed:(){},child:const Text('Action')),FilledButton.tonal(onPressed:(){},child:const Text('Action'))),
   (PrimeFilledButton.tonalIcon(onPressed:(){},icon:const Icon(Icons.add),label:const Text('Action')),FilledButton.tonalIcon(onPressed:(){},icon:const Icon(Icons.add),label:const Text('Action'))),
  ]) {
   await tester.pumpWidget(host(pair.$2,ThemeData()));await tester.pumpAndSettle();final expected=tester.getRect(find.byKey(const Key('control')));
   await tester.pumpWidget(host(pair.$1,ThemeData()));await tester.pumpAndSettle();expect(tester.getRect(find.byKey(const Key('control'))),expected);expect(tester.takeException(),isNull);
  }
 });
 test('SDK defaults and static style function remain unchanged', () {
  expect(const PrimeDrawer().width,const Drawer().width);
  expect(PrimeSlider(value:.2,onChanged:(_){}).max,Slider(value:.2,onChanged:(_){}).max);
  expect(PrimeSwitchListTile(value:false,onChanged:(_){}).isThreeLine,SwitchListTile(value:false,onChanged:(_){}).isThreeLine);
  expect(PrimeFilledButton.styleFrom,same(FilledButton.styleFrom));
 });
}
