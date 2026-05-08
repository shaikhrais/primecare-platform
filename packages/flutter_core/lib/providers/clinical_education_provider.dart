import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

import '../models/clinical_article.dart';

part 'clinical_education_provider.g.dart';

class ClinicalEducationRepository {
  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'precision_education.db');

    // Check if the database exists
    final exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print('Creating new copy from asset');

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(
        join('assets', 'db', 'precision_education.db'),
      );
      List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    }

    // open the database
    return await openDatabase(path, readOnly: true);
  }

  Future<List<ClinicalArticle>> searchArticles(
    String query, {
    int limit = 20,
  }) async {
    final db = await database;
    final searchTerm = '%$query%';

    final List<Map<String, dynamic>> maps = await db.query(
      'articles',
      where: 'title LIKE ? OR content LIKE ?',
      whereArgs: [searchTerm, searchTerm],
      limit: limit,
    );

    return List.generate(maps.length, (i) {
      return ClinicalArticle.fromJson(maps[i]);
    });
  }

  Future<List<ClinicalArticle>> getArticlesByCategory(
    String category, {
    int limit = 20,
    int offset = 0,
  }) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'articles',
      where: 'category = ?',
      whereArgs: [category],
      limit: limit,
      offset: offset,
    );

    return List.generate(maps.length, (i) {
      return ClinicalArticle.fromJson(maps[i]);
    });
  }

  Future<ClinicalArticle?> findArticleByTitle(String title) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'articles',
      where: 'title = ? COLLATE NOCASE',
      whereArgs: [title],
      limit: 1,
    );

    if (maps.isEmpty) return null;
    return ClinicalArticle.fromJson(maps.first);
  }

  Future<List<String>> getAllArticleTitles() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'articles',
      columns: ['title'],
    );
    return maps.map((m) => m['title'] as String).toList();
  }

  Future<ClinicalArticle?> getRandomArticle() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'articles',
      orderBy: 'RANDOM()',
      limit: 1,
    );

    if (maps.isEmpty) return null;
    return ClinicalArticle.fromJson(maps.first);
  }
}

@riverpod
ClinicalEducationRepository clinicalEducationRepository(Ref ref) {
  return ClinicalEducationRepository();
}

@riverpod
Future<ClinicalArticle?> clinicalTip(Ref ref) async {
  final repository = ref.watch(clinicalEducationRepositoryProvider);
  return repository.getRandomArticle();
}

@riverpod
Future<List<ClinicalArticle>> clinicalArticlesSearch(
  Ref ref,
  String query,
) async {
  if (query.isEmpty) return [];
  final repository = ref.watch(clinicalEducationRepositoryProvider);
  return repository.searchArticles(query);
}
