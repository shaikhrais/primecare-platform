// Legacy composition retains the existing authenticated provider identity.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_models/src/models/auth_state.dart';
import 'package:primecare_theme_preferences/theme/theme_settings_provider.dart';
import '../auth_service.dart' show authProvider;
export 'package:primecare_theme_preferences/theme/theme_settings_provider.dart';

class ThemeSettingsNotifier extends ThemeSettingsNotifierBase {
  @override AuthState watchThemeAccount() => ref.watch(authProvider);
  @override AuthState readThemeAccount() => ref.read(authProvider);
}
final themeSettingsProvider=NotifierProvider<ThemeSettingsNotifier,ThemeSettingsState>(ThemeSettingsNotifier.new);
