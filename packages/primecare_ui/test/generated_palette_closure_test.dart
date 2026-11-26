import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/theme/prime_theme_resolver.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_center_catalog_generated.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'package:flutter_core/theme/theme_contrast.dart';
import 'fixtures/generated_palette_closure_fixture.dart';

void main() {
  testWidgets('actual analytics metric icon preserves contrast across presets and text scales', (tester) async {
    tester.view.physicalSize=const Size(1000,1200);tester.view.devicePixelRatio=1;
    addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
    const base=PrimeThemeData();
    for(final preset in themeCenterPresetNames) {
      final profile=PersonalTheme(name:'Generated palette closure',preset:preset);
      final material=applyPersonalThemeData(base.toThemeData(),profile);
      final prime=resolvePersonalPrimeTheme(base,material,profile);
      for(final scale in [1.0,2.0]) {
        for(final tone in PrimeActionTone.values) {
          late Color input;
          await tester.pumpWidget(PrimeTheme(data:prime,bootstrap:false,
            child:MaterialApp(theme:material,home:Scaffold(body:MediaQuery(
              data:MediaQueryData(textScaler:TextScaler.linear(scale)),
              child:SingleChildScrollView(child:SizedBox(width:650,child:Builder(builder:(context){
                input=PrimeActionPalette.of(context,tone).accent;
                return OperationsPaletteFixture0(title:'Metric',value:'42',subtitle:'Existing metric',icon:Icons.show_chart,iconColor:input);
              }))),
            )))));
          await tester.pumpAndSettle();
          expect(find.text('42'),findsOneWidget);
          final iconFinder=find.byWidgetPredicate((w)=>w is Icon && w.icon==Icons.show_chart);
          final icon=tester.widget<Icon>(iconFinder);
          final context=tester.element(iconFinder);
          expect(icon.color,PrimeActionPalette.onTint(context,input));
          expect(themeContrastRatio(icon.color!,PrimeActionPalette.tintSurface(context,input)),greaterThanOrEqualTo(4.5));
          expect(tester.takeException(),isNull,reason:'$preset/$scale/$tone');
        }
      }
    }
  });
}
