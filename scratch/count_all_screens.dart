import 'dart:io';

void main() {
  final file = File('c:/Users/Admin2/Documents/GitHub/primecare-platform/apps/primecare_governance/lib/core/governance/screen_registry.dart');
  final lines = file.readAsLinesSync();
  int count = 0;
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
      // Look for keys like 'KEY': const ScreenMetadata(
      if (RegExp(r"^\s+'[^']+': const ScreenMetadata\(").hasMatch(line)) {
        count++;
      }
    }
  }
  print('Total screens in map: $count');
}
