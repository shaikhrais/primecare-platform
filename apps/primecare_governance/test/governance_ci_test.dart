import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_governance/core/governance/screen_registry.dart';
import 'package:primecare_governance/governance/services/screen_governance_reporter.dart';

void main() {
  group('Architectural Governance CI Gate', () {
    final report = ScreenGovernanceReporter.scan(ScreenRegistry.screens);

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
