// ignore_for_file: avoid_print
import 'package:primecare_governance/governance/models/governance_report.dart';
import 'package:primecare_governance/governance/services/governance_exporter.dart';

void main() async {
  final dummyReport = GovernanceReport(
        totalScreens: 1,
        totalIssues: 0,
        criticalIssues: 0,
        highIssues: 0,
        mediumIssues: 0,
        lowIssues: 0,
        productionReadyScreens: 1,
        blockedScreens: 0,
        averageTestPassRate: 100.0,
        renderOkPercent: 100.0,
        accessibilityPercent: 100.0,
        performancePercent: 100.0,
        issues: [],
      );
  try {
    await GovernanceExporter.toPdf(dummyReport);
    print("SUCCESS");
  } catch (e, stack) {
    print("ERROR: $e\n$stack");
  }
}
