import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/theme/prime_theme_resolver.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_center_catalog_generated.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'package:flutter_core/theme/theme_contrast.dart';
import 'fixtures/intake_operations_palette_fixture.dart';

Widget actualFixture(int index,Color color,bool active,ValueChanged<String> selected) => switch(index) {
  0=>OperationsPaletteFixture0(label:'Metric',value:'demo',activeFilter:active ? 'demo':'all',onTap:selected),
  1=>OperationsPaletteFixture1(title:'Metric',value:'42',subtitle:'Existing metric',icon:Icons.show_chart,iconColor:color),
  2=>OperationsPaletteFixture2(title:'Metric',value:'42',icon:Icons.show_chart,color:color),
  3=>OperationsPaletteFixture3(title:'Metric',value:'42',icon:Icons.show_chart,color:color),
  4=>OperationsPaletteFixture4(title:'Metric',value:'42',icon:Icons.show_chart,iconColor:color),
  5=>OperationsPaletteFixture5(title:'Metric',value:'42',subtitle:'Existing metric',icon:Icons.show_chart,color:color),
  _=>OperationsPaletteFixture6(label:'Metric',value:'demo',activeValue:active ? 'demo':'all',onTap:selected),
};

void main() {
  testWidgets('semantic pairs, variable tints and inverse log text retain contrast', (tester) async {
    for(final colors in [const PrimeColors(),const PrimeColors(surface:Color(0xFF777777),primary:Colors.cyan,success:Colors.yellow,error:Colors.pink)]) {
      await tester.pumpWidget(PrimeTheme(data:PrimeThemeData(colors:colors),bootstrap:false,
        child:MaterialApp(home:Builder(builder:(context){
          for(final tone in PrimeActionTone.values) {
            final p=PrimeActionPalette.of(context,tone);
            expect(themeContrastRatio(p.onSurface,p.surface),greaterThanOrEqualTo(4.5));
            expect(themeContrastRatio(p.onAccent,p.accent),greaterThanOrEqualTo(4.5));
            expect(themeContrastRatio(PrimeActionPalette.onTint(context,p.accent),PrimeActionPalette.tintSurface(context,p.accent)),greaterThanOrEqualTo(4.5));
            final inverse=context.theme.colors.inverseSurface;
            expect(themeContrastRatio(readableThemeForeground(inverse,p.accent),inverse),greaterThanOrEqualTo(4.5));
          }
          return const SizedBox();
        }))));
      expect(tester.takeException(),isNull);
    }
  });

  testWidgets('actual assessment badge pairs all existing status branches', (tester) async {
    const base=PrimeThemeData();
    for(final preset in themeCenterPresetNames) {
      final profile=PersonalTheme(name:'Assessment status',preset:preset);
      final material=applyPersonalThemeData(base.toThemeData(),profile);
      final prime=resolvePersonalPrimeTheme(base,material,profile);
      for(final status in ['Completed','Pending','Scheduled']) {
        await tester.pumpWidget(PrimeTheme(data:prime,bootstrap:false,child:MaterialApp(theme:material,
          home:Scaffold(body:PendingAssessmentStatusFixture({'status':status})))));
        final root=find.byType(PendingAssessmentStatusFixture);
        final text=tester.widget<Text>(find.descendant(of:root,matching:find.byType(Text)));
        final container=tester.widget<Container>(find.descendant(of:root,matching:find.byType(Container)));
        final background=(container.decoration! as BoxDecoration).color!;
        expect(text.data,status.toUpperCase());
        expect(themeContrastRatio(text.style!.color!,background),greaterThanOrEqualTo(4.5));
        expect(tester.takeException(),isNull);
      }
    }
  });

  testWidgets('actual metric cards and filter callbacks retain all preset and text scale behavior', (tester) async {
    tester.view.physicalSize=const Size(1000,1200);tester.view.devicePixelRatio=1;
    addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
    const base=PrimeThemeData();
    for(final preset in themeCenterPresetNames) {
      final profile=PersonalTheme(name:'Operations palette',preset:preset);
      final material=applyPersonalThemeData(base.toThemeData(),profile);
      final prime=resolvePersonalPrimeTheme(base,material,profile);
      for(final scale in [1.0,2.0]) {
        for(var index=0;index<7;index++) {
          String? selected;
          late Color input;
          await tester.pumpWidget(PrimeTheme(data:prime,bootstrap:false,
            child:MaterialApp(theme:material,home:Scaffold(body:MediaQuery(
              data:MediaQueryData(textScaler:TextScaler.linear(scale)),
              child:SingleChildScrollView(child:SizedBox(width:650,child:Builder(builder:(context){
                input=PrimeActionPalette.of(context,PrimeActionTone.values[index%PrimeActionTone.values.length]).accent;
                return actualFixture(index,input,scale==2,(value){selected=value;});
              }))),
            )))));
          await tester.pumpAndSettle();
          if(index==0 || index==6) {
            await tester.tap(find.text('Metric'));await tester.pump();expect(selected,'demo');
            if(scale==2) {
              final text=tester.widget<Text>(find.text('Metric'));
              expect(themeContrastRatio(text.style!.color!,prime.colors.primary),greaterThanOrEqualTo(4.5));
            }
          } else {
            expect(find.text('42'),findsOneWidget);
            final iconFinder=find.byWidgetPredicate((w)=>w is Icon && w.icon==Icons.show_chart);
            final icon=tester.widget<Icon>(iconFinder);
            final context=tester.element(iconFinder);
            expect(icon.color,PrimeActionPalette.onTint(context,input));
            expect(themeContrastRatio(icon.color!,PrimeActionPalette.tintSurface(context,input)),greaterThanOrEqualTo(4.5));
          }
          expect(tester.takeException(),isNull,reason:'$preset/$scale/$index');
        }
      }
    }
  });
}
