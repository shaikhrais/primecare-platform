import '../models/governance_issue.dart';
import '../models/governance_report.dart';
import '../models/governance_severity.dart';

import 'registry_integrity_service.dart';
import 'route_audit_service.dart';
import 'rbac_audit_service.dart';
import 'lifecycle_audit_service.dart';
import 'component_audit_service.dart';
import 'test_quality_audit_service.dart';
import 'production_readiness_service.dart';
import 'security_audit_service.dart';
import '../../core/governance/screen_registry.dart';

class ScreenGovernanceReporter {
  static GovernanceReport generateReport() {
    return scan(ScreenRegistry.screens);
  }

  static GovernanceReport scan(Map<String, ScreenMetadata> screens) {
    final issues = <GovernanceIssue>[];

    // 1. Structural Registry Audit
    issues.addAll(RegistryIntegrityService.inspect(screens));

    // 2. Individual Screen Content Audit
    for (final s in screens.values) {
      issues.addAll(RouteAuditService.scan(s));
      issues.addAll(RbacAuditService.scan(s));
      issues.addAll(LifecycleAuditService.scan(s));
      issues.addAll(ComponentAuditService.scan(s));
      issues.addAll(TestQualityAuditService.scan(s));
      issues.addAll(ProductionReadinessService.scan(s));
      issues.addAll(SecurityAuditService.scan(s));
    }

    final total = screens.length;
    final productionReady = screens.values
        .where(ProductionReadinessService.isReady)
        .length;
    final blocked = screens.values
        .where((s) => !ProductionReadinessService.isReady(s))
        .length;

    final avgTest = total == 0
        ? 0.0
        : screens.values.map((s) => s.testPassRate).reduce((a, b) => a + b) /
              total;

    final renderOk = _percent(
      screens.values.where((s) => s.isRenderOk).length,
      total,
    );

    final accessOk = _percent(
      screens.values.where((s) => s.isAccessibilityVerified).length,
      total,
    );

    final performanceOk = _percent(
      screens.values.where((s) => s.isPerformanceVerified).length,
      total,
    );

    return GovernanceReport(
      totalScreens: total,
      totalIssues: issues.length,
      criticalIssues: _count(issues, GovernanceSeverity.critical),
      highIssues: _count(issues, GovernanceSeverity.high),
      mediumIssues: _count(issues, GovernanceSeverity.medium),
      lowIssues: _count(issues, GovernanceSeverity.low),
      productionReadyScreens: productionReady,
      blockedScreens: blocked,
      averageTestPassRate: avgTest,
      renderOkPercent: renderOk,
      accessibilityPercent: accessOk,
      performancePercent: performanceOk,
      issues: issues,
    );
  }

  static int _count(List<GovernanceIssue> issues, GovernanceSeverity severity) {
    return issues.where((i) => i.severity == severity).length;
  }

  static double _percent(int value, int total) {
    if (total == 0) return 0.0;
    return (value / total) * 100;
  }
}
