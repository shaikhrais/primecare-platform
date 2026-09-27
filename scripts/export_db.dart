import 'dart:convert';
import 'dart:io';
import 'package:sqlite3/sqlite3.dart';

void main() {
  final dbPath = 'packages/flutter_core/assets/db/precision_education.db';
  print('Opening $dbPath');
  final db = sqlite3.open(dbPath);

  final result = db.select('SELECT * FROM articles');
  print('Found ${result.length} articles');

  final List<Map<String, dynamic>> articles = [];
  for (final row in result) {
    articles.add({
      'id': row['id'],
      'title': row['title'],
      'category': row['category'],
      'content': row['content'],
      'tags': row['tags'],
    });
  }

  final jsonStr = jsonEncode(articles);
  File('packages/flutter_core/assets/db/precision_education.json')
      .writeAsStringSync(jsonStr);
  print(
      'Successfully exported to JSON (${File('packages/flutter_core/assets/db/precision_education.json').lengthSync()} bytes)',);
}
