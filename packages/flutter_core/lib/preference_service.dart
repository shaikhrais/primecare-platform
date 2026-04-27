// Layer: 01_INFRASTRUCTURE
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:primecare_adapters/primecare_adapters.dart';

/// Enterprise Preference Engine for Role-Based Personalization.
/// Handles persistent state for Favorite Widgets, PIN visibility, and Workspace layouts.
class PreferenceService {
  final SharedPreferences _prefs;
  final ExecutionGateService _telemetry;

  PreferenceService(this._prefs, this._telemetry);

  static const String _favoritesPrefix = 'pref_favorites_';
  static const String _pinPrefix = 'pref_pin_';
  static const String _layoutPrefix = 'pref_layout_';

  /// Returns the list of Favorite Widget IDs for a specific role.
  List<String> getFavorites(String role) {
    return _prefs.getStringList('$_favoritesPrefix$role') ?? [];
  }

  /// Toggles a widget ID in the favorites list for a role.
  Future<void> toggleFavorite(String role, String widgetId) async {
    await Result.guardFuture<void>(
      () async {
        final current = getFavorites(role);
        final isExisting = current.contains(widgetId);

        if (isExisting) {
          current.remove(widgetId);
        } else {
          current.add(widgetId);
        }

        await _prefs.setStringList('$_favoritesPrefix$role', current);

        _telemetry.passGate(
          ExecutionGateCategory.storage,
          'Favorite Persistent State Updated: $role',
          metadata: {
            'widgetId': widgetId,
            'action': isExisting ? 'removed' : 'added',
            'totalCount': current.length,
          },
        );
      },
      onError: (Object e, StackTrace stack) {
        _telemetry.failGate(
          ExecutionGateCategory.storage,
          'Failed to persist favorite toggle: $role',
          error: e,
          stackTrace: stack,
          metadata: {'widgetId': widgetId},
        );
      },
    );
  }

  /// Sets whether a specific component/feature is PIN'd to the top for a role.
  bool isPinned(String role, String componentId) {
    return _prefs.getBool('$_pinPrefix${role}_$componentId') ?? false;
  }

  Future<void> setPinned(String role, String componentId, bool pinned) async {
    await Result.guardFuture<void>(
      () async {
        await _prefs.setBool('$_pinPrefix${role}_$componentId', pinned);
        _telemetry.passGate(
          ExecutionGateCategory.storage,
          'Pin State Persisted: $componentId for $role',
          metadata: {'pinned': pinned},
        );
      },
      onError: (Object e, StackTrace stack) {
        _telemetry.failGate(
          ExecutionGateCategory.storage,
          'Failed to persist pin state',
          error: e,
          stackTrace: stack,
        );
      },
    );
  }

  /// Persists custom layout configuration as a JSON string.
  Future<void> saveLayoutConfig(
    String role,
    Map<String, dynamic> config,
  ) async {
    await Result.guardFuture<void>(
      () async {
        await _prefs.setString('$_layoutPrefix$role', jsonEncode(config));
        _telemetry.passGate(
          ExecutionGateCategory.storage,
          'Workspace Layout Saved: $role',
          metadata: {'configKeys': config.keys.toList()},
        );
      },
      onError: (Object e, StackTrace stack) {
        _telemetry.failGate(
          ExecutionGateCategory.storage,
          'Critical: Failed to save layout configuration: $role',
          error: e,
          stackTrace: stack,
        );
      },
    );
  }

  Result<Map<String, dynamic>?> getLayoutConfig(String role) {
    return Result.guard<Map<String, dynamic>?>(
      () {
        final raw = _prefs.getString('$_layoutPrefix$role');
        if (raw == null) return null;
        return jsonDecode(raw) as Map<String, dynamic>;
      },
      onError: (Object e, StackTrace stack) {
        _telemetry.failGate(
          ExecutionGateCategory.storage,
          'Memory Corruption: Invalid JSON in layout configuration: $role',
          error: e,
          stackTrace: stack,
        );
        return null;
      },
    );
  }

  /// Clears all role-based personalization (e.g., on logout if requested).
  Future<void> clearRolePreferences(String role) async {
    await Result.guardFuture<void>(
      () async {
        await _prefs.remove('$_favoritesPrefix$role');
        await _prefs.remove('$_layoutPrefix$role');
        _telemetry.passGate(
          ExecutionGateCategory.storage,
          'Preferences cleared for role: $role',
        );
      },
      onError: (Object e, StackTrace st) {
        _telemetry.failGate(
          ExecutionGateCategory.storage,
          'Failed to purge role preferences: $role',
          error: e,
          stackTrace: st,
        );
      },
    );
  }
}

final preferenceServiceProvider = Provider<PreferenceService?>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final telemetry = ref.read<ExecutionGateService>(executionGateProvider);
  if (prefs == null) {
    // Audit hydration delay for diagnostic visibility
    telemetry.passGate(
      ExecutionGateCategory.storage,
      'Persistence Hydration: Pending SharedPreferences initialization',
    );
    return null;
  }
  return PreferenceService(prefs, telemetry);
});
