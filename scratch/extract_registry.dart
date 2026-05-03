import 'dart:io';

void main() {
  final file = File('c:\\Users\\Admin2\\Documents\\GitHub\\primecare-platform\\apps\\primecare_governance\\lib\\core\\governance\\screen_registry.dart');
  final lines = file.readAsLinesSync();
  
  String? currentId;
  for (final line in lines) {
    if (line.contains("id: '")) {
      currentId = line.split("'")[1];
    }
    if (line.contains("title: '") && currentId != null) {
      final title = line.split("'")[1];
      print('$currentId: $title');
      currentId = null;
    }
  }
}
