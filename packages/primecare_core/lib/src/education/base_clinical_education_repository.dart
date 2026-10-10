import 'dart:convert';
import 'package:primecare_models/primecare_models.dart';

/// Shared education rules; platform adapters supply asset and storage access.
abstract class BaseClinicalEducationRepository {
  bool get usesBundledArticles;
  Future<String> loadBundledArticles();
  Future<List<ClinicalArticle>> searchStoredArticles(
    String query, {
    int limit = 20,
  });
  Future<List<ClinicalArticle>> getStoredArticlesByCategory(
    String category, {
    int limit = 20,
    int offset = 0,
  });
  Future<List<String>> getStoredCategories();
  Future<ClinicalArticle?> findStoredArticleByTitle(String title);
  Future<List<String>> getStoredArticleTitles();
  Future<ClinicalArticle?> getStoredRandomArticle();

  Future<List<ClinicalArticle>> searchArticles(
    String query, {
    int limit = 20,
  }) async {
    if (usesBundledArticles) {
      final jsonStr = await loadBundledArticles();
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

    return searchStoredArticles(query, limit: limit);
  }

  Future<List<ClinicalArticle>> getArticlesByCategory(
    String category, {
    int limit = 20,
    int offset = 0,
  }) async {
    if (usesBundledArticles) {
      final jsonStr = await loadBundledArticles();
      final List<dynamic> data = jsonDecode(jsonStr) as List<dynamic>;
      final all = data
          .map((json) => ClinicalArticle.fromJson(json as Map<String, dynamic>))
          .where((a) => a.category == category)
          .toList();
      if (offset >= all.length) return [];
      return all.skip(offset).take(limit).toList();
    }

    return getStoredArticlesByCategory(category, limit: limit, offset: offset);
  }

  Future<List<String>> getAllCategories() async {
    if (usesBundledArticles) {
      final jsonStr = await loadBundledArticles();
      final List<dynamic> data = jsonDecode(jsonStr) as List<dynamic>;
      final categories = data
          .map((json) => (json as Map<String, dynamic>)['category'] as String)
          .toSet()
          .toList();
      categories.sort();
      return categories;
    }

    return getStoredCategories();
  }

  Future<ClinicalArticle?> findArticleByTitle(String title) async {
    return findStoredArticleByTitle(title);
  }

  Future<List<String>> getAllArticleTitles() async {
    return getStoredArticleTitles();
  }

  Future<ClinicalArticle?> getRandomArticle() async {
    return getStoredRandomArticle();
  }
}
