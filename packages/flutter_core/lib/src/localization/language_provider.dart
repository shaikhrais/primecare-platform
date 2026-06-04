// Governance - Category: controller | Purpose: Layer: 01_CORE Language Provider Manages the currently selected language for the application. Watch AuthProvider for ...
// Layer: 01_CORE
import 'package:flutter_core/flutter_core.dart';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

/// Language Provider
/// Manages the currently selected language for the application.

class LanguageNotifier extends Notifier<String> {
  static const _langKey = 'auth_preferred_language';

  @override
  String build() {
    // Check if we have SharedPreferences to read guest persistence first!
    final prefs = ref.watch(sharedPreferencesProvider);
    final guestLanguage = prefs?.getString(_langKey);

    // Watch AuthProvider for source-of-truth language from the user profile
    final authLanguage = ref.watch(
      authProvider.select((s) => s.preferredLanguage),
    );

    if (authLanguage != null && authLanguage.isNotEmpty) {
      if (guestLanguage != authLanguage) {
        Future.microtask(() async {
          final p = await SharedPreferences.getInstance();
          await p.setString(_langKey, authLanguage);
          await p.setBool('auth_language_selected', true);
        });
      }
      return authLanguage;
    }

    if (guestLanguage != null && guestLanguage.isNotEmpty) {
      return guestLanguage;
    }

    // Try to resolve dynamic language configs from the active app tenant
    String defaultLang = 'en';
    List<String> supportedLocales = const ['en', 'fr', 'es'];
    try {
      final app = ref.watch(platformApplicationProvider);
      final themeKey = app.appId.replaceAll('primecare_', '');
      final palette = ThemeConfig.getAppPalette(themeKey);
      defaultLang = palette.defaultLanguage;
      supportedLocales = palette.supportedLanguages;
    } catch (_) {
      // Fallback if platformApplicationProvider is not registered
    }

    // Read the browser's preferred language code dynamically
    final browserLanguage = PlatformDispatcher.instance.locale.languageCode.toLowerCase();

    return supportedLocales.contains(browserLanguage) ? browserLanguage : defaultLang;
  }

  Future<void> setLanguage(String langCode) async {
    if (state == langCode) return;

    // Update local state (this will notify listeners immediately)
    state = langCode;

    // Persist and update the user profile via AuthProvider
    await ref.read(authProvider.notifier).updatePreferredLanguage(langCode);

    // Also save to SharedPreferences for guest/persistent use
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_langKey, langCode);
    await prefs.setBool('auth_language_selected', true);
  }
}

final languageProvider = NotifierProvider<LanguageNotifier, String>(
  LanguageNotifier.new,
);

/// Extension on BuildContext to easily translate PrimeCareLabel using the native flutter Localizations locale.
extension PrimeCareLabelTranslation on PrimeCareLabel {
  String translate(BuildContext context) {
    return get(Localizations.localeOf(context).languageCode);
  }
}

/// Extension on BuildContext to retrieve the active language code via the app's routing / standard flutter Localizations context,
/// or through the provider if you are in a ConsumerWidget.
extension LanguageContext on BuildContext {
  String get langCode => Localizations.localeOf(this).languageCode;
}
