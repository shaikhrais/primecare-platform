import 'governance_issue.dart';

class GovernanceReport {
  final int totalScreens;
  final int totalIssues;
  final int criticalIssues;
  final int highIssues;
  final int mediumIssues;
  final int lowIssues;
  final int productionReadyScreens;
  final int blockedScreens;
  final double averageTestPassRate;
  final double renderOkPercent;
  final double accessibilityPercent;
  final double performancePercent;
  final List<GovernanceIssue> issues;

  const GovernanceReport({
    required this.totalScreens,
    required this.totalIssues,
    required this.criticalIssues,
    required this.highIssues,
    required this.mediumIssues,
    required this.lowIssues,
    required this.productionReadyScreens,
    required this.blockedScreens,
    required this.averageTestPassRate,
    required this.renderOkPercent,
    required this.accessibilityPercent,
    required this.performancePercent,
    required this.issues,
  });

  double get overallHealthScore {
    // Weighted average of core metrics
    return (renderOkPercent * 0.3) +
        (accessibilityPercent * 0.2) +
        (performancePercent * 0.2) +
        (averageTestPassRate * 0.3);
  }
}
