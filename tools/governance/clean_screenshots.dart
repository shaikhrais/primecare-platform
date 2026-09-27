import 'dart:io';
import 'package:path/path.dart' as p;

/// Deletes all screenshot files (png, jpg, webp) and temporary images
/// under `docs/screen_previews/`. Returns the number of files deleted.
Future<int> cleanScreenshots() async {
  final previewDir = Directory('docs/screen_previews');
  if (!await previewDir.exists()) {
    print('Screen preview directory does not exist.');
    return 0;
  }

  final allowedExtensions = ['.png', '.jpg', '.jpeg', '.webp'];
  int deletedCount = 0;

  await for (final entity in previewDir.list(recursive: true, followLinks: false)) {
    if (entity is File) {
      final ext = p.extension(entity.path).toLowerCase();
      // Skip documentation template files (e.g., README_SCREENSHOTS.md)
      if (allowedExtensions.contains(ext) &&
          !p.basename(entity.path).startsWith('README')) {
        try {
          await entity.delete();
          deletedCount++;
        } catch (e) {
          // ignore errors; continue cleaning other files
        }
      }
    }
  }
  print('Deleted $deletedCount screenshot files.');
  return deletedCount;
}

void main() async {
  final count = await cleanScreenshots();
  print('old_screenshot_deleted_count: $count');
}
