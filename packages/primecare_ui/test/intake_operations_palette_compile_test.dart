import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/src/features/generated_screens/intake_pipeline.dart' as view0;
import 'package:primecare_ui/src/features/generated_screens/pending_assessments.dart' as view1;
import 'package:primecare_ui/src/features/generated_screens/compliance_status.dart' as view2;
import 'package:primecare_ui/src/features/generated_screens/family_home.dart' as view3;
import 'package:primecare_ui/src/features/generated_screens/platform_usage.dart' as view4;
import 'package:primecare_ui/src/features/generated_screens/compliance_hub.dart' as view5;
import 'package:primecare_ui/src/features/generated_screens/incident_reviews.dart' as view6;
import 'package:primecare_ui/src/features/generated_screens/marketing_hub.dart' as view7;
import 'package:primecare_ui/src/features/generated_screens/operations_board.dart' as view8;

void main() {
 test('all nine actual palette consumers compile', () {
  expect(<Type>[view0.IntakePipeline, view1.PendingAssessments, view2.ComplianceStatus, view3.FamilyHome, view4.PlatformUsage, view5.ComplianceHub, view6.IncidentReviews, view7.MarketingHub, view8.OperationsBoard],hasLength(9));
 });
}
