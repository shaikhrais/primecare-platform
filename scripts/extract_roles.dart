import 'dart:io';

void main() {
  final file = File('apps/primecare_governance/lib/core/governance/screen_registry.dart');
  if (!file.existsSync()) {
    print('Registry not found');
    return;
  }

  final content = file.readAsStringSync();
  // Match role: '...' or role: "..."
  final roleFieldRegex = RegExp(r"role:\s*['""](.*?)['"']');
  final roles = <String>{};

  for (final match in roleFieldRegex.allMatches(content)) {
    final role = match.group(1)!.trim();
    if (role.isNotEmpty) roles.add(role);
  }

  final sortedRoles = roles.toList()..sort();
  print('Found ${sortedRoles.length} unique roles:');
  for (var role in sortedRoles) {
    print('- $role');
  }
}
