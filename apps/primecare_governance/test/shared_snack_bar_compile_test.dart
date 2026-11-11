import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_governance/governance/widgets/governance_patch_manager.dart';
import 'package:primecare_governance/governance/widgets/governance_issue_table.dart';
import 'package:primecare_governance/governance/widgets/governance_dashboard.dart';
import 'package:primecare_governance/features/system_governance/app_entry_form.dart';

void main(){
  test('all migrated governance snack-bar consumers compile',(){
    expect(<Type>[GovernancePatchManager,GovernanceIssueTable,GovernanceDashboard,AppEntryForm],hasLength(4));
  });
}
