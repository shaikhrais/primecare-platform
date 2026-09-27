// Drift database for Clinical Education articles
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'education_database_native.dart' if (dart.library.html) 'education_database_web.dart';

part 'education_database.g.dart';

class Articles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get content => text()();
  TextColumn get category => text()();
}

@DriftDatabase(tables: [Articles])
class EducationDatabase extends _$EducationDatabase {
  EducationDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  // Helper to open native database using drift/ffi

  // Query helpers ----------------------------------------------------------
  Future<List<Article>> searchArticles(String query, {int limit = 20}) async {
    final term = '%${query}%';
    final stmt = customSelect('SELECT * FROM articles WHERE title LIKE ? OR content LIKE ? LIMIT ?',
        variables: [Variable(term), Variable(term), Variable(limit)], readsFrom: {articles});
    return await stmt.map((row) => articles.map(row.data)).get();
  }

  Future<List<Article>> getArticlesByCategory(String category, {int limit = 20, int offset = 0}) async {
    final stmt = customSelect('SELECT * FROM articles WHERE category = ? LIMIT ? OFFSET ?',
        variables: [Variable(category), Variable(limit), Variable(offset)], readsFrom: {articles});
    return await stmt.map((row) => articles.map(row.data)).get();
  }

  Future<List<String>> getAllCategories() async {
    final stmt = customSelect('SELECT DISTINCT category FROM articles ORDER BY category ASC', readsFrom: {articles});
    final rows = await stmt.get();
    return rows.map((row) => row.data['category'] as String).toList();
  }

  Future<Article?> findArticleByTitle(String title) async {
    final stmt = customSelect('SELECT * FROM articles WHERE title = ? COLLATE NOCASE LIMIT 1',
        variables: [Variable(title)], readsFrom: {articles});
    final rows = await stmt.get();
    if (rows.isEmpty) return null;
    return articles.map(rows.first.data);
  }

  Future<List<String>> getAllArticleTitles() async {
    final stmt = customSelect('SELECT title FROM articles', readsFrom: {articles});
    final rows = await stmt.get();
    return rows.map((row) => row.data['title'] as String).toList();
  }

  Future<Article?> getRandomArticle() async {
    final stmt = customSelect('SELECT * FROM articles ORDER BY RANDOM() LIMIT 1', readsFrom: {articles});
    final rows = await stmt.get();
    if (rows.isEmpty) return null;
    return articles.map(rows.first.data);
  }

  static Future<EducationDatabase> openNative() => openNativeImpl();
}
