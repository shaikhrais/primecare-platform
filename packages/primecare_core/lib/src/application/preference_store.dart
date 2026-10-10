/// Persistence port for the shared preference business workflow.
abstract interface class PreferenceStore {
  List<String>? getStringList(String key);
  bool? getBool(String key);
  String? getString(String key);
  Future<bool> setStringList(String key, List<String> value);
  Future<bool> setBool(String key, bool value);
  Future<bool> setString(String key, String value);
  Future<bool> remove(String key);
}
