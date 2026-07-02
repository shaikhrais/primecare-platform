import 'dart:io';
import 'dart:convert';

void main() {
  final jsonPath = 'apps/primecare_governance/assets/screen_status.json';
  final file = File(jsonPath);
  if (!file.existsSync()) {
    print('JSON not found.');
    return;
  }

  final data = json.decode(file.readAsStringSync()) as Map<String, dynamic>;
  final buffer = StringBuffer();

  buffer.writeln('# PrimeCare Implementation Status Report');
  buffer.writeln();

  buffer.writeln('## Summary');
  buffer.writeln('| Metric | Count |');
  buffer.writeln('|--------|-------|');
  final summary = data['summary'] as Map<String, dynamic>;
  buffer.writeln('| Total Screens | ${summary['total']} |');
  buffer.writeln('| Implemented | ${summary['implemented']} |');
  buffer.writeln('| Pending | ${summary['pending']} |');
  buffer.writeln();

  buffer.writeln('## Status By App');
  buffer.writeln('| App | Total | Implemented | Pending |');
  buffer.writeln('|-----|-------|-------------|---------|');
  for (final entry in (data['byApp'] as Map<String, dynamic>).entries) {
    final stats = entry.value as Map<String, dynamic>;
    buffer.writeln(
      '| `${entry.key}` | ${stats['total']} | ${stats['implemented']} | ${stats['pending']} |',
    );
  }
  buffer.writeln();

  buffer.writeln('## Status By Charter');
  buffer.writeln('| Charter | Total | Implemented | Pending |');
  buffer.writeln('|---------|-------|-------------|---------|');
  for (final entry in (data['byCharter'] as Map<String, dynamic>).entries) {
    final stats = entry.value as Map<String, dynamic>;
    buffer.writeln(
      '| ${entry.key} | ${stats['total']} | ${stats['implemented']} | ${stats['pending']} |',
    );
  }
  buffer.writeln();

  buffer.writeln('## Detailed Screen Matrix');
  buffer.writeln('| Screen ID | App | Office | Role | Charter | Status |');
  buffer.writeln('|-----------|-----|--------|------|---------|--------|');

  for (final screen in data['screens'] as List<dynamic>) {
    final screenMap = screen as Map<String, dynamic>;
    final statusIcon = screenMap['status'] == 'implemented' ? '✅' : '⏳';
    buffer.writeln(
      '| `${screenMap['id']}` | ${screenMap['app']} | ${screenMap['office']} | ${screenMap['role']} | ${screenMap['charter']} | $statusIcon ${screenMap['status']} |',
    );
  }

  final mdPath = 'apps/primecare_governance/assets/screen_status_report.md';
  File(mdPath).writeAsStringSync(buffer.toString());
  print('Markdown report generated at $mdPath');
}
