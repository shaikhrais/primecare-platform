import 'package:flutter/widgets.dart';
import 'package:flutter_core/src/localization/live_screen_text.dart';

const _messages = <String, Map<String, String>>{
  'en': {'dashboard': 'The patient dashboard is not available yet.', 'profile': 'The patient profile is not available yet.'},
  'fr': {'dashboard': 'Le tableau de bord du patient n’est pas encore disponible.', 'profile': 'Le profil du patient n’est pas encore disponible.'},
  'es': {'dashboard': 'El panel del paciente aún no está disponible.', 'profile': 'El perfil del paciente aún no está disponible.'},
};

String patientUnavailableText(BuildContext context, String screen) {
  final language = Localizations.maybeLocaleOf(context)?.languageCode ?? 'en';
  final fallback = _messages[language]?[screen] ?? _messages['en']![screen];
  if (fallback == null) throw ArgumentError.value(screen, 'screen', 'Unknown patient screen');
  return liveScreenText(context, 'patient_unavailable', language, screen, fallback);
}
