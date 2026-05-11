
import 'dart:io';

void main() {
  final file = File('apps/primecare_governance/lib/core/governance/registries/core_governance_registry.dart');
  final content = file.readAsStringSync();
  
  final roleRegex = RegExp(r"allowedRoles:\s*\[(.*?)\]", dotAll: true);
  final matches = roleRegex.allMatches(content);
  
  final foundRoles = <String>{};
  for (final match in matches) {
    final rolesStr = match.group(1)!;
    final roles = rolesStr.split(',').map((s) => s.trim().replaceAll("'", "").replaceAll('"', '')).where((s) => s.isNotEmpty);
    foundRoles.addAll(roles);
  }
  
  print('Found Roles in Registry: ${foundRoles.length}');
  print('Roles: ${foundRoles.join(', ')}');
}
