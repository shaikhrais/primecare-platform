// Governance - Category: test | Purpose: Core implementation file for the Governance Ci Test platform logic.
import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_governance/core/governance/screen_registry.dart';
import 'package:primecare_governance/governance/services/screen_governance_reporter.dart';
import 'package:primecare_governance/governance/models/governance_report.dart';
import 'package:primecare_governance/core/governance/registries/core_governance_registry.dart';
import 'package:primecare_ui/primecare_ui.dart' as ui;
import 'package:primecare_governance/governance/services/production_readiness_service.dart';

void main() {
  group('Architectural Governance CI Gate', () {
    late GovernanceReport report;

    setUpAll(() {
      CoreGovernanceRegistry.registerScreens();
      ui.ScreenRegistry.bootstrap();
      report = ScreenGovernanceReporter.scan(ScreenRegistry.screens);
      final output = File('test-results/governance-readiness.json');
      output.parent.createSync(recursive: true);
      output.writeAsStringSync(const JsonEncoder.withIndent('  ').convert({
        'source': 'checked-in registry metadata; not a production database audit',
        'commit': Platform.environment['GITHUB_SHA'],
        'totalScreens': report.totalScreens,
        'catalogRecordCount': report.totalScreens + CoreGovernanceRegistry.unresolvedMetadata.length,
        'unresolvedMetadataCount': CoreGovernanceRegistry.unresolvedMetadata.length,
        'unresolvedMetadata': [for (final record in CoreGovernanceRegistry.unresolvedMetadata.values) {
          'screenId': record.id, 'reason': 'Missing title, feature, route and role metadata',
          'nextAction': 'Reconcile authoritative metadata before enabling a route; do not guess grants',
        }],
        'productionReadyScreens': report.productionReadyScreens,
        'blockedScreens': report.blockedScreens,
        'healthScore': report.overallHealthScore,
        'criticalIssues': report.criticalIssues,
        'releaseThresholds': {'criticalIssues': 0, 'minimumHealth': 80, 'minimumReadyRatio': 0.5},
        'screens': [for (final screen in ScreenRegistry.screens.values) {
          'screenId': screen.id, 'route': screen.routePath,
          'metadataReady': ProductionReadinessService.isReady(screen),
          'pendingEvidence': ProductionReadinessService.readinessBlockers(screen),
        }],
        'issues': [for (final issue in report.issues) {
          'id': issue.id, 'screenId': issue.screenId, 'title': issue.title,
          'severity': issue.severity.name, 'problem': issue.issue,
          'nextAction': issue.suggestion,
        }],
      }));
    });

    test('No Unresolved Registry Metadata', () {
      expect(CoreGovernanceRegistry.unresolvedMetadata, isEmpty,
        reason: 'Quarantined metadata must be reconciled before release; see the readiness artifact.');
    });

    test('Zero Critical Issues', () {
      expect(
        report.criticalIssues,
        0,
        reason:
            'Critical architectural violations detected. See Governance Dashboard for details.',
      );
    });

    test('Minimum Health Score Threshold (80%)', () {
      expect(
        report.overallHealthScore,
        greaterThanOrEqualTo(80.0),
        reason: 'Platform health score is below the mandatory 80% threshold.',
      );
    });

    test('Production Readiness Ratio', () {
      final ratio = report.productionReadyScreens / report.totalScreens;
      expect(
        ratio,
        greaterThanOrEqualTo(0.5),
        reason:
            'Less than 50% of screens are production-ready. Architectural debt is too high.',
      );
    });
  });
}
