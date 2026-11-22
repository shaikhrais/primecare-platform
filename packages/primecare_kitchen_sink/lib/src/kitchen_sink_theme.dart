import 'package:flutter/material.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/theme_center_theme_data.dart';

/// Reuse the canonical Theme Center presets; no independent showcase palette.
ThemeData kitchenSinkTheme({bool dark = false}) => applyPersonalThemeData(
  ThemeData(useMaterial3: true),
  PersonalTheme(name: 'Kitchen sink', preset: dark ? 'defaultDark' : 'default'),
);
