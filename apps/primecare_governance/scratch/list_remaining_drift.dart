import 'package:primecare_governance/governance/services/cross_subsystem_auditor.dart';

void main() async {
  final auditor = CrossSubsystemAuditor(projectRoot: '../..');
  print('--- Analyzing Remaining Registry Drift ---');

  final audit = await auditor.auditScreenRegistryParity();
  final remaining = audit.where((i) => i.autoRemediable == false).toList();

  print('Total Remaining Issues: ${remaining.length}');
  for (var i = 0; i < remaining.length; i++) {
    final issue = remaining[i];
    print('[${i + 1}] ${issue.registry}: ${issue.issue}');
    print('    Suggestion: ${issue.suggestion}');
    print('    Metadata: ${issue.metadata}');
  }
}
