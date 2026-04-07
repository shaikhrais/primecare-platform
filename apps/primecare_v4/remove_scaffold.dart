import 'dart:io';

void main() {
  final dir = Directory('lib/offices');
  final files = dir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'));

  int changedCount = 0;
  for (final file in files) {
    String content = file.readAsStringSync();

    // Process all occurrences of return Scaffold(
    bool changed = false;

    while (content.contains('return Scaffold(')) {
      int startIndex = content.indexOf('return Scaffold(');

      int scaffoldStart = content.indexOf('Scaffold(', startIndex);
      if (scaffoldStart == -1) break;

      int bodyStart = content.indexOf('body:', scaffoldStart);
      if (bodyStart == -1) {
        // It could be missing a body? Just break to avoid infinite loop
        break;
      }

      // Find the closing bracket of Scaffold( ... )
      int openBrackets = 0;
      int endIndex = -1;
      for (int i = scaffoldStart + 'Scaffold'.length; i < content.length; i++) {
        if (content[i] == '(') openBrackets++;
        if (content[i] == ')') openBrackets--;

        if (openBrackets == 0) {
          endIndex = i;
          break;
        }
      }

      if (endIndex != -1) {
        int expStart = bodyStart + 'body:'.length;
        // expression is from expStart to endIndex - 1
        String bodyExp = content.substring(expStart, endIndex).trim();

        // replace the whole return Scaffold(...) with return bodyExp
        String before = content.substring(0, startIndex);
        String after = content.substring(endIndex + 1);

        content = before + 'return ' + bodyExp + after;
        changed = true;
      } else {
        break;
      }
    }

    if (changed) {
      file.writeAsStringSync(content);
      changedCount++;
      print('Changed: ${file.path}');
    }
  }

  print('Total files changed: $changedCount');
}
