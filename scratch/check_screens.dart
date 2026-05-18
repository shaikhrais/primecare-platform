import 'dart:io';

void main() {
  final file = File('apps/primecare_governance/lib/core/governance/registries/core_governance_registry.dart');
  if (!file.existsSync()) {
    print('File not found!');
    return;
  }
  final content = file.readAsStringSync();
  final regex = RegExp(r"'\b([A-Z0-9_]+)\b':\s*ScreenMetadata\(");
  final matches = regex.allMatches(content);
  print('Found ${matches.length} screens in registry:');
  for (final match in matches) {
    print(' - ${match.group(1)}');
  }
}
