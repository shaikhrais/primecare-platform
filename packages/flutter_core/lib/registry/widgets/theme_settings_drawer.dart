import 'package:flutter/material.dart';
import '../../theme/prime_theme_center.dart';

/// Every portal uses the shared visual Theme Settings configurator.
class ThemeSettingsDrawer extends StatelessWidget {
  final String tenantDefaultPreset;
  const ThemeSettingsDrawer({super.key,required this.tenantDefaultPreset});
  @override Widget build(BuildContext context)=>PrimeThemeCenter(tenantDefaultPreset:tenantDefaultPreset);
}
