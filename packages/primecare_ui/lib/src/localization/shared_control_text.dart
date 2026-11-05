import 'package:flutter/widgets.dart';
import 'package:flutter_core/src/localization/live_screen_text.dart';

/// Shared control text follows the app locale and supports live text overrides.
const _sharedControlText = <String, Map<String, String>>{
  'en': {'dashboard_error': 'Operational Anomaly Detected', 'retry': 'Retry Hydration', 'active_secure': 'ACTIVE & SECURE', 'utilization': 'Utilization'},
  'fr': {'dashboard_error': 'Anomalie de fonctionnement détectée', 'retry': 'Réessayer', 'active_secure': 'ACTIF ET SÉCURISÉ', 'utilization': 'Utilisation'},
  'es': {'dashboard_error': 'Se detectó una anomalía operativa', 'retry': 'Reintentar', 'active_secure': 'ACTIVO Y SEGURO', 'utilization': 'Utilización'},
};

String sharedControlText(BuildContext context, String key) {
  final language = Localizations.maybeLocaleOf(context)?.languageCode ?? 'en';
  final fallback = _sharedControlText[language]?[key] ?? _sharedControlText['en']![key];
  if (fallback == null) throw ArgumentError.value(key, 'key', 'Unknown shared control text');
  return liveScreenText(context, 'shared_controls', language, key, fallback);
}
