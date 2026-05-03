import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageProvider extends Notifier<String> {
  @override
  String build() => 'en';

  void setLanguage(String lang) => state = lang;

  String translate(String key) {
    final Map<String, Map<String, String>> translations = {
      'en': {
        'dashboard': 'Dashboard',
        'users': 'User Management',
        'active_users': 'Active Users',
      },
      'fr': {
        'dashboard': 'Tableau de bord',
        'users': 'Gestion des utilisateurs',
        'active_users': 'Utilisateurs actifs',
      },
    };

    return translations[state]?[key] ?? key;
  }
}

final languageProvider = NotifierProvider<LanguageProvider, String>(LanguageProvider.new);
