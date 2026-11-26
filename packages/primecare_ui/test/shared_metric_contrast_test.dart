import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/theme/prime_theme_resolver.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_center_catalog_generated.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'package:flutter_core/theme/theme_contrast.dart';

void main() {
  testWidgets('actual shared metric cards pair caller accents with their painted theme surfaces', (tester) async {
    tester.view.physicalSize=const Size(1200,1400);tester.view.devicePixelRatio=1;
    addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
    const base=PrimeThemeData();
    for(final preset in themeCenterPresetNames) {
      final profile=PersonalTheme(name:'Shared metrics',preset:preset);
      final material=applyPersonalThemeData(base.toThemeData(),profile);
      final prime=resolvePersonalPrimeTheme(base,material,profile);
      for(final scale in [1.0,2.0]) {
        for(final governance in [false,true]) {
          const accent=Color(0xFF777777);
          await tester.pumpWidget(PrimeTheme(data:prime,bootstrap:false,
            child:MaterialApp(theme:material,home:Scaffold(body:MediaQuery(
              data:MediaQueryData(textScaler:TextScaler.linear(scale)),
              child:SingleChildScrollView(child:SizedBox(width:700,height:500,child:governance
                ? const GovMetricCard(title:'Metric',value:'42',trendLabel:'Stable',progress:.75,icon:Icons.show_chart,brandColor:accent)
                : const PrimeCareStatCard(title:'Metric',value:'42',deltaSuffix:'+2%',icon:Icons.show_chart,iconColor:accent))),
            )))));
          await tester.pumpAndSettle();
          final iconFinder=find.byWidgetPredicate((w)=>w is Icon && w.icon==Icons.show_chart);
          final icon=tester.widget<Icon>(iconFinder);
          final context=tester.element(iconFinder);
          final alpha=governance ? .08:.1;
          final backgrounds=tester.widgetList<Container>(find.byType(Container)).where((w)=>w.decoration is BoxDecoration)
              .map((w)=>(w.decoration! as BoxDecoration).color).whereType<Color>().toList();
          final tint=PrimeActionPalette.tintSurface(context,accent,alpha:alpha);
          expect(backgrounds,contains(tint));
          expect(icon.color,PrimeActionPalette.onTint(context,accent,alpha:alpha));
          expect(themeContrastRatio(icon.color!,tint),greaterThanOrEqualTo(4.5));
          final text=tester.widget<Text>(find.text(governance ? '75%':'+2%'));
          expect(themeContrastRatio(text.style!.color!,prime.colors.surface),greaterThanOrEqualTo(4.5));
          expect(find.text('42'),findsOneWidget);
          expect(tester.takeException(),isNull,reason:'$preset/$scale/$governance');
        }
      }
    }
  });
}
