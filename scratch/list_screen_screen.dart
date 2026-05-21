import 'dart:io';

void main() {
  final govFile = File('apps/primecare_governance/lib/core/governance/registries/core_governance_registry.dart');
  if (!govFile.existsSync()) return;

  final content = govFile.readAsStringSync();
  final screenBlockRegex = RegExp(r"'(\w+)':\s*ScreenMetadata\(");
  final keys = screenBlockRegex.allMatches(content).map((m) => m.group(1)!).toList();

  final screenScreenKeys = keys.where((k) => k.startsWith('SCREEN_SCREEN_')).toList();
  print('Total SCREEN_SCREEN_ keys: ${screenScreenKeys.length}');
  
  print('First 10 SCREEN_SCREEN_ keys:');
  for (int i = 0; i < 10 && i < screenScreenKeys.length; i++) {
    print(' - ${screenScreenKeys[i]}');
  }

  print('Last 10 SCREEN_SCREEN_ keys:');
  for (int i = screenScreenKeys.length - 10; i < screenScreenKeys.length; i++) {
    if (i >= 0) {
      print(' - ${screenScreenKeys[i]}');
    }
  }
}
