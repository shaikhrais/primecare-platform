import 'dart:io';

void main() {
  final dir = Directory('lib/src');
  final files = dir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'));

  int count = 0;
  for (final file in files) {
    String content = file.readAsStringSync();
    if (content.contains('const IntelligenceInsight(')) {
      content = content.replaceAll(
        'const IntelligenceInsight(',
        'IntelligenceInsight(',
      );
      file.writeAsStringSync(content);
      count++;
    }
  }
  print('Removed const from IntelligenceInsight in $count files.');
}
