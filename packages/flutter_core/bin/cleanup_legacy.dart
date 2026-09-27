// Governance - Category: service | Purpose: If it doesn't start with our new layer prefix, it's legacy
import 'dart:io';

void main() {
  final packageRoot = Directory.current.path;
  final featuresRoot = Directory('$packageRoot/lib/features');

  if (!featuresRoot.existsSync()) return;

  final files = featuresRoot.listSync(recursive: true);
  int deletedCount = 0;

  for (final file in files) {
    if (file is File) {
      final name = file.path.split(Platform.pathSeparator).last;
      if (name == 'features_manifest.dart') continue;

      // If it doesn't start with our new layer prefix, it's legacy
      if (!name.startsWith(RegExp(r'0\d_'))) {
        print('Deleting legacy file: \${file.path}');
        file.deleteSync();
        deletedCount++;
      }
    }
  }

  // Delete empty directories
  _deleteEmptyDirs(featuresRoot);

  print('Cleanup completed. Deleted $deletedCount legacy files.');
}

void _deleteEmptyDirs(Directory dir) {
  if (!dir.existsSync()) return;
  final entities = dir.listSync();
  for (final entity in entities) {
    if (entity is Directory) {
      _deleteEmptyDirs(entity);
    }
  }
  if (dir.listSync().isEmpty && dir.path != 'lib/features') {
    print('Deleting empty directory: \${dir.path}');
    dir.deleteSync();
  }
}
