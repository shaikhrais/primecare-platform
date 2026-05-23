// Governance - Category: service | Purpose: Core implementation file for the Run Audit platform logic.
import 'package:primecare_governance/governance/services/cross_subsystem_auditor.dart';

void main() async {
  print('--- Starting Cross-Subsystem Audit ---');
  final auditor = CrossSubsystemAuditor(projectRoot: '../..');

  print('Auditing Form Provider Parity...');
  final issues = await auditor.auditFormProviderParity();

  if (issues.isEmpty) {
    print('✅ No parity issues found.');
  } else {
    print('❌ Found ${issues.length} issues:');
    for (var i = 0; i < issues.length; i++) {
      final issue = issues[i];
      print('${i + 1}. [${issue.subsystem}] ${issue.registry}: ${issue.issue}');
      print('   Suggestion: ${issue.suggestion}');
      if (issue.autoRemediable) {
        print('   Auto-Remediable: Yes');
      }
    }
  }
  print('--- Audit Complete ---');
}
