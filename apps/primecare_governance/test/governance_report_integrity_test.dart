import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_governance/governance/services/screen_governance_reporter.dart';
import 'package:primecare_governance/governance/services/test_quality_audit_service.dart';

void main() {
  const fixture = ScreenMetadata(id: 'REPORT_FIXTURE', title: 'Fixture',
    route: '/fixture', roles: ['fixture'], testPassRate: 100);

  test('invalid percentages remain visible without corrupting JSON or health', () {
    for (final value in [double.nan, double.infinity, double.negativeInfinity, -1.0, 101.0]) {
      final screen = fixture.copyWith(testPassRate: value);
      final report = ScreenGovernanceReporter.scan({screen.id: screen});
      expect(report.averageTestPassRate, 0);
      expect(report.overallHealthScore.isFinite, isTrue);
      expect(report.productionReadyScreens, 0);
      final finding = report.issues.singleWhere((issue) =>
        issue.id == 'test_invalid_pass_rate_${screen.id}');
      expect(finding.autoRemediable, isFalse);
      expect(() => jsonEncode({'healthScore': report.overallHealthScore,
        'metadata': finding.metadata}), returnsNormally);
    }
  });

  test('invalid evidence is retained in the average denominator', () {
    final invalid = fixture.copyWith(id: 'INVALID_FIXTURE', testPassRate: double.nan);
    final report = ScreenGovernanceReporter.scan({fixture.id: fixture, invalid.id: invalid});
    expect(report.averageTestPassRate, 50);
  });

  test('valid percentages retain their exact score and ordinary low-rate findings', () {
    for (final value in [0.0, 89.5, 90.0, 100.0]) {
      final screen = fixture.copyWith(testPassRate: value);
      final report = ScreenGovernanceReporter.scan({screen.id: screen});
      expect(report.averageTestPassRate, value);
      expect(TestQualityAuditService.scan(screen).any((issue) =>
        issue.id == 'test_low_pass_rate_${screen.id}'), value < 90);
      expect(report.issues.any((issue) =>
        issue.id == 'test_invalid_pass_rate_${screen.id}'), isFalse);
    }
  });
}
