import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/features/auth/shared_account/success_profile/sections/success_profile_action_bar_section.dart';
import 'package:primecare_ui/src/features/auth/shared_account/success_profile/sections/success_profile_identity_summary_section.dart';
import 'package:primecare_ui/src/features/auth/shared_account/success_profile/sections/success_profile_header_section.dart';
import 'package:primecare_ui/src/features/auth/shared_account/success_profile/sections/success_profile_details_form_section.dart';
import 'package:primecare_ui/src/theme/prime_theme_resolver.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_center_catalog_generated.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'package:flutter_core/theme/theme_contrast.dart';
import 'auth_design_test.dart' show localized;

class ProfilePaletteAuth extends AuthNotifier {
 ProfilePaletteAuth(this.role);
 final String role;
 int signouts=0;
 @override AuthState build()=>AuthState(isInitialized:true,isAuthenticated:true,userName:'Test Person',role:role);
 @override Future<void> logout() async {signouts++;}
}
void main() {
 TestWidgetsFlutterBinding.ensureInitialized();
 setUpAll(() async {SharedPreferences.setMockInitialValues({});await EasyLocalization.ensureInitialized();});
 test('portal mappings retain existing role policy', () {
  const section=SuccessProfileActionBarSection();
  expect(section.getPortalUrlForRole('client'),'https://primecare-client.pages.dev');
  expect(section.getPortalUrlForRole('governance'),'https://primecare-governance.pages.dev');
  expect(section.getPortalUrlForRole('unknown'),'/login');
 });
 testWidgets('all four actual sections retain theme, access gating and logout behavior', (tester) async {
  tester.view.physicalSize=const Size(1800,2000);tester.view.devicePixelRatio=1;
  addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
  const base=PrimeThemeData();
  for(final preset in themeCenterPresetNames) {
   final profile=PersonalTheme(name:'Success profile',preset:preset);
   final material=applyPersonalThemeData(base.toThemeData(),profile);
   final prime=resolvePersonalPrimeTheme(base,material,profile);
   for(final scale in [1.0,2.0]) {
    for(final role in ['admin','client']) {
     for(var index=0;index<4;index++) {
      final auth=ProfilePaletteAuth(role);
      final child=switch(index) {
       0=>const SuccessProfileActionBarSection(),
       1=>const SuccessProfileIdentitySummarySection(),
       2=>const SuccessProfileHeaderSection(),
       _=>const SuccessProfileDetailsFormSection(),
      };
      await tester.pumpWidget(ProviderScope(key:ValueKey('$preset/$scale/$role/$index'),overrides:[authProvider.overrideWith(()=>auth)],
       child:PrimeTheme(data:prime,bootstrap:false,child:localized(Scaffold(backgroundColor:prime.colors.surface,
        body:MediaQuery(data:MediaQueryData(textScaler:TextScaler.linear(scale)),child:SingleChildScrollView(child:SizedBox(width:1600,child:child))))))));
      await tester.pumpAndSettle();
      if(index==0) {
       final tiles=tester.widgetList<InkWell>(find.byType(InkWell)).toList();
       expect(tiles,hasLength(8));
       expect(tiles.where((w)=>w.onTap!=null),hasLength(role=='admin' ? 8:1));
       expect(find.byIcon(LucideIcons.lock),findsNWidgets(role=='admin' ? 0:7));
      }
      if(index==1) {
       expect(find.text('Test Person'),findsOneWidget);
       await tester.tap(find.byIcon(LucideIcons.logOut));await tester.pump();expect(auth.signouts,1);
      }
      if(index==2) {
       final text=tester.widget<Text>(find.text('Application Hub'));
       expect(themeContrastRatio(text.style!.color!,prime.colors.surface),greaterThanOrEqualTo(4.5));
       final icon=tester.widget<Icon>(find.byIcon(LucideIcons.shieldCheck));
       final context=tester.element(find.byIcon(LucideIcons.shieldCheck));
       expect(themeContrastRatio(icon.color!,PrimeActionPalette.of(context,PrimeActionTone.primary).accent),greaterThanOrEqualTo(4.5));
      }
      expect(tester.takeException(),isNull,reason:'$preset/$scale/$role/$index');
     }
    }
   }
  }
 });
}
