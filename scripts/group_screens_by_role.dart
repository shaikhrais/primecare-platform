import 'dart:io';

void main() {
  final file = File('apps/primecare_governance/lib/core/governance/screen_registry.dart');
  if (!file.existsSync()) {
    print('Registry not found');
    return;
  }

  final content = file.readAsStringSync();
  // Regex to match ScreenMetadata blocks and extract id, title, and role
  final screenBlockRegex = RegExp(r"'(SCREEN_\d+|DASHBOARD)': const ScreenMetadata\((.*?)\),", dotAll: true);
  
  final roleToScreens = <String, List<Map<String, String>>>{};

  for (final match in screenBlockRegex.allMatches(content)) {
    final id = match.group(1)!;
    final block = match.group(2)!;
    
    final roleMatch = RegExp(r"role:\s*['""](.*?)['"']').firstMatch(block);
    final titleMatch = RegExp(r"title:\s*['""](.*?)['"']').firstMatch(block);
    
    final role = roleMatch?.group(1)?.trim() ?? 'Unknown';
    final title = titleMatch?.group(1)?.trim() ?? 'Untitled';
    
    roleToScreens.putIfAbsent(role, () => []).add({
      'id': id,
      'title': title,
    });
  }

  final sortedRoles = roleToScreens.keys.toList()..sort();
  print('Found ${sortedRoles.length} roles with screens:');
  for (final role in sortedRoles) {
    final screens = roleToScreens[role]!;
    print('Role: $role (${screens.length} screens)');
  }
}
