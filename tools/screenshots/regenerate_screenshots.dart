// Simplified screenshot regeneration script
// This script runs all visual widget tests and generates PNG previews in docs/screen_previews.
// It avoids any SQLite or FFI dependencies that cause compilation crashes on Windows.

import 'dart:io';
import 'package:args/args.dart';

Future<void> main(List<String> args) async {
  // Parse optional flags (currently only --generate-html)
  final parser = ArgParser()
    ..addFlag('generate-html', help: 'Generate HTML files next to screenshots', defaultsTo: false);
  final results = parser.parse(args);

  // Delete existing PNG previews (optional: keep if you want to preserve)
  final previewDir = Directory('docs/screen_previews');
  if (await previewDir.exists()) {
    await for (var entity in previewDir.list()) {
      if (entity is File && entity.path.endsWith('.png')) {
        await entity.delete();
      }
    }
  }

  // Run all visual tests – this will create the PNG files via the test harness.
  final testResult = await Process.run('C:/src/flutter/bin/flutter.bat', ['test', '-d', 'chrome', 'test/visual', '--tags=visual'], workingDirectory: 'packages/primecare_ui');
  stdout.write(testResult.stdout);
  stderr.write(testResult.stderr);

  // Optional: generate HTML index of screenshots
  if (results['generate-html'] as bool) {
    final htmlResult = await Process.run('dart', ['run', 'tools/screenshots/generate_html.dart']);
    stdout.write(htmlResult.stdout);
    stderr.write(htmlResult.stderr);
  }
}
