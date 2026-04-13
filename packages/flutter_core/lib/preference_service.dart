import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Enterprise Preference Engine for Role-Based Personalization.
/// Handles persistent state for Favorite Widgets, PIN visibility, and Workspace layouts.
class PreferenceService {
  final SharedPreferences _prefs;

  PreferenceService(this._prefs);

  static const String _favoritesPrefix = 'pref_favorites_';
  static const String _pinPrefix = 'pref_pin_';
  static const String _layoutPrefix = 'pref_layout_';

  /// Returns the list of Favorite Widget IDs for a specific role.
  List<String> getFavorites(String role) {
    return _prefs.getStringList('$_favoritesPrefix$role') ?? [];
  }

  /// Toggles a widget ID in the favorites list for a role.
  Future<void> toggleFavorite(String role, String widgetId) async {
    final current = getFavorites(role);
    if (current.contains(widgetId)) {
      current.remove(widgetId);
    } else {
      current.add(widgetId);
    }
    await _prefs.setStringList('$_favoritesPrefix$role', current);
  }

  /// Sets whether a specific component/feature is PIN'd to the top for a role.
  bool isPinned(String role, String componentId) {
    return _prefs.getBool('$_pinPrefix${role}_$componentId') ?? false;
  }

  Future<void> setPinned(String role, String componentId, bool pinned) async {
    await _prefs.setBool('$_pinPrefix${role}_$componentId', pinned);
  }

  /// Persists custom layout configuration as a JSON string.
  Future<void> saveLayoutConfig(
    String role,
    Map<String, dynamic> config,
  ) async {
    await _prefs.setString('$_layoutPrefix$role', jsonEncode(config));
  }

  Map<String, dynamic>? getLayoutConfig(String role) {
    final raw = _prefs.getString('$_layoutPrefix$role');
    if (raw == null) return null;
    try {
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  /// Clears all role-based personalization (e.g., on logout if requested).
  Future<void> clearRolePreferences(String role) async {
    await _prefs.remove('$_favoritesPrefix$role');
    await _prefs.remove('$_layoutPrefix$role');
    // Note: PINs are usually individual, cleaning them all would require key scanning.
  }
}

/// Provider for the global PreferenceService.
/// Requires SharedPreferences to be pre-initialized or initialized via a Provider override.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider must be overridden in the ProviderScope',
  );
});

final preferenceServiceProvider = Provider<PreferenceService>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return PreferenceService(prefs);
});
