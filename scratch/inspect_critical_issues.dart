import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_governance/core/governance/screen_registry.dart';
import 'package:primecare_governance/governance/services/screen_governance_reporter.dart';
import 'package:primecare_governance/core/governance/registries/core_governance_registry.dart';
import 'package:primecare_ui/primecare_ui.dart' as ui;

void main() {
  test('inspect issues', () {
    CoreGovernanceRegistry.registerScreens();
    ui.ScreenRegistry.bootstrap();
    final report = ScreenGovernanceReporter.scan(ScreenRegistry.screens);
    
    print('Total issues: ' + report.totalIssues.toString());
    print('Critical issues: ' + report.criticalIssues.toString());
    print('High issues: ' + report.highIssues.toString());
    print('Medium issues: ' + report.mediumIssues.toString());
    print('Low issues: ' + report.lowIssues.toString());
    
    print('\n--- CRITICAL ISSUES ---');
    for (final issue in report.issues.where((i) => i.severity == AuditSeverity.critical)) {
      print('ID: ' + issue.id);
      print('Title: ' + issue.title);
      print('ScreenId: ' + issue.screenId);
      print('Issue: ' + issue.issue);
      print('Suggestion: ' + issue.suggestion);
      print('-----------------------');
    }
  });
}
