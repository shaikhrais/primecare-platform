import 'package:flutter/material.dart';
import 'theme_center_options_generated.dart';

/// Display text is localized; stored font/color identifiers remain stable.
String themeCenterOption(BuildContext context, String key, {String? name}) {
  final language = Localizations.localeOf(context).languageCode;
  final catalog = themeCenterOptions[language] ?? themeCenterOptions['en']!;
  final text = catalog[key];
  if (text == null) throw ArgumentError.value(key, 'key', 'Unknown theme option');
  if (key == 'copyName') {
    if (name == null) throw ArgumentError('Theme name is required');
    return text.replaceAll('{name}', name);
  }
  return text;
}
