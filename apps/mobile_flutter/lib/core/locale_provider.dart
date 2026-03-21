import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Central Riverpod State binding for EN/FR Native Dual-Language toggling.
final localeProvider = StateProvider<Locale>((ref) {
  // Defaults to English, overridden by SharedPreferences natively.
  return Locale('en');
});
