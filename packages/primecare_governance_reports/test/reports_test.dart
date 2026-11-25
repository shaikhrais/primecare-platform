import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_governance_reports/primecare_governance_reports.dart';
void main() {
  test('report model preserves exact issue details', () {
    final bug = BugGovernance(bugId: 'one', issue: 'fixture', severity: 'Low', impact: 'none', suggestedFix: 'review');
    expect(bug.toJson()['issue'], 'fixture');
    expect(bug.toJson()['severity'], 'Low');
  });
}
