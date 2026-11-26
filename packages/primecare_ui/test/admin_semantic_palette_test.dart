import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/theme/prime_theme_resolver.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_center_catalog_generated.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'package:flutter_core/theme/theme_contrast.dart';
import 'fixtures/admin_semantic_palette_fixture.dart';

void main() {
  testWidgets('exact administrative status helpers follow every palette and readable pair', (tester) async {
    const base=PrimeThemeData();
    const statuses=['CLEAR_PURPOSE','UNCLEAR_PURPOSE','DUPLICATE_PURPOSE','NO_USER_VALUE','UNKNOWN'];
    const tones=[PrimeActionTone.success,PrimeActionTone.warning,PrimeActionTone.secondary,
      PrimeActionTone.error,PrimeActionTone.error];
    for (final preset in themeCenterPresetNames) {
      final profile=PersonalTheme(name:'Diagnostic palette',preset:preset);
      final material=applyPersonalThemeData(base.toThemeData(),profile);
      final prime=resolvePersonalPrimeTheme(base,material,profile);
      for (final scale in [1.0,2.0]) {
        await tester.pumpWidget(PrimeTheme(data:prime,bootstrap:false,
          child:MaterialApp(theme:material,home:Scaffold(body:MediaQuery(
            data:MediaQueryData(textScaler:TextScaler.linear(scale)),
            child:SingleChildScrollView(child:Column(children:[
              for(var i=0;i<statuses.length;i++) PurposePaletteFixture(statuses[i],key:ValueKey('purpose-$i')),
              const HealthPaletteFixture(true,key:ValueKey('health-ready')),
              const HealthPaletteFixture(false,key:ValueKey('health-pending')),
            ])),
          )))));
        await tester.pumpAndSettle();
        for(var i=0;i<7;i++) {
          final key=i<5 ? 'purpose-$i' : i==5 ? 'health-ready':'health-pending';
          final root=find.byKey(ValueKey(key));
          final palette=PrimeActionPalette.of(tester.element(root),i<5 ? tones[i] : i==5 ? PrimeActionTone.success:PrimeActionTone.warning);
          final box=tester.widget<Container>(find.descendant(of:root,matching:find.byType(Container)).first);
          final text=tester.widget<Text>(find.descendant(of:root,matching:find.byType(Text)));
          final decoration=box.decoration! as BoxDecoration;
          expect(decoration.color,palette.surface,reason:'$preset/$key');
          expect(text.style!.color,palette.onSurface,reason:'$preset/$key');
          expect((decoration.border! as Border).top.color,palette.border);
          expect(themeContrastRatio(text.style!.color!,decoration.color!),greaterThanOrEqualTo(4.5));
          expect(box.padding,i<5 ? const EdgeInsets.symmetric(horizontal:8,vertical:2):const EdgeInsets.symmetric(horizontal:10,vertical:4));
        }
        expect(find.text('PRODUCTION'),findsOneWidget);
        expect(find.text('DEVELOPMENT'),findsOneWidget);
        expect(find.text('UNKNOWN'),findsOneWidget);
        expect(tester.takeException(),isNull,reason:'$preset/$scale');
      }
    }
  });
}
