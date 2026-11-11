import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/models/presentation_mode.dart';
import 'package:flutter_core/theme/prime_semantic_palette.dart';
import 'package:flutter_core/theme/theme_contrast.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_center_catalog_generated.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'fixtures/presentation_palette_fixture.dart';

void main() {
 testWidgets('six actual presentation helpers use all presets and large text', (tester) async {
  tester.view.physicalSize=const Size(1500,1600);tester.view.devicePixelRatio=1;
  addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
  for(final preset in themeCenterPresetNames) {
   final material=applyPersonalThemeData(ThemeData(),PersonalTheme(name:'Presentation',preset:preset));
   for(final scale in [1.0,2.0]) {
    for(var index=0;index<6;index++) {
     await tester.pumpWidget(MaterialApp(theme:material,home:Scaffold(body:MediaQuery(data:MediaQueryData(textScaler:TextScaler.linear(scale)),
      child:SingleChildScrollView(child:SizedBox(width:1200,child:Align(alignment:Alignment.topLeft,child:Builder(builder:(context){
       final p=PrimeSemanticPalette.of(context,PrimeSemanticTone.primary);
       return KeyedSubtree(key:const Key('fixture'),child:switch(index) {
        0=>presentationPaletteFixture0(context,Icons.home,'Dashboard',scale==2),
        1=>presentationPaletteFixture1(context,'Jane Doe',1),
        2=>presentationPaletteFixture2(context,'Approved','success'),
        3=>presentationPaletteFixture3(context,[{'label':'Revenue','value':'42','trend':'up','change':'12% growth'},{'label':'Expense','value':'24','trend':'down','change':'3% decrease'}]),
        4=>presentationPaletteFixture4(context,title:'Finance section',child:const Text('Existing content')),
        _=>presentationPaletteFixture5(context,[10,20,30],['Jan','Feb','Mar'],p.accent),
       });
      }))))))));
     await tester.pumpAndSettle();
     if(index==1 || index==2) {
      final root=find.byKey(const Key('fixture'));
      final container=tester.widget<Container>(find.descendant(of:root,matching:find.byType(Container)));
      final text=tester.widget<Text>(find.descendant(of:root,matching:find.byType(Text)));
      expect(themeContrastRatio(text.style!.color!,(container.decoration! as BoxDecoration).color!),greaterThanOrEqualTo(4.5));
     }
     if(index==3) {
      for(final label in ['12% growth','3% decrease']) {
       final text=tester.widget<Text>(find.text(label));
       expect(themeContrastRatio(text.style!.color!,material.colorScheme.surface),greaterThanOrEqualTo(4.5));
      }
     }
     expect(tester.takeException(),isNull,reason:'$preset/$scale/$index');
    }
   }
  }
 });
 testWidgets('all 17 actual finance presentations render under light and dark Material themes', (tester) async {
  tester.view.physicalSize=const Size(1800,1600);tester.view.devicePixelRatio=1;
  addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
  const screens=['CfoDashboard','CfoAnalytics','CfoWorkflow','CfoRevenue','CfoExpenses','CfoPayroll','CfoInvoices','CfoTax','CfoProfitability','CfoCashflow','FinancialDashboard','CfoAccountsPayable','CfoAccountsReceivable','CfoFinancialOverview','CfoFranchiseFinancials','CfoReports','CfoTaxAndRemittance'];
  for(final brightness in Brightness.values) {
   for(final screen in screens) {
    await tester.pumpWidget(MaterialApp(theme:ThemeData(colorScheme:ColorScheme.fromSeed(seedColor:Colors.teal,brightness:brightness)),
     home:Builder(builder:(context)=>buildPresentationScreen(context,null,screen))));
    await tester.pumpAndSettle();expect(find.text('Demo Preview'),findsOneWidget);
    expect(tester.takeException(),isNull,reason:'$brightness/$screen');
   }
  }
 });
 testWidgets('all 17 byte-matched finance content bodies compile and render', (tester) async {
  tester.view.physicalSize=const Size(1800,1800);tester.view.devicePixelRatio=1;
  addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
  final builders=<Widget Function(BuildContext)>[presentationPaletteFixture6, presentationPaletteFixture7, presentationPaletteFixture8, presentationPaletteFixture9, presentationPaletteFixture10, presentationPaletteFixture11, presentationPaletteFixture12, presentationPaletteFixture13, presentationPaletteFixture14, presentationPaletteFixture15, presentationPaletteFixture16, presentationPaletteFixture17, presentationPaletteFixture18, presentationPaletteFixture19, presentationPaletteFixture20, presentationPaletteFixture21, presentationPaletteFixture22];
  expect(builders,hasLength(17));
  for(final brightness in Brightness.values) {
   for(var i=0;i<builders.length;i++) {
    await tester.pumpWidget(MaterialApp(theme:ThemeData(colorScheme:ColorScheme.fromSeed(seedColor:Colors.teal,brightness:brightness)),
     home:Scaffold(body:SingleChildScrollView(child:SizedBox(width:1600,child:Builder(builder:builders[i]))))));
    await tester.pumpAndSettle();expect(tester.takeException(),isNull,reason:'$brightness/$i');
   }
  }
 });
 testWidgets('custom status extension and neutral Material fallback remain readable', (tester) async {
  const status=PrimeSemanticStatusColors(success:Colors.cyan,successContainer:Color(0xFF777777),warning:Colors.yellow,warningContainer:Colors.black);
  final original=ThemeData(extensions:const[status]);
  final personal=applyPersonalThemeData(original,PersonalTheme(name:'Custom',preset:themeCenterPresetNames.first));
  expect(personal.extension<PrimeSemanticStatusColors>(),same(status));
  for(final theme in [original,personal,ThemeData.dark()]) {
   await tester.pumpWidget(MaterialApp(theme:theme,home:Builder(builder:(context){
    for(final tone in PrimeSemanticTone.values) {
     final p=PrimeSemanticPalette.of(context,tone);
     expect(themeContrastRatio(p.onAccent,p.accent),greaterThanOrEqualTo(4.5));
     expect(themeContrastRatio(p.onSurface,p.surface),greaterThanOrEqualTo(4.5));
     expect(themeContrastRatio(p.onBase,Theme.of(context).colorScheme.surface),greaterThanOrEqualTo(4.5));
    }
    return const SizedBox();
   })));
  }
 });
}
