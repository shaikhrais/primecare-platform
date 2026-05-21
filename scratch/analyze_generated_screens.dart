import 'dart:io';

void main() {
  final dir = Directory('packages/primecare_ui/lib/src/features/generated_screens');
  if (!dir.existsSync()) {
    print('Directory not found!');
    return;
  }

  final files = dir.listSync().whereType<File>().where((f) => f.path.endsWith('.dart')).toList();
  print('Total generated screens files: ${files.length}');

  // Let's inspect a few to see what they contain
  int count = 0;
  for (final file in files) {
    final name = file.path.split('/').last.split('\\').last;
    final content = file.readAsStringSync();
    final classMatch = RegExp(r'class\s+([A-Za-z0-9_]+)\s+extends').firstMatch(content);
    final className = classMatch?.group(1) ?? 'Unknown';
    
    // Find any titles or subtitles
    final titleMatch = RegExp(r"title:\s*'([^']+)'").firstMatch(content);
    final title = titleMatch?.group(1) ?? 'No Title';
    
    if (count < 20 || className.startsWith('Premium')) {
      print('File: $name | Class: $className | Title: $title');
      count++;
    }
  }
}
