import 'package:test/test.dart';
import 'package:primecare_core/primecare_core.dart';

class _Language extends BaseLanguageWorkflow {
  int notifications = 0;
  @override
  void changed() => notifications++;
}
class _Catalog extends BaseTextCatalog {
  const _Catalog(String language) : super(language, const {'en':{'count':'{total} users'},'es':{'count':'{total} usuarios'}});
}
void main() {
  test('Inherited language control notifies only actual changes', () {
    final language=_Language();expect(language.language,SupportedLanguage.en);
    language.selectLanguage(SupportedLanguage.en);expect(language.notifications,0);
    language.selectLanguage(SupportedLanguage.es);expect(language.language,SupportedLanguage.es);expect(language.notifications,1);
  });
  test('Inherited catalog substitutes arguments, falls back and rejects unknown keys', () {
    expect(const _Catalog('es').text('count',{'total':3}),'3 usuarios');
    expect(const _Catalog('fr').text('count',{'total':3}),'3 users');
    expect(()=>const _Catalog('en').text('missing'),throwsArgumentError);
  });
}
