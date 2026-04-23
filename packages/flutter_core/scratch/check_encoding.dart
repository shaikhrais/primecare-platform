import 'dart:io';

void main() {
  final features = Directory('lib/features');
  if (!features.existsSync()) return;

  features.listSync(recursive: true).forEach((entity) {
    if (entity is File && entity.path.endsWith('.dart')) {
      try {
        entity.readAsStringSync();
      } catch (e) {
        print('FILE ERROR: ${entity.path} - $e');
      }
    }
  });
}
