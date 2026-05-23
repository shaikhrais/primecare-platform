// Governance - Category: controller | Purpose: Core implementation file for the Clinical Education Provider platform logic.
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

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

    final exists = await databaseExists(path);

    if (!exists) {
      print('Creating new copy from asset');
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(
        join('assets', 'db', 'precision_education.db'),
      );
      List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );

      await File(path).writeAsBytes(bytes, flush: true);
    }

    return await openDatabase(path, readOnly: true);
  }

  Future<List<ClinicalArticle>> searchArticles(
    String query, {
    int limit = 20,
  }) async {
    if (kIsWeb) {
      final jsonStr = await rootBundle.loadString(
        'packages/flutter_core/assets/db/precision_education.json',
      );
      final List<dynamic> data = jsonDecode(jsonStr) as List<dynamic>;
      final searchTerm = query.toLowerCase();
      final all = data
          .map((json) => ClinicalArticle.fromJson(json as Map<String, dynamic>))
          .where(
            (a) =>
                a.title.toLowerCase().contains(searchTerm) ||
                a.content.toLowerCase().contains(searchTerm),
          )
          .toList();
      return all.take(limit).toList();
    }

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
    if (kIsWeb) {
      final jsonStr = await rootBundle.loadString(
        'packages/flutter_core/assets/db/precision_education.json',
      );
      final List<dynamic> data = jsonDecode(jsonStr) as List<dynamic>;
      final all = data
          .map((json) => ClinicalArticle.fromJson(json as Map<String, dynamic>))
          .where((a) => a.category == category)
          .toList();
      if (offset >= all.length) return [];
      return all.skip(offset).take(limit).toList();
    }

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

  Future<List<String>> getAllCategories() async {
    if (kIsWeb) {
      final jsonStr = await rootBundle.loadString(
        'packages/flutter_core/assets/db/precision_education.json',
      );
      final List<dynamic> data = jsonDecode(jsonStr) as List<dynamic>;
      final categories = data
          .map((json) => (json as Map<String, dynamic>)['category'] as String)
          .toSet()
          .toList();
      categories.sort();
      return categories;
    }

    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'articles',
      distinct: true,
      columns: ['category'],
      orderBy: 'category ASC',
    );

    return List.generate(maps.length, (i) {
      return maps[i]['category'] as String;
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

// Simple Notifier for stable cross-package access during tests
class ClinicalReferenceDrawerController extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String query) {
    state = query;
  }

  void clearQuery() {
    state = '';
  }

  String get query => state;
}

final clinicalReferenceDrawerControllerProvider =
    NotifierProvider<ClinicalReferenceDrawerController, String>(() {
  return ClinicalReferenceDrawerController();
});
