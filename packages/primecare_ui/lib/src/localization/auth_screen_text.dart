import 'package:flutter/widgets.dart';
import 'package:flutter_core/src/localization/live_screen_text.dart';
import 'auth_screen_text_generated.dart';

String authScreenText(BuildContext context, String key, {bool recovery = false}) {
  final language = Localizations.localeOf(context).languageCode;
  final catalog = recovery ? passwordRecoveryScreenCatalog : authScreenCatalog;
  final fallback = catalog[language]?[key] ?? catalog['en']![key] ?? key;
  return liveScreenText(context, recovery ? 'password_recovery' : 'auth', language, key, fallback);
}
