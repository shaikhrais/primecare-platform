import 'dart:io';

void main() {
  final file = File('apps/primecare_governance/lib/core/governance/registries/core_governance_registry.dart');
  if (!file.existsSync()) {
    print('Core governance registry not found!');
    return;
  }

  final content = file.readAsStringSync();
  
  // Regex to match ScreenMetadata blocks and extract details
  // e.g.:
  // 'COO_DASHBOARD': ScreenMetadata(
  //   id: 'COO_DASHBOARD',
  //   title: 'Coo Control Center',
  //   allowedRoles: ['COO'],
  // )
  
  final screenBlockRegex = RegExp(
    r"'\w+':\s*ScreenMetadata\((.*?)\),",
    dotAll: true,
  );
  
  final matches = screenBlockRegex.allMatches(content);
  print('Found ${matches.length} screen matches');

  final Map<String, List<String>> roleToScreens = {};
  
  for (final match in matches) {
    final block = match.group(1)!;
    
    // Extract ID
    final idMatch = RegExp(r"id:\s*'([^']+)'").firstMatch(block);
    if (idMatch == null) continue;
    final id = idMatch.group(1)!;

    // Extract Title
    final titleMatch = RegExp(r"title:\s*'([^']+)'").firstMatch(block);
    final title = titleMatch != null ? titleMatch.group(1)! : id;

    // Extract allowedRoles
    final rolesMatch = RegExp(r"allowedRoles:\s*\[(.*?)\]").firstMatch(block);
    List<String> roles = [];
    if (rolesMatch != null) {
      final rolesStr = rolesMatch.group(1)!;
      roles = rolesStr
          .split(',')
          .map((r) => r.trim().replaceAll("'", "").replaceAll('"', ''))
          .where((r) => r.isNotEmpty)
          .toList();
    }

    if (roles.isEmpty) {
      roles = ['NO_ROLES_ASSIGNED'];
    }

    for (final role in roles) {
      roleToScreens.putIfAbsent(role, () => []).add('$title ($id)');
    }
  }

  // Print summary sorted by role
  final sortedRoles = roleToScreens.keys.toList()..sort();
  
  print('\n=== ROLE-TO-SCREEN MATRIX ===\n');
  for (final role in sortedRoles) {
    final screens = roleToScreens[role]!;
    print('Role: $role');
    print('Number of Screens: ${screens.length}');
    print('Screens:');
    for (final s in screens) {
      print('  - $s');
    }
    print('');
  }
}
