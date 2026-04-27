import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageProvider extends StateNotifier<String> {
  LanguageProvider() : super('en');

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

final languageProvider = StateNotifierProvider<LanguageProvider, String>((ref) => LanguageProvider());
