import 'dart:io';

void main() {
  final rootDir = Directory('c:/Users/Admin2/Documents/GitHub/primecare-platform');
  
  void processDirectory(Directory dir) {
    if (dir.path.contains('node_modules') || 
        dir.path.contains('.git') || 
        dir.path.contains('.turbo') ||
        dir.path.contains('.agents')) {
      return;
    }

    try {
      final entities = dir.listSync();
      for (final entity in entities) {
        if (entity is Directory) {
          processDirectory(entity);
        } else if (entity is File) {
          final path = entity.path;
          
          // 1. Update pubspec.yaml
          if (path.endsWith('pubspec.yaml')) {
            var content = entity.readAsStringSync();
            if (content.contains('primecare_adapters:')) {
              final lines = content.split('\n');
              final newLines = <String>[];
              var skip = false;
              for (var line in lines) {
                if (line.contains('primecare_adapters:')) {
                  skip = true;
                  continue;
                }
                if (skip && line.contains('path:')) {
                  skip = false;
                  continue;
                }
                if (!skip) newLines.add(line);
              }
              entity.writeAsStringSync(newLines.join('\n'));
              print('Updated Pubspec: $path');
            }
          }
          
          // 2. Update Dart imports
          if (path.endsWith('.dart')) {
            if (path.contains('primecare_adapters')) continue;
            if (path.contains('primecare_ui/lib/src/shared')) continue;

            var content = entity.readAsStringSync();
            var changed = false;

            if (content.contains('package:primecare_ui/primecare_ui.dart')) {
              content = content.replaceAll(
                'package:primecare_ui/primecare_ui.dart',
                'package:primecare_ui/primecare_ui.dart',
              );
              changed = true;
            }

            if (content.contains('package:primecare_ui/src/shared/src/')) {
              content = content.replaceAll(
                'package:primecare_ui/src/shared/src/',
                'package:primecare_ui/src/shared/src/',
              );
              changed = true;
            }

            if (changed) {
              entity.writeAsStringSync(content);
              print('Updated Imports: $path');
            }
          }
        }
      }
    } catch (e) {
      print('Error processing ${dir.path}: $e');
    }
  }

  processDirectory(rootDir);
}
