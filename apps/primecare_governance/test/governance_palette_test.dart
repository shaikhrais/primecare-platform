import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_center_catalog_generated.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'package:flutter_core/theme/theme_contrast.dart';
import 'package:primecare_ui/src/theme/prime_theme_resolver.dart';
import 'package:primecare_governance/governance/models/governance_report.dart';
import 'package:primecare_governance/core/governance/governance_provider.dart';
import 'package:primecare_governance/governance/widgets/governance_domain_chart.dart';
import 'package:primecare_governance/governance/widgets/governance_event_feed.dart';
import 'package:primecare_governance/governance/widgets/governance_issue_table.dart';
import 'package:primecare_governance/governance/widgets/network_parity_audit_table.dart';
import 'package:primecare_governance/governance/widgets/governance_kpi_grid.dart';
import 'package:primecare_governance/governance/widgets/governance_filter_bar.dart';
import 'package:primecare_governance/governance/widgets/governance_dashboard.dart';
import 'governance_palette_fixture.dart';

class GovernancePaletteTranslations extends AssetLoader {
 const GovernancePaletteTranslations();
 @override Future<Map<String,dynamic>> load(String path,Locale locale) async=>jsonDecode(File('$path/${locale.languageCode}.json').readAsStringSync()) as Map<String,dynamic>;
}
GovernanceReport report({bool empty=false})=>GovernanceReport(totalScreens:20,totalIssues:empty ? 0:GovernanceCategory.values.length,criticalIssues:1,highIssues:1,mediumIssues:1,lowIssues:1,productionReadyScreens:10,blockedScreens:10,averageTestPassRate:75,renderOkPercent:80,accessibilityPercent:85,performancePercent:90,
 issues:empty ? []:[for(final category in GovernanceCategory.values) PlatformAuditIssue(id:category.name,category:category,subsystem:'fixture',registry:'fixture',issue:'Observed issue',suggestion:'Review evidence')]);
void main() {
 TestWidgetsFlutterBinding.ensureInitialized();
 setUpAll(() async {SharedPreferences.setMockInitialValues({});await EasyLocalization.ensureInitialized();});
 test('all seven actual migrated consumers compile',(){expect(<Type>[GovernanceDomainChart,GovernanceEventFeed,GovernanceIssueTable,NetworkParityAuditTable,GovernanceKPIGrid,GovernanceFilterBar,GovernanceDashboard],hasLength(7));});
 testWidgets('actual governance palettes preserve chart, KPI, event and filter behavior', (tester) async {
  tester.view.physicalSize=const Size(1600,2000);tester.view.devicePixelRatio=1;
  addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
  const base=PrimeThemeData();
  for(final preset in themeCenterPresetNames) {
   final profile=PersonalTheme(name:'Governance palette',preset:preset);
   final material=applyPersonalThemeData(base.toThemeData(),profile);
   final prime=resolvePersonalPrimeTheme(base,material,profile);
   for(final scale in [1.0,2.0]) {
    for(var mode=0;mode<7;mode++) {
     var cleared=false;AuditSeverity? selected;
     final child=switch(mode) {
      0=>GovernanceDomainChart(report:report()),
      1=>GovernanceKPIGrid(report:report()),
      2=>GovernanceEventFeed(events:[for(final level in GovernanceEventLevel.values) GovernanceEvent(type:level.name,message:'Event ${level.name}',level:level,timestamp:DateTime(2026,1,1,12))]),
      3=>GovernanceFilterBar(selectedSeverity:AuditSeverity.high,onSeverityChanged:(value){selected=value;},onCategoryChanged:(_){},onClear:(){cleared=true;}),
      4=>Column(children:[for(final severity in AuditSeverity.values) GovernanceSeverityFixture(severity)]),
      5=>GovernanceReadinessFixture(report()),
      _=>GovernanceDomainChart(report:report(empty:true)),
     };
     await tester.pumpWidget(ProviderScope(child:PrimeTheme(data:prime,bootstrap:false,
      child:EasyLocalization(supportedLocales:const[Locale('en')],path:'assets/translations',assetLoader:const GovernancePaletteTranslations(),fallbackLocale:const Locale('en'),
       child:Builder(builder:(context)=>MaterialApp(theme:material,locale:context.locale,supportedLocales:context.supportedLocales,localizationsDelegates:context.localizationDelegates,
        home:Scaffold(body:MediaQuery(data:MediaQueryData(textScaler:TextScaler.linear(scale)),child:SingleChildScrollView(child:SizedBox(width:1400,height:1500,child:child))))))))));
     await tester.pumpAndSettle();
     if(mode==0 || mode==6) {
      final data=tester.widget<PieChart>(find.byType(PieChart)).data;
      expect(data.sections,hasLength(mode==0 ? GovernanceCategory.values.length:1));
      expect(data.sections.fold<double>(0,(sum,s)=>sum+s.value),mode==0 ? GovernanceCategory.values.length.toDouble():1.0);
      for(final section in data.sections) {expect(themeContrastRatio(section.titleStyle!.color!,section.color),greaterThanOrEqualTo(4.5));}
     }
     if(mode==1){expect(find.text('Total Screens'),findsOneWidget);expect(find.text('20'),findsOneWidget);}
     if(mode==2){for(final level in GovernanceEventLevel.values){expect(find.text('Event ${level.name}'),findsOneWidget);}}
     if(mode==3) {
      await tester.tap(find.byIcon(Icons.clear_all_rounded));expect(cleared,isTrue);
      await tester.tap(find.byWidgetPredicate((w)=>w is PopupMenuButton<AuditSeverity?>));await tester.pumpAndSettle();
      await tester.tap(find.text('CRITICAL'));await tester.pumpAndSettle();expect(selected,AuditSeverity.critical);
     }
     if(mode==4){
      for(final severity in AuditSeverity.values) {
       final root=find.byWidgetPredicate((w)=>w is GovernanceSeverityFixture && w.severity==severity);
       final text=tester.widget<Text>(find.descendant(of:root,matching:find.byType(Text)));
       final container=tester.widget<Container>(find.descendant(of:root,matching:find.byType(Container)));
       expect(text.data,severity.name.toUpperCase());
       expect(themeContrastRatio(text.style!.color!,(container.decoration! as BoxDecoration).color!),greaterThanOrEqualTo(4.5));
      }
     }
     if(mode==5){final text=tester.widget<Text>(find.text('Production Readiness Status'));expect(themeContrastRatio(text.style!.color!,prime.colors.primary),greaterThanOrEqualTo(4.5));}
     expect(tester.takeException(),isNull,reason:'$preset/$scale/$mode');
    }
   }
  }
 });
}
