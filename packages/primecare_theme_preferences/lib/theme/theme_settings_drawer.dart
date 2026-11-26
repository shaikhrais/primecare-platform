import 'package:flutter/material.dart';

/// Every portal uses the shared visual Theme Settings configurator.
abstract class ThemeSettingsDrawerBase extends StatelessWidget {
  final String tenantDefaultPreset;
  const ThemeSettingsDrawerBase({super.key,required this.tenantDefaultPreset});
  Widget buildThemeCenter(String tenantDefaultPreset);
  @override Widget build(BuildContext context)=>buildThemeCenter(tenantDefaultPreset);
}
