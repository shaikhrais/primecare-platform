import 'dart:io';

void main() {
  final file = File('c:/Users/Admin2/Documents/GitHub/primecare-platform/apps/primecare_governance/lib/core/governance/screen_registry.dart');
  final lines = file.readAsLinesSync();
  List<String> keys = [];
  bool inMap = false;
  for (var line in lines) {
    if (line.contains('static final Map<String, ScreenMetadata> screens = {')) {
      inMap = true;
      continue;
    }
    if (inMap && line.contains('};')) {
      inMap = false;
      break;
    }
    if (inMap) {
      final match = RegExp(r"^\s+'([^']+)'").firstMatch(line);
      if (match != null && line.contains('ScreenMetadata')) {
        keys.add(match.group(1)!);
      }
    }
  }
  print('Total screens in map: ${keys.length}');
  print('Keys: ${keys.join(", ")}');
}
