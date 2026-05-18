import 'dart:io';

void main() {
  final dir = Directory('.');
  final List<String> extensions = ['.dart', '.json', '.yaml', '.md', '.txt'];
  
  int found = 0;
  for (final entity in dir.listSync(recursive: true)) {
    if (entity is File) {
      final path = entity.path;
      if (path.contains('.git/') || path.contains('.dart_tool/') || path.contains('build/')) continue;
      
      final ext = extensions.firstWhere((e) => path.endsWith(e), orElse: () => '');
      if (ext.isEmpty) continue;
      
      try {
        final content = entity.readAsStringSync();
        if (content.contains('251')) {
          print('Found 251 in: $path');
          found++;
        }
      } catch (e) {
        // ignore binary/unreadable files
      }
    }
  }
  print('Done searching. Found in $found files.');
}
