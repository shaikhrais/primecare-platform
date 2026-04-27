// Layer: 01_CORE
import 'package:flutter/material.dart';
import 'package:primecare_adapters/primecare_adapters.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../auth_service.dart';

/// Language Provider
/// Manages the currently selected language for the application.

class LanguageNotifier extends Notifier<String> {
  static const _langKey = 'auth_preferred_language';

  @override
  String build() {
    // Watch AuthProvider for source-of-truth language from the user profile
    final authLanguage = ref.watch(
      authProvider.select((s) => s.preferredLanguage),
    );

    if (authLanguage != null && authLanguage.isNotEmpty) {
      return authLanguage;
    }

    // Default to 'en' or potentially a persisted guest preference
    // Note: We don't await SharedPreferences here to keep it synchronous
    // If needed, we can initialize it in a provider or just use a default
    return 'en';
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
