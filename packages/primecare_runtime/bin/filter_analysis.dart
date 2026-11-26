// Governance - Category: service | Purpose: Core implementation file for the Filter Analysis platform logic.
import 'dart:io';

void main() async {
  final process = await Process.start('dart', [
    'analyze',
    'packages/flutter_core',
  ]);

  int errors = 0;
  int warnings = 0;

  process.stdout.transform(SystemEncoding().decoder).listen((line) {
    if (line.contains('error -')) {
      errors++;
      print(line);
    } else if (line.contains('warning -')) {
      warnings++;
    }
  });

  await process.exitCode;
  print('Total: $errors errors, $warnings warnings');
}
