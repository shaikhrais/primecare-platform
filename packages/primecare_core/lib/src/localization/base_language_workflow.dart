enum SupportedLanguage { en, es, fr }

/// Pure Dart language control inherited by every UI application adapter.
abstract class BaseLanguageWorkflow {
  SupportedLanguage _language = SupportedLanguage.en;
  SupportedLanguage get language => _language;
  void changed() {}
  void selectLanguage(SupportedLanguage value) {
    if (_language == value) return;
    _language = value;
    changed();
  }
}

abstract class BaseTextCatalog {
  final String languageCode;
  final Map<String, Map<String, String>> catalogs;
  const BaseTextCatalog(this.languageCode, this.catalogs);
  bool containsKey(String key) => catalogs[languageCode]?.containsKey(key) == true || catalogs['en']?.containsKey(key) == true;
  String text(String key, [Map<String, Object> arguments = const {}]) {
    final template = catalogs[languageCode]?[key] ?? catalogs['en']?[key];
    if (template == null) throw ArgumentError('Unknown localization key: $key');
    var value = template;
    for (final entry in arguments.entries) { value = value.replaceAll('{${entry.key}}',entry.value.toString()); }
    return value;
  }
}
