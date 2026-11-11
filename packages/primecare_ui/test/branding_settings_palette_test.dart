import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/features/admin/global_settings_screen.dart';
import 'package:primecare_ui/src/theme/prime_theme_resolver.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_center_catalog_generated.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'fixtures/branding_settings_fixture.dart';

void main() {
 test('actual branding consumer compiles and shared hex parser handles editing states', () {
  expect(GlobalSettingsScreen,isNotNull);
  expect(PrimeThemeColor.tryParseHex('#12aBcD'),const Color(0xFF12ABCD));
  expect(PrimeThemeColor.tryParseHex('  #8012ABCD '),const Color(0x8012ABCD));
  expect(PrimeThemeColor.tryParseHex('00000000'),const Color(0));
  expect(PrimeThemeColor.tryParseHex('FFFFFF'),const Color(0xFFFFFFFF));
  for(final value in ['', '#', '1','12345','1234567','123456789','GGGGGG','00zz00','-12345','0xFFFFFF']) {
   expect(PrimeThemeColor.tryParseHex(value),isNull,reason:value);
  }
 });
 testWidgets('actual branding helper methods preserve preset rendering, input validation and callbacks', (tester) async {
  tester.view.physicalSize=const Size(1100,1300);tester.view.devicePixelRatio=1;
  addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
  final controller=TextEditingController();addTearDown(controller.dispose);
  const base=PrimeThemeData();
  for(final preset in themeCenterPresetNames) {
   final profile=PersonalTheme(name:'Branding settings',preset:preset);
   final material=applyPersonalThemeData(base.toThemeData(),profile);
   final prime=resolvePersonalPrimeTheme(base,material,profile);
   for(final scale in [1.0,2.0]) {
    for(var mode=0;mode<3;mode++) {
     var tapped=false;
     final form=GlobalKey<FormState>();
     await tester.pumpWidget(PrimeTheme(data:prime,bootstrap:false,child:MaterialApp(theme:material,
      home:Scaffold(body:MediaQuery(data:MediaQueryData(textScaler:TextScaler.linear(scale)),
       child:SingleChildScrollView(child:SizedBox(width:650,child:Form(key:form,child:BrandingSettingsFixture(mode:mode,
        controller:controller,selected:scale==2,onTap:(){tapped=true;})))))))));
     await tester.pumpAndSettle();
     if(mode==1) {
      await tester.enterText(find.byType(TextFormField),'GGGGGG');await tester.pump();expect(form.currentState!.validate(),isFalse);
      await tester.enterText(find.byType(TextFormField),'#778899');await tester.pump();expect(form.currentState!.validate(),isTrue);
     }
     if(mode==2){await tester.tap(find.text('Layout'));expect(tapped,isTrue);}
     expect(tester.takeException(),isNull,reason:'$preset/$scale/$mode');
    }
   }
  }
 });
}
