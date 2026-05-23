// Governance - Category: controller | Purpose: Core implementation file for the Language Provider platform logic.
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
        'governance': 'Governance',
        'security': 'Security',
        'compliance': 'Compliance',
        'settings': 'Settings',
      },
      'fr': {
        'dashboard': 'Tableau de bord',
        'users': 'Gestion des utilisateurs',
        'active_users': 'Utilisateurs actifs',
        'governance': 'Gouvernance',
        'security': 'Sécurité',
        'compliance': 'Conformité',
        'settings': 'Paramètres',
      },
      'es': {
        'dashboard': 'Tablero',
        'users': 'Gestión de usuarios',
        'active_users': 'Usuarios activos',
        'governance': 'Gobernanza',
        'security': 'Seguridad',
        'compliance': 'Cumplimiento',
        'settings': 'Configuración',
      },
      'ar': {
        'dashboard': 'لوحة القيادة',
        'users': 'إدارة المستخدمين',
        'active_users': 'المستخدمون النشطون',
        'governance': 'الحوكمة',
        'security': 'الأمن',
        'compliance': 'الامتثال',
        'settings': 'الإعدادات',
      },
    };

    return translations[state]?[key] ?? key;
  }
}

final languageProvider = NotifierProvider<LanguageProvider, String>(
  LanguageProvider.new,
);
