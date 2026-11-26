// Legacy composition retains the account provider and Theme Center child bindings.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_models/src/models/auth_state.dart';
import 'package:primecare_theme_preferences/theme/prime_theme_center.dart';
import '../auth_service.dart' show authProvider;
import '../registry/widgets/theme_center_panel.dart';
import 'theme_center_complete_panel.dart';
import 'theme_settings_provider.dart';
export 'package:primecare_theme_preferences/theme/prime_theme_center.dart' show PrimeSettingsGroup, PrimeSettingsChoices, PrimeSettingsNumber;

class PrimeThemeCenter extends PrimeThemeCenterBase {
  const PrimeThemeCenter({super.key,required super.tenantDefaultPreset});
  @override AuthState watchAccount(WidgetRef ref) => ref.watch(authProvider);
  @override AuthState readAccount(WidgetRef ref) => ref.read(authProvider);
  @override ThemeSettingsState watchSettings(WidgetRef ref) => ref.watch(themeSettingsProvider);
  @override ThemeSettingsNotifierBase readNotifier(WidgetRef ref) => ref.read(themeSettingsProvider.notifier);
  @override Widget completePanel() => const ThemeCenterCompletePanel(actionsOnly:true);
  @override Widget savedPanel() => const ThemeCenterPanel();
}
