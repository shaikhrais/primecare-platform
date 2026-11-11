// Compile smoke coverage for constructor-only shared text migration.
// This does not claim individual screen runtime acceptance.
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_governance/core/ui/dynamic_screen_view.dart' as migrated0;
import 'package:primecare_governance/core/ui/state_widgets.dart' as migrated1;
import 'package:primecare_governance/features/audit/screens/audit_log_screen.dart' as migrated2;
import 'package:primecare_governance/features/audit/screens/monitoring_screen.dart' as migrated3;
import 'package:primecare_governance/features/audit/screens/screen_status_screen.dart' as migrated4;
import 'package:primecare_governance/features/audit/screens/ticket_center_screen.dart' as migrated5;
import 'package:primecare_governance/features/executive/screens/control_center_screen.dart' as migrated6;
import 'package:primecare_governance/features/executive/screens/governance_hud_screen.dart' as migrated7;
import 'package:primecare_governance/features/executive/screens/growth_pipeline_screen.dart' as migrated8;
import 'package:primecare_governance/features/executive/screens/leadership_reports_screen.dart' as migrated9;
import 'package:primecare_governance/features/executive/screens/proposals_screen.dart' as migrated10;
import 'package:primecare_governance/features/executive/screens/regional_performance_screen.dart' as migrated11;
import 'package:primecare_governance/features/qa/screens/audit_dashboard_screen.dart' as migrated12;
import 'package:primecare_governance/features/qa/screens/compliance_reviews_screen.dart' as migrated13;
import 'package:primecare_governance/features/qa/screens/incident_reports_screen.dart' as migrated14;
import 'package:primecare_governance/features/qa/screens/quality_metrics_screen.dart' as migrated15;
import 'package:primecare_governance/features/reference/screens/clinical_reference_screen.dart' as migrated16;
import 'package:primecare_governance/features/security/screens/security_hub_screen.dart' as migrated17;
import 'package:primecare_governance/features/security/screens/security_sentinel_screen.dart' as migrated18;
import 'package:primecare_governance/features/security/screens/verification_center_screen.dart' as migrated19;
import 'package:primecare_governance/governance/widgets/governance_kpi_grid.dart' as migrated20;

void main() {
  test('migrated consumer libraries compile', () {
    const migratedTypes = <Type>[
    migrated0.AuditSandboxScreenState,
    migrated1.NoAccessScreenState,
    migrated2.AuditLogScreenState,
    migrated3.MonitoringScreenState,
    migrated4.ScreenStatusScreenState,
    migrated5.TicketCenterScreenState,
    migrated6.ControlCenterScreenState,
    migrated7.GovernanceHudScreenState,
    migrated8.GrowthPipelineScreenState,
    migrated9.LeadershipReportsScreenState,
    migrated10.ProposalsScreenState,
    migrated11.RegionalPerformanceScreenState,
    migrated12.AuditDashboardScreenState,
    migrated13.ComplianceReviewsScreenState,
    migrated14.IncidentReportsScreenState,
    migrated15.QualityMetricsScreenState,
    migrated16.ClinicalReferenceScreenState,
    migrated17.SecurityHubScreenState,
    migrated18.SecuritySentinelScreenState,
    migrated19.VerificationCenterScreenState,
    migrated20.GovernanceKPIGrid,
    ];
    expect(migratedTypes, hasLength(21));
  });
}
