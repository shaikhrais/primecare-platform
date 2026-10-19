import 'package:primecare_models/primecare_models.dart';
import 'package:test/test.dart';

void main() {
  test('user identity and omitted copy fields retain their original values', () {
    final user = UserModel(id: 'user-12', firstName: 'A', lastName: 'B',
      email: 'a@example.test', role: 'original-role', status: 'Active', office: 'Office');
    final BaseEntity<String> entity = user;
    final changed = user.copyWith(firstName: 'Changed', status: 'Inactive');
    expect(entity.id, 'user-12');
    expect(user.name, 'A B');
    expect(changed.name, 'Changed B');
    expect(changed.id, user.id);
    expect(changed.email, user.email);
    expect(changed.role, user.role);
    expect(changed.office, user.office);
    expect(changed.status, 'Inactive');
    expect(user.status, 'Active');
    expect(user.copyWith(firstName: null).firstName, 'A');
  });

  test('article wire keys and generated equality/copy remain compatible', () {
    final payload = <String, dynamic>{'url': 'https://example.test/article',
      'title': 'Original', 'category': 'Clinical', 'content': 'Body',
      'html_content': '<p>Body</p>'};
    final article = ClinicalArticle.fromJson(payload);
    expect(article.toJson(), payload);
    expect(article, ClinicalArticle.fromJson(payload));
    expect(article.copyWith(title: 'Changed').title, 'Changed');
    expect(article.title, 'Original');
    expect(article.summary, 'Body');
    expect(() => ClinicalArticle.fromJson({...payload, 'html_content': null}), throwsA(isA<TypeError>()));
  });

  test('article summary retains the 300-character boundary and trimming', () {
    ClinicalArticle article(String content) => ClinicalArticle(url: 'url', title: 'Title',
      category: 'Clinical', content: content, htmlContent: '');
    expect(article('a' * 300).summary, 'a' * 300);
    expect(article('a' * 301).summary, '${'a' * 300}...');
    expect(article('${'a' * 299}  end').summary, '${'a' * 299}...');
  });
}
