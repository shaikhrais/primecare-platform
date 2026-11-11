import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/src/features/generated_screens/campaign_analytics.dart' as view0;
import 'package:primecare_ui/src/features/generated_screens/cases.dart' as view1;
import 'package:primecare_ui/src/features/generated_screens/enterprise_overview.dart' as view2;
import 'package:primecare_ui/src/features/generated_screens/strategic_kpis.dart' as view3;
import 'package:primecare_ui/src/features/generated_screens/audit_logs.dart' as view4;
import 'package:primecare_ui/src/features/generated_screens/policy_manager.dart' as view5;

void main() {
 test('all six actual palette consumers compile', () {
  expect(<Type>[view0.CampaignAnalytics, view1.Cases, view2.EnterpriseOverview, view3.StrategicKpis, view4.AuditLogs, view5.PolicyManager],hasLength(6));
 });
}
