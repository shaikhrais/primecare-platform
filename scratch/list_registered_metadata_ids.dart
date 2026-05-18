import 'dart:io';

void main() {
  final registryPath = 'apps/primecare_governance/lib/core/governance/registries/core_governance_registry.dart';
  final file = File(registryPath);
  
  if (!file.existsSync()) {
    print('Error: CoreGovernanceRegistry not found!');
    return;
  }

  final lines = file.readAsLinesSync();
  final Set<String> ids = {};
  final idRegex = RegExp(r"^\s*'([A-Z0-9_]+)':\s*ScreenMetadata\(");
  
  for (final line in lines) {
    final match = idRegex.firstMatch(line);
    if (match != null) {
      ids.add(match.group(1)!);
    }
  }

  print('Total IDs in CoreGovernanceRegistry: ${ids.length}');
  print('List of IDs (first 50):');
  print(ids.take(50).toList());
  
  // Let's check if CEO is in the list
  final ceoIds = ids.where((id) => id.contains('CEO')).toList();
  print('\nCEO IDs: $ceoIds');
  
  // Let's check other roles
  final roles = ids.map((id) {
    final idx = id.indexOf('_');
    if (idx != -1) {
      return id.substring(0, idx);
    }
    return id;
  }).toSet();
  
  print('\nAll unique role prefixes in CoreGovernanceRegistry (${roles.length}):');
  print(roles.toList());
}
