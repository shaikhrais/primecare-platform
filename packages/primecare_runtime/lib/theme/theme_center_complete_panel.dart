// Legacy composition retains the authenticated provider bindings.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_models/src/models/auth_state.dart';
import 'package:primecare_theme_preferences/theme/theme_center_complete_panel.dart';
import '../auth_service.dart' show authProvider;
import 'theme_settings_provider.dart';

class ThemeCenterCompletePanel extends ThemeCenterCompletePanelBase {
  const ThemeCenterCompletePanel({super.key,super.actionsOnly=false});
  @override AuthState watchAccount(WidgetRef ref) => ref.watch(authProvider);
  @override AuthState readAccount(WidgetRef ref) => ref.read(authProvider);
  @override ThemeSettingsState watchSettings(WidgetRef ref) => ref.watch(themeSettingsProvider);
  @override ThemeSettingsState readSettings(WidgetRef ref) => ref.read(themeSettingsProvider);
  @override ThemeSettingsNotifierBase readNotifier(WidgetRef ref) => ref.read(themeSettingsProvider.notifier);
}
