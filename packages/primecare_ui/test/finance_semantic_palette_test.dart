import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/theme/prime_theme_resolver.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_center_catalog_generated.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'package:flutter_core/theme/theme_contrast.dart';
import 'fixtures/finance_semantic_palette_fixture.dart';

Widget actualFixture(int index,Color color,bool active,ValueChanged<String> selected) => switch(index) {
  0=>FinancePaletteFixture0(title:'Metric',value:'42',icon:Icons.show_chart,iconColor:color),
  1=>FinancePaletteFixture1(title:'Metric',value:'42',icon:Icons.show_chart,iconColor:color),
  2=>FinancePaletteFixture2(title:'Metric',value:'42',icon:Icons.show_chart,color:color),
  3=>FinancePaletteFixture3(label:'Metric',value:'demo',activeFilter:active ? 'demo':'all',onTap:selected),
  4=>FinancePaletteFixture4(title:'Metric',value:'42',icon:Icons.show_chart,color:color),
  5=>FinancePaletteFixture5(title:'Metric',value:'42',icon:Icons.show_chart,iconColor:color),
  6=>FinancePaletteFixture6(title:'Metric',value:'42',subtitle:'Existing metric',icon:Icons.show_chart,color:color),
  7=>FinancePaletteFixture7(title:'Metric',value:'42',icon:Icons.show_chart,color:color),
  8=>TaxLedgerPaletteFixture({'status':active ? 'pending':'settled'}),
  9=>FinancePaletteFixture9(title:'Metric',value:'42',icon:Icons.show_chart,iconColor:color),
  10=>FinancePaletteFixture10(title:'Metric',value:'42',icon:Icons.show_chart,color:color),
  _=>FinancePaletteFixture11(title:'Metric',value:'42',icon:Icons.show_chart,iconColor:color),
};

void main() {
  testWidgets('shared variable tints stay readable on custom and preset surfaces', (tester) async {
    final colors=<PrimeColors>[
      const PrimeColors(),
      const PrimeColors(surface:Color(0xFF777777),primary:Colors.cyan,success:Colors.yellow,error:Colors.pink),
      const PrimeColors(surface:Colors.black,primary:Colors.yellow,success:Colors.cyan),
    ];
    for(final value in colors) {
      for(final tone in PrimeActionTone.values) {
        await tester.pumpWidget(PrimeTheme(data:PrimeThemeData(colors:value),bootstrap:false,
          child:MaterialApp(home:Builder(builder:(context){
            final foreground=PrimeActionPalette.of(context,tone).onBase;
            final tint=PrimeActionPalette.tintSurface(context,foreground);
            final readable=PrimeActionPalette.onTint(context,foreground);
            expect(themeContrastRatio(readable,tint),greaterThanOrEqualTo(4.5));
            return Container(color:tint,child:Text('Status',style:TextStyle(color:readable)));
          }))));
        expect(tester.takeException(),isNull);
      }
    }
  });

  testWidgets('actual finance cards, filter callbacks and ledger chip retain theme behavior', (tester) async {
    tester.view.physicalSize=const Size(1000,1200);tester.view.devicePixelRatio=1;
    addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
    const base=PrimeThemeData();
    for(final preset in themeCenterPresetNames) {
      final profile=PersonalTheme(name:'Finance palette',preset:preset);
      final material=applyPersonalThemeData(base.toThemeData(),profile);
      final prime=resolvePersonalPrimeTheme(base,material,profile);
      for(final scale in [1.0,2.0]) {
        for(var index=0;index<12;index++) {
          String? selected;
          late Color input;
          await tester.pumpWidget(PrimeTheme(data:prime,bootstrap:false,
            child:MaterialApp(theme:material,home:Scaffold(body:MediaQuery(
              data:MediaQueryData(textScaler:TextScaler.linear(scale)),
              child:SingleChildScrollView(child:SizedBox(width:650,child:Builder(builder:(context){
                input=PrimeActionPalette.of(context,PrimeActionTone.values[index%PrimeActionTone.values.length]).onBase;
                return actualFixture(index,input,scale==2,(value){selected=value;});
              }))),
            )))));
          await tester.pumpAndSettle();
          if(index==3) {
            expect(find.text('Metric'),findsOneWidget);
            await tester.tap(find.byType(FinancePaletteFixture3));await tester.pump();
            expect(selected,'demo');
          } else if(index==8) {
            final root=find.byType(TaxLedgerPaletteFixture);
            final text=tester.widget<Text>(find.descendant(of:root,matching:find.byType(Text)));
            final box=tester.widget<Container>(find.descendant(of:root,matching:find.byType(Container)));
            final decoration=box.decoration! as BoxDecoration;
            expect(text.data,scale==2 ? 'Pending Filing':'Settled');
            expect(themeContrastRatio(text.style!.color!,decoration.color!),greaterThanOrEqualTo(4.5));
          } else {
            expect(find.text('42'),findsOneWidget);
            final icon=tester.widget<Icon>(find.byWidgetPredicate((w)=>w is Icon && w.icon==Icons.show_chart));
            final context=tester.element(find.byWidgetPredicate((w)=>w is Icon && w.icon==Icons.show_chart));
            expect(icon.color,PrimeActionPalette.onTint(context,input));
          }
          expect(tester.takeException(),isNull,reason:'$preset/$scale/$index');
        }
      }
    }
  });
}
