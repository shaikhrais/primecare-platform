import 'dart:io';

void main() {
  final file = File('apps/primecare_governance/lib/core/governance/registries/core_governance_registry.dart');
  if (!file.existsSync()) return;

  final content = file.readAsStringSync();
  
  // We need to insert '), ' before every 'SCREEN_...' key if it's missing.
  // Actually, a better way is to regex match the start of an entry and ensure the previous one is closed.
  
  final lines = content.split('\n');
  final List<String> fixedLines = [];
  
  for (int i = 0; i < lines.length; i++) {
    final line = lines[i];
    
    // If this line starts a new entry
    if (RegExp(r"^\s*'SCREEN_[^']+':\s*ScreenMetadata\(").hasMatch(line)) {
      // Check if the previous line (excluding whitespace) ended with '), '
      if (fixedLines.isNotEmpty) {
        final lastLine = fixedLines.last.trim();
        if (!lastLine.endsWith('),') && !lastLine.endsWith('{') && !lastLine.startsWith('import') && !lastLine.startsWith('class') && !lastLine.startsWith('static')) {
           fixedLines.add('    ),');
        }
      }
    }
    fixedLines.add(line);
  }
  
  file.writeAsStringSync(fixedLines.join('\n'));
  print('Registry structure partially recovered.');
}
