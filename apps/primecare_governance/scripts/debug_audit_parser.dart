// ignore_for_file: avoid_print
import 'dart:io';

void main() {
  final governanceDir = Directory('lib/core/governance/registries');
  final registryFiles = governanceDir
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .toList();

  int total = 0;
  for (final file in registryFiles) {
    final content = file.readAsStringSync();
    final entries = _parseRegistry(content);
    print('${file.path}: ${entries.length} entries');
    for (final entry in entries) {
      final id = _getField(entry, 'id');
      final isVirtual = _getBoolField(entry, 'isVirtual');
      print('  - $id (Virtual: $isVirtual)');
    }
    total += entries.length;
  }
  print('Total parsed: $total');
}

String _getField(String block, String field) {
  final regex = RegExp('$field:\\s*(?:\'(.*?)\'|LifecycleStatus\\.(.*?))');
  final match = regex.firstMatch(block);
  return match?.group(1) ?? match?.group(2) ?? 'Unknown';
}

bool _getBoolField(String block, String field) {
  final regex = RegExp('$field:\\s*(true|false)');
  final match = regex.firstMatch(block);
  return match?.group(1) == 'true';
}

List<String> _parseRegistry(String content) {
  final List<String> entries = [];
  final regex = RegExp(r'ScreenMetadata\((.*?)\),', dotAll: true);
  final matches = regex.allMatches(content);
  for (final match in matches) {
    entries.add(match.group(1)!);
  }
  return entries;
}
