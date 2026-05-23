// Governance - Category: service | Purpose: Group files by their parent directory to find duplicates within a feature Check for Intents
import 'dart:io';

void main() {
  final packageRoot = Directory.current.path;
  final featuresRoot = '$packageRoot/lib/features';
  final featureDir = Directory(featuresRoot);

  if (!featureDir.existsSync()) {
    print('Features directory not found');
    return;
  }

  final files = featureDir.listSync(recursive: true).whereType<File>().toList();

  int deletedCount = 0;

  // Group files by their parent directory to find duplicates within a feature
  final Map<String, List<File>> dirMap = {};
  for (final file in files) {
    final parent = file.parent.path;
    dirMap.putIfAbsent(parent, () => []).add(file);
  }

  dirMap.forEach((parent, featureFiles) {
    // Check for Intents
    final intentFiles = featureFiles
        .where((f) => f.path.endsWith('_intent.dart'))
        .toList();
    if (intentFiles.length > 1) {
      final prefixed = intentFiles
          .where(
            (f) =>
                f.path.split(Platform.pathSeparator).last.startsWith('04_I_'),
          )
          .toList();
      if (prefixed.isNotEmpty) {
        for (final f in intentFiles) {
          if (!f.path.split(Platform.pathSeparator).last.startsWith('04_I_')) {
            print('Deleting duplicate intent: ${f.path}');
            f.deleteSync();
            deletedCount++;
          }
        }
      }
    }

    // Check for Screens
    final screenFiles = featureFiles
        .where((f) => f.path.endsWith('_screen.dart'))
        .toList();
    if (screenFiles.length > 1) {
      final prefixed = screenFiles
          .where(
            (f) =>
                f.path.split(Platform.pathSeparator).last.startsWith('05_U_'),
          )
          .toList();
      if (prefixed.isNotEmpty) {
        for (final f in screenFiles) {
          if (!f.path.split(Platform.pathSeparator).last.startsWith('05_U_')) {
            print('Deleting duplicate screen: ${f.path}');
            f.deleteSync();
            deletedCount++;
          }
        }
      }
    }
  });

  print('Cleanup complete. Deleted $deletedCount redundant files.');
}
