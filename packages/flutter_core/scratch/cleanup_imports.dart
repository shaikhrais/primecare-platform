
import 'dart:io';

void main() {
  final rootDir = Directory('c:/Users/Admin2/Documents/GitHub/primecare-platform/packages/flutter_core/lib');
  final files = rootDir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart'));

  int cleanedCount = 0;

  for (final file in files) {
    String content = file.readAsStringSync();
    bool changed = false;

    // If it imports primecare_ui, it has material, adapters, and riverpod.
    if (content.contains('package:primecare_ui/primecare_ui.dart')) {
      final oldContent = content;
      content = content.replaceAll("import 'package:flutter/material.dart';", '');
      content = content.replaceAll("import 'package:primecare_adapters/primecare_adapters.dart';", '');
      content = content.replaceAll("import 'package:flutter_riverpod/flutter_riverpod.dart';", '');
      
      // Clean up multiple newlines that might have been created
      content = content.replaceAll(RegExp(r'\n\s*\n\s*\n'), '\n\n');
      
      if (content != oldContent) {
        changed = true;
      }
    }

    if (changed) {
      file.writeAsStringSync(content);
      cleanedCount++;
    }
  }

  print('Cleaned $cleanedCount files in flutter_core.');
}
