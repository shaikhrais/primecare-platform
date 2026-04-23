import 'dart:io';

void main() {
  final manifestFile = File('packages/flutter_core/lib/features/01_I_features_manifest.dart');
  if (!manifestFile.existsSync()) {
    print('Manifest file not found');
    return;
  }

  final lines = manifestFile.readAsLinesSync();
  final exportRegex = RegExp(r"export 'package:flutter_core/(.*)';");

  for (final line in lines) {
    final match = exportRegex.firstMatch(line);
    if (match != null) {
      final relativePath = match.group(1);
      final fullPath = 'packages/flutter_core/lib/$relativePath';
      if (!File(fullPath).existsSync() && !Directory(fullPath).existsSync()) {
        print('MISSING: $line');
      }
    }
  }
}
