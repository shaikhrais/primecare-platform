import 'package:flutter/material.dart';
import 'package:primecare_theme/primecare_theme.dart';

/// Reuse the canonical Theme Center presets; no independent showcase palette.
ThemeData kitchenSinkTheme({bool dark = false}) => applyPersonalThemeData(
  ThemeData(useMaterial3: true),
  PersonalTheme(name: 'Kitchen sink', preset: dark ? 'defaultDark' : 'default'),
);
