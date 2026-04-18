// ignore_for_file: avoid_print
import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    print('Usage: dart telemetry_auto_instrument.dart <directory_path>');
    return;
  }

  final dir = Directory(args[0]);
  if (!dir.existsSync()) {
    print('Directory does not exist: ${args[0]}');
    return;
  }

  print('Starting Large Scale Instrumentation Cleanup in ${args[0]}...');

  final files = dir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'));

  int processedCount = 0;
  int removedCount = 0;

  for (final file in files) {
    processedCount++;
    final content = file.readAsStringSync();

    // We target specifically the unused import cases
    if (content.contains(
      "import 'package:primecare_core/primecare_core.dart';",
    )) {
      if (!content.contains('ExecutionGateCategory') &&
          !content.contains('executionGateProvider') &&
          !content.contains('ExecutionGateStatus')) {
        // Remove the import line completely including trailing newline
        final lines = content.split('\n');
        lines.removeWhere(
          (line) => line.contains(
            "import 'package:primecare_core/primecare_core.dart';",
          ),
        );

        file.writeAsStringSync(lines.join('\n'));
        removedCount++;
        print('Removed unused import: ${file.path}');
      }
    }
  }

  print('-----------------------------------------');
  print('Cleanup Complete.');
  print('Total Files Scanned: $processedCount');
  print('Total Imports Removed: $removedCount');
  print('-----------------------------------------');
}
