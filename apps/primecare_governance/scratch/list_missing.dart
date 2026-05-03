import 'package:primecare_governance/governance/services/cross_subsystem_auditor.dart';

void main() async {
  final auditor = CrossSubsystemAuditor(projectRoot: '../..');
  print('--- Analyzing Missing Screen Registrations ---');
  
  final audit = await auditor.auditScreenRegistryParity();
  final missing = audit.where((i) => i.metadata['type'] == 'missing_screen_registration').toList();
  
  print('Total Missing Screens: ${missing.length}');
  for (var i = 0; i < missing.length; i++) {
    final issue = missing[i];
    print('[${i + 1}] Route: ${issue.metadata['route']}');
  }
}
