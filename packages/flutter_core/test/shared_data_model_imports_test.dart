import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/models/clinical_article.dart' as legacy_article;
import 'package:flutter_core/providers/user_management_provider.dart' as legacy_user;
import 'package:primecare_models/primecare_models.dart' as shared;

void main() {
  test('legacy Flutter paths expose the canonical shared data classes', () {
    final legacy_user.UserModel user = shared.UserModel(id: 'user-12', firstName: 'A',
      lastName: 'B', email: 'a@test', role: 'Role', status: 'Active', office: 'Office');
    final legacy_article.ClinicalArticle article = shared.ClinicalArticle(url: 'url',
      title: 'Title', category: 'Clinical', content: 'Body', htmlContent: '');
    final shared.UserModel canonicalUser = user;
    final shared.ClinicalArticle canonicalArticle = article;
    expect(canonicalUser, same(user));
    expect(canonicalArticle, same(article));
  });
}
