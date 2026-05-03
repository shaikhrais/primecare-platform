import 'dart:io';
import 'dart:convert';

void main() {
  final file = File('c:\\Users\\Admin2\\Documents\\GitHub\\primecare-platform\\apps\\primecare_governance\\lib\\core\\governance\\screen_registry.dart');
  final content = file.readAsStringSync();
  
  final regex = RegExp(r"'(SCREEN_\d+|DASHBOARD)': const ScreenMetadata\((.*?)\),", dotAll: true);
  final matches = regex.allMatches(content);
  
  final Map<String, List<Map<String, dynamic>>> roleGroups = {};
  
  for (final match in matches) {
    final id = match.group(1)!;
    final block = match.group(2)!;
    
    final role = _getField(block, 'role');
    final title = _getField(block, 'title');
    final description = _getField(block, 'description');
    final pending = _getListField(block, 'pendingComponents');
    final office = _getField(block, 'office');
    
    if (!roleGroups.containsKey(role)) {
      roleGroups[role] = [];
    }
    
    roleGroups[role]!.add({
      'id': id,
      'title': title,
      'description': description,
      'pendingComponents': pending,
      'office': office,
    });
  }
  
  final outputFile = File('c:\\Users\\Admin2\\Documents\\GitHub\\primecare-platform\\scratch\\role_screen_groups.json');
  outputFile.writeAsStringSync(jsonEncode(roleGroups));
  print('Grouped ${matches.length} screens into ${roleGroups.length} roles.');
}

String _getField(String block, String field) {
  final regex = RegExp('$field:\\s*\'(.*?)\'');
  final match = regex.firstMatch(block);
  return match?.group(1) ?? 'Unknown';
}

List<String> _getListField(String block, String field) {
  final regex = RegExp('$field:\\s*\\[(.*?)\\]', dotAll: true);
  final match = regex.firstMatch(block);
  if (match == null) return [];
  
  return match.group(1)!
      .split(',')
      .map((e) => e.trim().replaceAll("'", "").replaceAll('"', ""))
      .where((e) => e.isNotEmpty)
      .toList();
}
