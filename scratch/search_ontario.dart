import 'dart:io';

void main() {
  final registryPath = 'apps/primecare_governance/lib/core/governance/registries/core_governance_registry.dart';
  final file = File(registryPath);
  
  if (!file.existsSync()) {
    print('Error: CoreGovernanceRegistry not found!');
    return;
  }

  final lines = file.readAsLinesSync();
  int found = 0;
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].toLowerCase().contains('ontario')) {
      print('Line ${i + 1}: ${lines[i].trim()}');
      found++;
    }
  }
  print('Total occurrences of ontario: $found');
}
