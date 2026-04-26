import 'dart:io';

void main() {
  final packageRoot = Directory.current.path;
  final featuresRoot = '$packageRoot/lib/features';
  final manifestFile = '$featuresRoot/features_manifest.dart';

  final featureDir = Directory(featuresRoot);
  if (!featureDir.existsSync()) {
    print('Features directory not found');
    return;
  }

  final files = featureDir.listSync(recursive: true);

  // Use a Set to avoid any physical duplicate exports
  final exports = <String>{};

  for (final file in files) {
    if (file is File) {
      final path = file.path;
      if (path.endsWith('_screen.dart') || path.endsWith('_intent.dart')) {
        final relative = path.split('features').last.replaceAll('\\', '/');
        exports.add("export 'package:flutter_core/features$relative';");
      }
    }
  }

  final sortedExports = exports.toList()..sort();

  final buffer = StringBuffer();
  buffer.writeln('// AUTO-GENERATED FEATURES MANIFEST - DO NOT EDIT');
  buffer.writeln('// Total Items: ${sortedExports.length}');
  buffer.writeln('');
  for (final e in sortedExports) buffer.writeln(e);

  File(manifestFile).writeAsStringSync(buffer.toString());
  print('Manifest updated with ${sortedExports.length} items.');
}
