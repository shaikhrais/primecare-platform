import 'package:shared_preferences/shared_preferences.dart';
import 'workspace_controller.dart';

/// One device-local preference adapter for every native host. No sync or API grants.
class SharedWorkspacePreferences implements WorkspacePreferences {
  final SharedPreferences preferences;
  SharedWorkspacePreferences(this.preferences);
  @override Future<String?> read(String key) async => preferences.getString(key);
  @override Future<void> write(String key, String value) async {
    if (!await preferences.setString(key, value)) throw StateError('Unable to save workspace layout');
  }
}
