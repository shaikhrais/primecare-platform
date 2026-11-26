import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_center_catalog_generated.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'package:primecare_ui/src/theme/prime_theme_resolver.dart';
import 'auth_design_test.dart' show localized;
import 'package:primecare_ui/src/features/auth/shared_account/consent/sections/consent_consent_content_section.dart' as view0;
import 'package:primecare_ui/src/features/auth/shared_account/consent/sections/consent_header_section.dart' as view1;
import 'package:primecare_ui/src/screens/allied/rmt_dashboard/sections/rmt_dashboard_header_section.dart' as view2;
import 'package:primecare_ui/src/screens/clinical/cns_dashboard/sections/cns_dashboard_header_section.dart' as view3;
import 'package:primecare_ui/src/screens/clinical/hsw_dashboard/sections/hsw_dashboard_header_section.dart' as view4;
import 'package:primecare_ui/src/screens/clinical/lpn_dashboard/sections/lpn_dashboard_header_section.dart' as view5;
import 'package:primecare_ui/src/screens/clinical/np_dashboard/sections/np_dashboard_header_section.dart' as view6;
import 'package:primecare_ui/src/screens/clinical/pediatric_dashboard/sections/pediatric_dashboard_header_section.dart' as view7;
import 'package:primecare_ui/src/screens/clinical/physician_dashboard/sections/physician_dashboard_header_section.dart' as view8;
import 'package:primecare_ui/src/screens/common/architecture_planning_dashboard/sections/architecture_planning_dashboard_header_section.dart' as view9;
void main() {
 TestWidgetsFlutterBinding.ensureInitialized();
 setUpAll(() async {SharedPreferences.setMockInitialValues({});await EasyLocalization.ensureInitialized();});
 testWidgets('actual consent and dashboard headers retain preset and large-text rendering', (tester) async {
 tester.view.physicalSize=const Size(1400,1800);tester.view.devicePixelRatio=1;
 addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
 final widgets=<Widget>[const view0.ConsentConsentContentSection(), const view1.ConsentHeaderSection(), const view2.RmtDashboardHeaderSection(data: {}), const view3.CnsDashboardHeaderSection(data: {}), const view4.HswDashboardHeaderSection(data: {}), const view5.LpnDashboardHeaderSection(data: {}), const view6.NpDashboardHeaderSection(data: {}), const view7.PediatricDashboardHeaderSection(data: {}), const view8.PhysicianDashboardHeaderSection(data: {}), const view9.ArchitecturePlanningDashboardHeaderSection(data: {})];
 const base=PrimeThemeData();
 for(final preset in themeCenterPresetNames) {
  final profile=PersonalTheme(name:'Remaining headers',preset:preset);
  final material=applyPersonalThemeData(base.toThemeData(),profile);
  final prime=resolvePersonalPrimeTheme(base,material,profile);
  for(final scale in [1.0,2.0]) {
   for(var i=0;i<widgets.length;i++) {
    await tester.pumpWidget(ProviderScope(child:PrimeTheme(data:prime,bootstrap:false,child:localized(Scaffold(backgroundColor:prime.colors.surface,
     body:MediaQuery(data:MediaQueryData(textScaler:TextScaler.linear(scale)),child:SingleChildScrollView(child:SizedBox(width:1100,child:widgets[i]))))))));
    await tester.pumpAndSettle();expect(tester.takeException(),isNull,reason:'$preset/$scale/$i');
   }
  }
 }
 });
}
