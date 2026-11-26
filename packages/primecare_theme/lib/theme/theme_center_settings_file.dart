import 'dart:convert';
import '../workspace/workspace_layout.dart';
import 'theme_settings_state.dart';

/// Complete current presentation profile, excluding auth, routes and identities.
class ThemeCenterSettingsFile {
  final ThemeSettingsState appearance;
  final WorkspaceLayout layout;
  ThemeCenterSettingsFile({required ThemeSettingsState appearance, required WorkspaceLayout layout})
    : appearance = ThemeSettingsState.fromJson(appearance.toJson()),
      layout = WorkspaceLayout.fromJson(layout.toJson(), layout.panels.keys);
  factory ThemeCenterSettingsFile.parse(String source, Iterable<String> panelIds) {
    if(utf8.encode(source).length > 65536) throw const FormatException('Settings file too large');
    final raw=jsonDecode(source);
    if(raw is! Map || raw.length!=4 || raw['version']!=1 || raw['kind']!='primecare-theme-center' ||
      !raw.containsKey('appearance') || !raw.containsKey('layout')) throw const FormatException('Invalid settings file');
    return ThemeCenterSettingsFile(appearance:ThemeSettingsState.fromJson(raw['appearance']),
      layout:WorkspaceLayout.fromJson(raw['layout'],panelIds));
  }
  String exportJson() => const JsonEncoder.withIndent('  ').convert({
    'version':1,'kind':'primecare-theme-center','appearance':appearance.toJson(),'layout':layout.toJson()});
}
