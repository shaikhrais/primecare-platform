import 'dart:io';

void main() {
  final dir = Directory('packages');
  for (final entity in dir.listSync(recursive: true)) {
    if (entity is File) {
      final path = entity.path;
      if (path.contains('.git/') || path.contains('.dart_tool/') || path.contains('build/')) continue;
      if (path.endsWith('.dart')) {
        try {
          final content = entity.readAsStringSync();
          if (content.contains('extension') && content.contains('BuildContext') && content.contains('theme')) {
            print('Found context.theme extension in: $path');
          }
        } catch (e) {}
      }
    }
  }
}
