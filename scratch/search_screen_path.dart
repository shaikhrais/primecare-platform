import 'dart:io';

void main() {
  final dir = Directory('.');
  for (final entity in dir.listSync(recursive: true)) {
    if (entity is File) {
      final path = entity.path;
      if (path.contains('.git/') || path.contains('.dart_tool/') || path.contains('build/')) continue;
      if (path.endsWith('.dart') && path.contains('quality_assurance_compliance_screen')) {
        print('Found screen at: ${entity.absolute.path}');
      }
    }
  }
}
