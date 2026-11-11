import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_governance/core/governance/route_registry.dart' as migrated0;
import 'package:primecare_governance/core/ui/app_drawer.dart' as migrated1;
import 'package:primecare_governance/governance/widgets/governance_compliance_checklist.dart' as migrated2;
import 'package:primecare_governance/governance/widgets/governance_dashboard.dart' as migrated3;
import 'package:primecare_governance/governance/widgets/governance_filter_bar.dart' as migrated4;
import 'package:primecare_governance/governance/widgets/governance_issue_table.dart' as migrated5;
import 'package:primecare_governance/governance/widgets/governance_patch_manager.dart' as migrated6;
import 'package:primecare_governance/governance/widgets/network_parity_audit_table.dart' as migrated7;
import 'package:primecare_governance/governance/widgets/platform_discovery_viewer.dart' as migrated8;
import 'package:primecare_governance/governance/widgets/platform_readiness_viewer.dart' as migrated9;

void main() {
  test('actual shared control extension consumers compile', () {
    final declarations = <Object>[
      migrated0.governanceNativeScreenRoutes,
      migrated1.AppDrawer,
      migrated2.GovernanceComplianceChecklist,
      migrated3.GovernanceDashboard,
      migrated4.GovernanceFilterBar,
      migrated5.GovernanceIssueTable,
      migrated6.GovernancePatchManager,
      migrated7.NetworkParityAuditTable,
      migrated8.PlatformDiscoveryViewer,
      migrated9.PlatformReadinessViewer
    ];
    expect(declarations, hasLength(10));
  });
}
