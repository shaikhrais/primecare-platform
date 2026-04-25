import 'dart:io';

void main() {
  final dir = Directory('lib/src');
  final files = dir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'));

  for (final file in files) {
    var content = file.readAsStringSync();
    var changed = false;

    if (content.contains('Future.delayed(')) {
      content = content.replaceAll('Future.delayed(', 'Future<void>.delayed(');
      changed = true;
    }

    // remove unused route variables if they exist
    // Just replace "const route = '...';" with "" if it's unused. We don't have an AST here.
    // Let's do it manually or simply comment it out.
    // "const route = 'RECEPTIONIST';"
    // Actually, I can just replace `const route = ` with `// const route = `
    // Wait, some are used!
    if (changed) {
      file.writeAsStringSync(content);
      print('Fixed \${file.path}');
    }
  }
}
