import 'dart:io';

void main() {
  final dir = Directory('.');
  for (final entity in dir.listSync(recursive: true)) {
    if (entity is File) {
      final path = entity.path;
      if (path.contains('.git/') || path.contains('.dart_tool/') || path.contains('build/')) continue;
      if (path.endsWith('.dart') || path.endsWith('.json') || path.endsWith('.yaml')) {
        try {
          final content = entity.readAsStringSync();
          if (content.contains('screen_status.json')) {
            print('Found reference in: $path');
          }
        } catch (e) {}
      }
    }
  }
}
