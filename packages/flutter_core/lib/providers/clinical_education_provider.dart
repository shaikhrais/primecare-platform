// Governance - Category: controller | Purpose: Core implementation file for the Clinical Education Provider platform logic.
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/database/education_database.dart';

import '../models/clinical_article.dart';

part 'clinical_education_provider.g.dart';

class ClinicalEducationRepository {
  EducationDatabase? _db;

  Future<EducationDatabase> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<EducationDatabase> _initDatabase() async {
    // Reuse existing native implementation that opens the SQLite file via drift/ffi.
    return await EducationDatabase.openNative();
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

    // Use Drift query helper
    final List<ArticlesData> results = await db.searchArticles(query, limit: limit);
    return results.map((a) => ClinicalArticle.fromJson(a.toJson())).toList();

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

    // Use Drift query helper
    final List<ArticlesData> results = await db.getArticlesByCategory(category, limit: limit, offset: offset);
    return results.map((a) => ClinicalArticle.fromJson(a.toJson())).toList();

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
    // Use Drift query helper
    final List<String> categories = await db.getAllCategories();
    return categories;

    return List.generate(maps.length, (i) {
      return maps[i]['category'] as String;
    });
  }

  Future<ClinicalArticle?> findArticleByTitle(String title) async {
    final db = await database;

    final ArticlesData? article = await db.findArticleByTitle(title);
    if (article == null) return null;
    return ClinicalArticle.fromJson(article.toJson());
  }

  Future<List<String>> getAllArticleTitles() async {
    final db = await database;
    final List<String> titles = await db.getAllArticleTitles();
    return titles;
  }

  Future<ClinicalArticle?> getRandomArticle() async {
    final db = await database;
    final ArticlesData? article = await db.getRandomArticle();
    if (article == null) return null;
    return ClinicalArticle.fromJson(article.toJson());
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
