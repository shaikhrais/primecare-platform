import 'dart:convert';
import 'package:primecare_core/primecare_core.dart';
import 'package:test/test.dart';

class MemoryEducation extends BaseClinicalEducationRepository {
  @override
  bool usesBundledArticles = true;
  String? payload;
  Object? error;
  final calls = <Object>[];
  final articles = [
    ClinicalArticle(
      url: 'a',
      title: 'Shoulder',
      category: 'Z',
      content: 'Mobility',
      htmlContent: '',
    ),
    ClinicalArticle(
      url: 'b',
      title: 'Elbow',
      category: 'A',
      content: 'SHOULDER referral',
      htmlContent: '',
    ),
    ClinicalArticle(
      url: 'c',
      title: 'Knee',
      category: 'Z',
      content: 'Exercise',
      htmlContent: '',
    ),
  ];
  @override
  Future<String> loadBundledArticles() async {
    calls.add('asset');
    if (error != null) throw error!;
    return payload ?? jsonEncode(articles.map((a) => a.toJson()).toList());
  }

  @override
  Future<List<ClinicalArticle>> searchStoredArticles(
    String query, {
    int limit = 20,
  }) async {
    calls.add(['search', query, limit]);
    if (error != null) throw error!;
    return articles;
  }

  @override
  Future<List<ClinicalArticle>> getStoredArticlesByCategory(
    String category, {
    int limit = 20,
    int offset = 0,
  }) async {
    calls.add(['category', category, limit, offset]);
    return articles;
  }

  @override
  Future<List<String>> getStoredCategories() async {
    calls.add('categories');
    return ['Z', 'A'];
  }

  @override
  Future<ClinicalArticle?> findStoredArticleByTitle(String title) async {
    calls.add(['title', title]);
    return null;
  }

  @override
  Future<List<String>> getStoredArticleTitles() async {
    calls.add('titles');
    return ['Shoulder'];
  }

  @override
  Future<ClinicalArticle?> getStoredRandomArticle() async {
    calls.add('random');
    return articles.first;
  }
}

void main() {
  test(
    'bundled search preserves case-insensitive title/content matching and order',
    () async {
      final repo = MemoryEducation();
      expect((await repo.searchArticles('sHoUlDeR')).map((a) => a.url), [
        'a',
        'b',
      ]);
      expect((await repo.searchArticles('shoulder', limit: 1)).single.url, 'a');
      expect(await repo.searchArticles('missing'), isEmpty);
      expect(await repo.searchArticles('', limit: 0), isEmpty);
      expect(repo.calls, everyElement('asset'));
    },
  );
  test('category equality pagination and sorted unique categories', () async {
    final repo = MemoryEducation();
    expect(
      (await repo.getArticlesByCategory('Z', limit: 1, offset: 1)).single.url,
      'c',
    );
    expect(await repo.getArticlesByCategory('z'), isEmpty);
    expect(await repo.getArticlesByCategory('Z', offset: 2), isEmpty);
    expect(await repo.getAllCategories(), ['A', 'Z']);
  });
  test('storage arguments and original results survive delegation', () async {
    final repo = MemoryEducation()..usesBundledArticles = false;
    expect(await repo.searchArticles('MiXeD', limit: 7), same(repo.articles));
    expect(
      await repo.getArticlesByCategory('Z', limit: 8, offset: 9),
      same(repo.articles),
    );
    expect(await repo.getAllCategories(), ['Z', 'A']);
    expect(repo.calls, [
      ['search', 'MiXeD', 7],
      ['category', 'Z', 8, 9],
      'categories',
    ]);
  });
  test(
    'title and random operations retain storage path in bundled mode',
    () async {
      final repo = MemoryEducation();
      expect(await repo.findArticleByTitle('Exact'), isNull);
      expect(await repo.getAllArticleTitles(), ['Shoulder']);
      expect(await repo.getRandomArticle(), same(repo.articles.first));
      expect(repo.calls, [
        ['title', 'Exact'],
        'titles',
        'random',
      ]);
    },
  );
  test('asset and storage failures preserve error identity', () async {
    final error = StateError('unavailable');
    final repo = MemoryEducation()..error = error;
    await expectLater(repo.searchArticles('x'), throwsA(same(error)));
    repo.usesBundledArticles = false;
    await expectLater(repo.searchArticles('x'), throwsA(same(error)));
  });
  test('invalid JSON and negative pagination retain errors', () async {
    final repo = MemoryEducation()..payload = '{';
    await expectLater(repo.searchArticles('x'), throwsFormatException);
    repo.payload = null;
    await expectLater(repo.searchArticles('', limit: -1), throwsRangeError);
    await expectLater(
      repo.getArticlesByCategory('Z', offset: -1),
      throwsRangeError,
    );
  });
}
