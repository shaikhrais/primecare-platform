import 'dart:io';

void main() {
  final reportFile = File(r'C:\Users\Admin2\.gemini\antigravity\brain\9fcdd39a-59a0-4403-945b-62e5fe26955a\screen_completeness_report.md');
  if (!reportFile.existsSync()) {
    print('Report not found');
    return;
  }

  final lines = reportFile.readAsLinesSync();
  print('--- Unmapped/Stubbed Screens ---');
  for (final line in lines) {
    if (line.contains('Unmapped/Stubbed')) {
      print(line);
    }
  }
}
