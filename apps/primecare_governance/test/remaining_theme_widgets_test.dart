import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/theme/prime_semantic_palette.dart';
import 'package:flutter_core/theme/theme_contrast.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_center_catalog_generated.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';
import 'package:primecare_governance/governance/models/governance_report.dart';
import 'package:primecare_governance/governance/widgets/governance_master_score.dart';
import 'package:primecare_governance/governance/widgets/governance_compliance_checklist.dart';
import 'package:primecare_governance/core/ui/app_skeleton.dart';
GovernanceReport scoreReport(double value)=>GovernanceReport(totalScreens:100,totalIssues:2,criticalIssues:1,highIssues:1,mediumIssues:0,lowIssues:0,productionReadyScreens:50,blockedScreens:50,averageTestPassRate:value,renderOkPercent:value,accessibilityPercent:value,performancePercent:value,issues:[]);
void main() {
 testWidgets('actual score thresholds, badge foregrounds and compliance layouts retain every preset', (tester) async {
  tester.view.physicalSize=const Size(1500,2000);tester.view.devicePixelRatio=1;
  addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
  for(final preset in themeCenterPresetNames) {
   final material=applyPersonalThemeData(ThemeData(),PersonalTheme(name:'Score',preset:preset));
   for(final score in [0.0,49.0,50.0,74.0,75.0,89.0,90.0,100.0]) {
    await tester.pumpWidget(MaterialApp(theme:material,home:Scaffold(body:GovernanceMasterScore(report:scoreReport(score)))));
    await tester.pump();
    final actual=scoreReport(score).overallHealthScore;
    final expectedTone=actual>=90 ? PrimeSemanticTone.success:actual>=75 ? PrimeSemanticTone.primary:actual>=50 ? PrimeSemanticTone.warning:PrimeSemanticTone.error;
    final ringFinder=find.byType(CircularProgressIndicator);
    final ring=tester.widget<CircularProgressIndicator>(ringFinder);
    final context=tester.element(ringFinder);
    expect(ring.value,closeTo(actual/100,.00001));
    expect(ring.valueColor!.value,PrimeSemanticPalette.of(context,expectedTone).accent);
    final text=tester.widget<Text>(find.text('${actual.toInt()}%'));
    expect(themeContrastRatio(text.style!.color!,material.colorScheme.surface),greaterThanOrEqualTo(4.5));
    expect(tester.takeException(),isNull,reason:'$preset/$score');
   }
   for(final scale in [1.0,2.0]) {
    await tester.pumpWidget(MaterialApp(theme:material,home:Scaffold(body:MediaQuery(data:MediaQueryData(textScaler:TextScaler.linear(scale)),
     child:SingleChildScrollView(child:SizedBox(width:1000,child:GovernanceComplianceChecklist(report:scoreReport(75))))))));
    await tester.pump();expect(find.text('Platform Compliance Scorecard'),findsOneWidget);expect(tester.takeException(),isNull);
   }
  }
 });
 testWidgets('actual skeleton derives distinct shimmer shades from light and dark themes', (tester) async {
  for(final theme in [ThemeData.light(),ThemeData.dark()]) {
   await tester.pumpWidget(MaterialApp(theme:theme,home:const Scaffold(body:AppSkeleton(height:60,width:300))));
   await tester.pump(const Duration(milliseconds:10));
   final gradient=tester.widget<Shimmer>(find.byType(Shimmer)).gradient as LinearGradient;
   expect(gradient.colors.toSet().length,2);
   expect(tester.takeException(),isNull);
  }
  await tester.pumpWidget(const SizedBox());
 });
}
