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
  String text(String key, [Map<String, Object> arguments = const {}]) {
    var value = catalogs[languageCode]?[key] ?? catalogs['en']?[key];
    if (value == null) throw ArgumentError('Unknown localization key: $key');
    for (final entry in arguments.entries) { value = value.replaceAll('{${entry.key}}',entry.value.toString()); }
    return value;
  }
}
