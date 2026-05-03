import 'package:primecare_governance/governance/services/cross_subsystem_auditor.dart';

void main() async {
  print('--- Starting Cross-Subsystem Registry Audit ---');
  final auditor = CrossSubsystemAuditor(projectRoot: '.');
  
  print('Auditing Screen Registry Parity...');
  final issues = await auditor.auditScreenRegistryParity();
  
  if (issues.isEmpty) {
    print('SUCCESS: No registry parity issues detected.');
  } else {
    print('DETECTED ${issues.length} ISSUES:');
    for (final issue in issues) {
      print(' [${issue.registry}] ${issue.issue}');
      print('   Suggestion: ${issue.suggestion}');
      if (issue.metadata.isNotEmpty) {
        print('   Metadata: ${issue.metadata}');
      }
      print('');
    }
  }
  print('--- Audit Complete ---');
}
