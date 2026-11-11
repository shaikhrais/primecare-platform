import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_governance/core/ui/app_components.dart' as view0;
import 'package:primecare_governance/core/ui/app_drawer.dart' as view1;
import 'package:primecare_governance/core/ui/app_skeleton.dart' as view2;
import 'package:primecare_governance/core/ui/dev_toolbox.dart' as view3;
import 'package:primecare_governance/features/system_governance/app_entry_form.dart' as view4;
import 'package:primecare_governance/governance/widgets/governance_compliance_checklist.dart' as view5;
import 'package:primecare_governance/governance/widgets/governance_master_score.dart' as view6;
import 'package:primecare_governance/governance/widgets/governance_patch_manager.dart' as view7;
import 'package:primecare_governance/governance/widgets/governance_trend_chart.dart' as view8;

void main() { test('all reviewed remaining theme consumers compile', () {
 expect(<Type>[view0.AppButton, view1.AppDrawer, view2.AppSkeleton, view3.DevToolbox, view4.AppEntryForm, view5.GovernanceComplianceChecklist, view6.GovernanceMasterScore, view7.GovernancePatchManager, view8.GovernanceTrendChart],hasLength(9));
 }); }
