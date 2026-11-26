// Legacy composition retains live localization and account provider identities.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_theme_preferences/theme/theme_center_panel.dart';
import '../../src/localization/live_screen_text.dart';
import '../../theme/theme_library_provider.dart';
import '../../theme/theme_settings_provider.dart';

String themeCenterText(BuildContext context,String key,{Map<String,String> args=const {}}) =>
  resolvedThemeCenterText(liveScreenText,context,key,args:args);

class PrimeToolbarTextScale extends PrimeToolbarTextScaleBase {
  const PrimeToolbarTextScale({super.key,required super.foreground});
  @override String themeCenterText(BuildContext context,String key,{Map<String,String> args=const {}}) => resolvedThemeCenterText(liveScreenText,context,key,args:args);
  @override ThemeSettingsState watchSettings(WidgetRef ref) => ref.watch(themeSettingsProvider);
  @override PersonalThemeSettingsSession bindSettings(WidgetRef ref) => ref.read(themeSettingsProvider.notifier).bindAccount();
}

class ThemeCenterPanel extends ThemeCenterPanelBase {
  const ThemeCenterPanel({super.key});
  @override String themeCenterText(BuildContext context,String key,{Map<String,String> args=const {}}) => resolvedThemeCenterText(liveScreenText,context,key,args:args);
  @override ThemeSettingsState watchSettings(WidgetRef ref) => ref.watch(themeSettingsProvider);
  @override List<SavedPersonalTheme> watchLibrary(WidgetRef ref) => ref.watch(themeLibraryProvider);
  @override PersonalThemeSettingsSession bindSettings(WidgetRef ref) => ref.read(themeSettingsProvider.notifier).bindAccount();
  @override ThemeLibrarySession bindLibrary(WidgetRef ref) => ref.read(themeLibraryProvider.notifier).bindAccount();
}
