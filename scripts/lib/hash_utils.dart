import 'dart:io';

class HashUtils {
  /// Generates a stable content-based fingerprint for a directory.
  /// Uses file paths, sizes, and content samples (head/tail) to detect changes.
  static String getDirectoryHash(String path) {
    final dir = Directory(path);
    if (!dir.existsSync()) return '';

    final files = dir
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) {
          final p = f.path.toLowerCase();
          // Ignore hidden directories like .dart_tool, .idea, etc.
          if (p.contains(RegExp(r'[\\/]\.(?!(github))'))) return false;
          // Only include source-relevant extensions
          return p.endsWith('.dart') || 
                 p.endsWith('.yaml') || 
                 p.endsWith('.json') || 
                 p.endsWith('.lock');
        })
        .toList();

    // Sort files by path to ensure deterministic hashing
    files.sort((a, b) => a.path.compareTo(b.path));

    final StringBuffer combined = StringBuffer();
    for (final file in files) {
      final stat = file.statSync();
      final head = _readFileHead(file);
      final tail = _readFileTail(file);
      combined.write('${file.path}:${stat.size}:${head}:${tail}\n');
    }

    // Use a stable hash algorithm instead of Dart's non-deterministic hashCode
    return _stableHash(combined.toString()).toRadixString(16);
  }

  static int _stableHash(String string) {
    int hash = 5381;
    for (int i = 0; i < string.length; i++) {
      // hash * 33 + char
      hash = (((hash << 5) + hash) + string.codeUnitAt(i)) & 0xFFFFFFFF;
    }
    return hash;
  }

  static String _readFileHead(File file) {
    try {
      final raf = file.openSync();
      final length = raf.lengthSync();
      final bytesToRead = length < 1024 ? length : 1024;
      final bytes = raf.readSync(bytesToRead);
      raf.closeSync();
      // Return a simple hex representation of the sample
      return bytes.take(16).map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    } catch (_) {
      return '';
    }
  }

  static String _readFileTail(File file) {
    try {
      final raf = file.openSync();
      final length = raf.lengthSync();
      if (length < 1024) {
        raf.closeSync();
        return '';
      }
      raf.setPositionSync(length - 1024);
      final bytes = raf.readSync(1024);
      raf.closeSync();
      return bytes.take(16).map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    } catch (_) {
      return '';
    }
  }
}
