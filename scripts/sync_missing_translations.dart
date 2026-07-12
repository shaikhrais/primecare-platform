import 'dart:convert';
import 'dart:io';

final String projectRoot = 'c:/Users/Admin2/Documents/GitHub/primecare-platform';
final List<String> searchDirs = [
  '$projectRoot/packages/primecare_ui/lib/src/screens',
  '$projectRoot/apps'
];
final String locDir = '$projectRoot/packages/flutter_core/lib/src/localization';
final List<String> locFiles = ['en.json', 'es.json', 'fr.json'];

void main() {
  print("==================================================");
  print("RUNNING LOCALIZATION MISSING KEYS SYNC");
  print("==================================================");

  // 1. Gather all tr() translation keys from Dart files
  final RegExp keyPattern = RegExp(r"['\"]([a-zA-Z0-9_\.]+)['\"]\s*\.tr\b");
  final Set<String> foundKeys = {};

  for (final dirPath in searchDirs) {
    final dir = Directory(dirPath);
    if (!dir.existsSync()) continue;

    final List<FileSystemEntity> files = dir.listSync(recursive: true);
    for (final file in files) {
      if (file is File && file.path.endsWith('.dart') && !file.path.endsWith('.g.dart')) {
        final content = file.readAsStringSync();
        final matches = keyPattern.allMatches(content);
        for (final m in matches) {
          final key = m.group(1);
          if (key != null && key.contains('.')) {
            foundKeys.add(key);
          }
        }
      }
    }
  }

  print("Found ${foundKeys.length} translation keys in codebase.");

  // 2. Load, update and save each localization file
  for (final lf in locFiles) {
    final file = File('$locDir/$lf');
    if (!file.existsSync()) continue;

    final Map<String, dynamic> data = json.decode(file.readAsStringSync());
    int addedCount = 0;

    for (final fullKey in foundKeys) {
      final parts = fullKey.split('.');
      Map<String, dynamic> current = data;

      for (int i = 0; i < parts.length; i++) {
        final part = parts[i];
        if (i == parts.length - 1) {
          if (!current.containsKey(part)) {
            // Generate default label
            final defaultLabel = part.replaceAll('_', ' ').split(' ').map((w) {
              if (w.isEmpty) return '';
              return w[0].toUpperCase() + w.substring(1);
            }).join(' ');
            current[part] = defaultLabel;
            addedCount++;
          }
        } else {
          if (!current.containsKey(part) || current[part] is! Map) {
            current[part] = <String, dynamic>{};
          }
          current[part] = current[part] as Map<String, dynamic>;
          current = current[part];
        }
      }
    }

    if (addedCount > 0) {
      final JsonEncoder encoder = JsonEncoder.withIndent('    ');
      file.writeAsStringSync(encoder.convert(data));
      print("Updated $lf: Added $addedCount missing translation keys.");
    } else {
      print("$lf is up to date.");
    }
  }

  print("==================================================");
  print("LOCALIZATION SYNC COMPLETED");
  print("==================================================");
}
