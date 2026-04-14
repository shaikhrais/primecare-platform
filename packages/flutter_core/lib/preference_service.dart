import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'telemetry_service.dart';

/// Enterprise Preference Engine for Role-Based Personalization.
/// Handles persistent state for Favorite Widgets, PIN visibility, and Workspace layouts.
class PreferenceService {
  final Ref _ref;
  final SharedPreferences _prefs;

  PreferenceService(this._ref, this._prefs);

  static const String _favoritesPrefix = 'pref_favorites_';
  static const String _pinPrefix = 'pref_pin_';
  static const String _layoutPrefix = 'pref_layout_';

  /// Returns the list of Favorite Widget IDs for a specific role.
  List<String> getFavorites(String role) {
    return _prefs.getStringList('$_favoritesPrefix$role') ?? [];
  }

  /// Toggles a widget ID in the favorites list for a role.
  Future<void> toggleFavorite(String role, String widgetId) async {
    try {
      final current = getFavorites(role);
      final isExisting = current.contains(widgetId);
      
      if (isExisting) {
        current.remove(widgetId);
      } else {
        current.add(widgetId);
      }
      
      await _prefs.setStringList('$_favoritesPrefix$role', current);
      
      _ref.read(executionGateProvider).passGate(
        ExecutionGateCategory.resource,
        'Favorite Persistent State Updated: $role',
        metadata: {
          'widgetId': widgetId,
          'action': isExisting ? 'removed' : 'added',
          'totalCount': current.length,
        },
      );
    } catch (e, stack) {
      _ref.read(executionGateProvider).failGate(
        ExecutionGateCategory.resource,
        'Failed to persist favorite toggle: $role',
        error: e,
        stackTrace: stack,
        metadata: {'widgetId': widgetId},
      );
    }
  }

  /// Sets whether a specific component/feature is PIN'd to the top for a role.
  bool isPinned(String role, String componentId) {
    return _prefs.getBool('$_pinPrefix${role}_$componentId') ?? false;
  }

  Future<void> setPinned(String role, String componentId, bool pinned) async {
    try {
      await _prefs.setBool('$_pinPrefix${role}_$componentId', pinned);
      _ref.read(executionGateProvider).passGate(
        ExecutionGateCategory.resource,
        'Pin State Persisted: $componentId for $role',
        metadata: {'pinned': pinned},
      );
    } catch (e, stack) {
      _ref.read(executionGateProvider).failGate(
        ExecutionGateCategory.resource,
        'Failed to persist pin state',
        error: e,
        stackTrace: stack,
      );
    }
  }

  /// Persists custom layout configuration as a JSON string.
  Future<void> saveLayoutConfig(
    String role,
    Map<String, dynamic> config,
  ) async {
    try {
      await _prefs.setString('$_layoutPrefix$role', jsonEncode(config));
      _ref.read(executionGateProvider).passGate(
        ExecutionGateCategory.resource,
        'Workspace Layout Saved: $role',
        metadata: {'configKeys': config.keys.toList()},
      );
    } catch (e, stack) {
      _ref.read(executionGateProvider).failGate(
        ExecutionGateCategory.resource,
        'Critical: Failed to save layout configuration: $role',
        error: e,
        stackTrace: stack,
      );
    }
  }

  Map<String, dynamic>? getLayoutConfig(String role) {
    final raw = _prefs.getString('$_layoutPrefix$role');
    if (raw == null) return null;
    try {
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (e, stack) {
      _ref.read(executionGateProvider).failGate(
        ExecutionGateCategory.resource,
        'Memory Corruption: Invalid JSON in layout configuration: $role',
        error: e,
        stackTrace: stack,
      );
      return null;
    }
  }

  /// Clears all role-based personalization (e.g., on logout if requested).
  Future<void> clearRolePreferences(String role) async {
    await _prefs.remove('$_favoritesPrefix$role');
    await _prefs.remove('$_layoutPrefix$role');
    _ref.read(executionGateProvider).passGate(
      ExecutionGateCategory.resource,
      'Role Preferences Purged: $role',
    );
  }
}

/// Provider for the global PreferenceService.
/// On Web, we fall back to a FutureProvider or similar if not overridden, 
/// but to keep it simple and synchronous for the UI, we return a blank holder if not ready.
final sharedPreferencesProvider = Provider<SharedPreferences?>((ref) {
  // Hardened for non-blocking hydration. This should be overridden in main.dart,
  // but we return null instead of throwing to prevent crashing the Riverpod graph.
  return null;
});

final preferenceServiceProvider = Provider<PreferenceService?>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  if (prefs == null) {
    // Audit hydration delay for diagnostic visibility
    ref.read(executionGateProvider).passGate(
      ExecutionGateCategory.resource,
      'Persistence Hydration: Pending SharedPreferences initialization',
    );
    return null;
  }
  return PreferenceService(ref, prefs);
});
