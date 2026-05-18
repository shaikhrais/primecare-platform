import 'dart:io';

void main() {
  final dir = Directory('.agents/governance');
  for (final entity in dir.listSync()) {
    if (entity is File && entity.path.endsWith('.yaml')) {
      final lines = entity.readAsLinesSync();
      int count = 0;
      for (final line in lines) {
        if (line.trim().startsWith('- id:')) {
          count++;
        }
      }
      print('${entity.path} count of ids: $count');
    }
  }
}
