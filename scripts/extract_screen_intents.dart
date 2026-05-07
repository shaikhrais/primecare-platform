import 'dart:io';

void main() {
  final file = File(
    'apps/primecare_governance/lib/core/governance/screen_registry.dart',
  );
  if (!file.existsSync()) {
    print('Registry not found');
    return;
  }

  final content = file.readAsStringSync();
  final screenRegex = RegExp(
    r"id: '(SCREEN_\d+)',[\s\S]*?title: '(.*?)',[\s\S]*?description: '(.*?)',[\s\S]*?implementedComponents: \[(.*?)\],[\s\S]*?pendingComponents: \[(.*?)\],",
    multiLine: true,
  );

  final matches = screenRegex.allMatches(content);
  print('Found ${matches.length} screens');

  final output = StringBuffer();
  output.writeln('# Screen Intent Audit Data');
  output.writeln('| ID | Title | Description | Implemented | Pending |');
  output.writeln('|---|---|---|---|---|');

  for (final match in matches) {
    final id = match.group(1);
    final title = match.group(2);
    final description = match.group(3);
    final implemented = match.group(4)?.replaceAll('\n', '').trim();
    final pending = match.group(5)?.replaceAll('\n', '').trim();

    output.writeln('| $id | $title | $description | $implemented | $pending |');
  }

  File('artifacts/screen_intents.md').writeAsStringSync(output.toString());
  print('Extracted to artifacts/screen_intents.md');
}
