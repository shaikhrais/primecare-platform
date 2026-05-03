import 'dart:io';

void main() {
  final file = File('c:/Users/Admin2/Documents/GitHub/primecare-platform/apps/primecare_governance/lib/core/governance/screen_registry.dart');
  final content = file.readAsStringSync();
  final regex = RegExp(r"'SCREEN_(\d+)': const ScreenMetadata\(");
  final matches = regex.allMatches(content);
  print('Total SCREEN_ entries: ${matches.length}');
  
  final ids = matches.map((m) => int.parse(m.group(1)!)).toSet();
  final List<int> missing = [];
  for (var i = 1; i <= 251; i++) {
    if (!ids.contains(i)) {
      missing.add(i);
    }
  }
  
  if (missing.isEmpty) {
    print('All 251 screens are present.');
  } else {
    print('Missing screens: ${missing.join(", ")}');
  }

  // Check for non-standard screens
  final nonStandardRegex = RegExp(r"'(SCREEN_\d+)'");
  final allIds = nonStandardRegex.allMatches(content).map((m) => m.group(1)).toSet();
  print('Total unique SCREEN_ IDs referenced: ${allIds.length}');
}
