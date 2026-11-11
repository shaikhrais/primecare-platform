import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_governance/core/ui/app_components.dart' as view0;
import 'package:primecare_governance/core/ui/app_drawer.dart' as view1;
import 'package:primecare_governance/core/ui/dev_toolbox.dart' as view2;
import 'package:primecare_governance/core/ui/language_selector.dart' as view3;
import 'package:primecare_governance/features/system_governance/app_entry_form.dart' as view4;
import 'package:primecare_governance/governance/widgets/governance_dashboard.dart' as view5;
import 'package:primecare_governance/governance/widgets/governance_filter_bar.dart' as view6;
import 'package:primecare_governance/governance/widgets/governance_issue_table.dart' as view7;
import 'package:primecare_governance/governance/widgets/network_parity_audit_table.dart' as view8;
import 'package:primecare_governance/governance/widgets/platform_discovery_viewer.dart' as view9;
import 'package:primecare_governance/governance/widgets/platform_readiness_viewer.dart' as view10;

void main() { test('all reviewed shared-control consumers compile', () {
 expect(<Type>[view0.AppButton, view1.AppDrawer, view2.DevToolbox, view3.LanguageSelector, view4.AppEntryForm, view5.GovernanceDashboard, view6.GovernanceFilterBar, view7.GovernanceIssueTable, view8.NetworkParityAuditTable, view9.PlatformDiscoveryViewer, view10.PlatformReadinessViewer],hasLength(11));
 }); }
