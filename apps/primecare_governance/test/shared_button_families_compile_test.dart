import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_governance/core/ui/dev_toolbox.dart' as migrated0;
import 'package:primecare_governance/features/system_governance/app_entry_form.dart' as migrated1;
import 'package:primecare_governance/governance/widgets/governance_dashboard.dart' as migrated2;
import 'package:primecare_governance/governance/widgets/governance_filter_bar.dart' as migrated3;
import 'package:primecare_governance/governance/widgets/governance_patch_manager.dart' as migrated4;

void main() {
  test('actual migrated button consumers compile', () {
    final declarations = <Object>[
      migrated0.DevToolbox,
      migrated1.AppEntryForm,
      migrated2.GovernanceDashboard,
      migrated3.GovernanceFilterBar,
      migrated4.GovernancePatchManager
    ];
    expect(declarations, hasLength(5));
  });
}
