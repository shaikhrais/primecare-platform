// Legacy composition supplies the existing Theme Center widget.
import 'package:flutter/material.dart';
import 'package:primecare_theme_preferences/theme/theme_settings_drawer.dart';
import '../../theme/prime_theme_center.dart';

class ThemeSettingsDrawer extends ThemeSettingsDrawerBase {
  const ThemeSettingsDrawer({super.key,required super.tenantDefaultPreset});
  @override Widget buildThemeCenter(String tenantDefaultPreset) => PrimeThemeCenter(tenantDefaultPreset:tenantDefaultPreset);
}
