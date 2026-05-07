import 'package:primecare_governance/governance/services/cross_subsystem_auditor.dart';

void main() async {
  print('--- Starting Comprehensive Governance Audit ---');
  final auditor = CrossSubsystemAuditor(projectRoot: '../..');

  print('\n[1/2] Auditing Form Provider Parity...');
  final formIssues = await auditor.auditFormProviderParity();
  if (formIssues.isEmpty) {
    print('✅ Form Provider Parity: 100%');
  } else {
    print('❌ Found ${formIssues.length} form parity issues.');
  }

  print('\n[2/2] Auditing Screen Registry Parity...');
  final screenIssues = await auditor.auditScreenRegistryParity();
  if (screenIssues.isEmpty) {
    print('✅ Screen Registry Parity: 100%');
  } else {
    print('❌ Found ${screenIssues.length} screen parity issues.');
    for (final issue in screenIssues) {
      print('  - [${issue.registry}] ${issue.issue}');
      print('    Suggestion: ${issue.suggestion}');
    }
  }

  print('\n--- Audit Results ---');
  print(
    'Stability Score: ${formIssues.isEmpty && screenIssues.isEmpty ? "100%" : "DEGRADED"}',
  );
  print('--- Audit Complete ---');
}
