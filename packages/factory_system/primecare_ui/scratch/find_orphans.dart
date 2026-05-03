
import 'dart:io';

void main() {
  final dir = Directory('lib/src/features');
  final files = dir.listSync(recursive: true);
  
  for (final file in files) {
    if (file is File && file.path.endsWith('.dart')) {
      final content = file.readAsStringSync();
      if (content.contains('extends PrimeCareScreen')) {
        // Simple check for missing provider in super() call
        if (!content.contains('provider:')) {
          print('Potentially orphaned: ${file.path}');
        }
      }
    }
  }
}
