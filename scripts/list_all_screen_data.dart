import 'dart:io';
import 'dart:convert';

void main() {
  final baseDir = 'apps/primecare_governance/lib/core/governance/registries/';
  final dir = Directory(baseDir);
  if (!dir.existsSync()) {
    print('Error: Directory not found $baseDir');
    return;
  }

  final files = dir.listSync().whereType<File>().where((f) => f.path.endsWith('.dart'));
  final List<Map<String, dynamic>> allScreens = [];

  for (final file in files) {
    final content = file.readAsStringSync();
    
    final screenRegex = RegExp(r"'(SCREEN_[^']+|RECOVERED_[^']+)':\s*(?:const\s+)?ScreenMetadata\(([\s\S]*?)\),", multiLine: true);
    final matches = screenRegex.allMatches(content);

    for (final match in matches) {
      final id = match.group(1)!;
      final screenBlock = match.group(2)!;

      String extract(String key) {
        final reg = RegExp(key + r':\s*([^,]+)');
        final m = reg.firstMatch(screenBlock);
        if (m == null) return '';
        return m.group(1)!.replaceAll("'", '').replaceAll('"', '').trim();
      }

      int countList(String key) {
        final listRegex = RegExp(key + r':\s*\[([\s\S]*?)\]');
        final listMatch = listRegex.firstMatch(screenBlock);
        if (listMatch == null) return 0;
        final listBody = listMatch.group(1)!;
        if (listBody.trim().isEmpty) return 0;
        return RegExp("['" + '"' + ']').allMatches(listBody).length ~/ 2;
      }

      int implCount = countList('implementedComponents');
      int pendCount = countList('pendingComponents');
      int legacyCount = countList('components');
      
      allScreens.add({
        'id': id,
        'title': extract('title'),
        'office': extract('office'),
        'lifecycle': extract('lifecycleStatus').split('.').last,
        'components': implCount > 0 ? implCount : (pendCount > 0 ? pendCount : legacyCount),
        'path': file.path.replaceAll('\\', '/'),
      });
    }
  }

  final jsonOutput = jsonEncode(allScreens);
  File('artifacts/all_screens_data.json').writeAsStringSync(jsonOutput);
  
  final markdown = StringBuffer();
  markdown.writeln('# PrimeCare Screen Registry Audit');
  markdown.writeln('');
  markdown.writeln('| Office | Title | ID | Status | Components | Path |');
  markdown.writeln('| :--- | :--- | :--- | :--- | :--- | :--- |');
  for (final s in allScreens) {
    markdown.writeln('| ${s['office']} | ${s['title']} | ${s['id']} | ${s['lifecycle']} | ${s['components']} | ${s['path']} |');
  }
  
  File('artifacts/all_screens_data.md').writeAsStringSync(markdown.toString());

  final int completedCount = allScreens.where((s) => s['lifecycle'] == 'completed').length;
  final int backlogCount = allScreens.length - completedCount;

  print('Total screens audited: ${allScreens.length}');
  print('Completed: $completedCount');
  print('Backlog: $backlogCount');
}
