import 'dart:io';

void main() {
  final file = File(
    '../../packages/factory_system/primecare_ui/lib/src/shared/src/registry/primecare_form_provider.dart',
  );
  final lines = file.readAsLinesSync();

  final newLines = <String>[];
  final seenCases = <String>{};

  bool skipNext = false;

  for (int i = 0; i < lines.length; i++) {
    final line = lines[i];
    if (line.contains('case PrimeCareForm.')) {
      final caseMatch = RegExp(
        r'case (PrimeCareForm\.[a-zA-Z0-9_]+):',
      ).firstMatch(line);
      if (caseMatch != null) {
        final caseValue = caseMatch.group(1)!;
        if (seenCases.contains(caseValue)) {
          print('Removing duplicate case: $caseValue');
          // Skip this line and the next line (the return statement)
          i++; // skip return
          continue;
        } else {
          seenCases.add(caseValue);
        }
      }
    }
    newLines.add(line);
  }

  file.writeAsStringSync(newLines.join('\n'));
}
