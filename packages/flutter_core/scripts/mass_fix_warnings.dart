import 'dart:io';

void main() async {
  final file = File('analysis_output_4_utf8.txt');
  if (!await file.exists()) {
    print('Analysis file not found');
    return;
  }

  final lines = await file.readAsLines();
  final unusedImports = <String, Set<int>>{};
  final unusedFields = <String, Set<String>>{};
  final unusedLocals = <String, Set<String>>{};

  for (var line in lines) {
    if (line.contains('unused_import')) {
      final parts = line.split(':');
      if (parts.length >= 3) {
        final path = parts[0].split(' - ').last.trim();
        final lineNum = int.tryParse(parts[1]);
        if (lineNum != null) {
          unusedImports.putIfAbsent(path, () => {}).add(lineNum);
        }
      }
    } else if (line.contains('unused_field')) {
      final parts = line.split(':');
      if (parts.length >= 3) {
        final path = parts[0].split(' - ').last.trim();
        final match = RegExp(
          r"The field '(.+?)' is never used",
        ).firstMatch(line);
        if (match != null) {
          unusedFields.putIfAbsent(path, () => {}).add(match.group(1)!);
        }
      }
    } else if (line.contains('unused_local_variable')) {
      final parts = line.split(':');
      if (parts.length >= 3) {
        final path = parts[0].split(' - ').last.trim();
        final match = RegExp(
          r"The value of the local variable '(.+?)' isn't used",
        ).firstMatch(line);
        if (match != null) {
          unusedLocals.putIfAbsent(path, () => {}).add(match.group(1)!);
        }
      }
    }
  }

  print('Found ${unusedImports.length} files with unused imports');
  print('Found ${unusedFields.length} files with unused fields');
  print('Found ${unusedLocals.length} files with unused locals');

  // Fix unused imports
  for (var entry in unusedImports.entries) {
    final path = entry.key;
    final linesToRemove = entry.value.toList()..sort((a, b) => b.compareTo(a));
    final f = File(path);
    if (await f.exists()) {
      var contentLines = await f.readAsLines();
      for (var lineNum in linesToRemove) {
        if (lineNum <= contentLines.length) {
          contentLines.removeAt(lineNum - 1);
        }
      }
      await f.writeAsString(contentLines.join('\n') + '\n');
    }
  }

  // Fix unused fields/locals (by commenting them out or prefixing with _)
  // For simplicity and safety, I will focus on imports first as they are the most common.
}
