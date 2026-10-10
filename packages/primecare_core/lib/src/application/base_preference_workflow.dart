import 'dart:convert';
import 'package:primecare_models/primecare_models.dart';
import 'base_telemetry_service.dart';
import 'base_execution_gate_service.dart';
import 'preference_store.dart';

/// Enterprise Preference Engine for Role-Based Personalization.
/// Handles persistent state for Favorite Widgets, PIN visibility, and Workspace layouts.
abstract class BasePreferenceWorkflow<TTelemetry extends BaseExecutionGateService>
    extends BaseTelemetryService<TTelemetry> {
  final PreferenceStore preferenceStore;
  BasePreferenceWorkflow(this.preferenceStore, TTelemetry telemetry) : super(telemetry);

  static const String _favoritesPrefix = 'pref_favorites_';
  static const String _pinPrefix = 'pref_pin_';
  static const String _layoutPrefix = 'pref_layout_';

  /// Returns the list of Favorite Widget IDs for a specific role.
  List<String> getFavorites(String role) {
    return preferenceStore.getStringList('$_favoritesPrefix$role') ?? [];
  }

  /// Toggles a widget ID in the favorites list for a role.
  Future<void> toggleFavorite(String role, String widgetId) async {
    await guard<void>(
      () async {
        final current = getFavorites(role);
        final isExisting = current.contains(widgetId);

        if (isExisting) {
          current.remove(widgetId);
        } else {
          current.add(widgetId);
        }

        await preferenceStore.setStringList('$_favoritesPrefix$role', current);

        telemetry.passGate(
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
        telemetry.failGate(
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
    return preferenceStore.getBool('$_pinPrefix${role}_$componentId') ?? false;
  }

  Future<void> setPinned(String role, String componentId, bool pinned) async {
    await guard<void>(
      () async {
        await preferenceStore.setBool('$_pinPrefix${role}_$componentId', pinned);
        telemetry.passGate(
          ExecutionGateCategory.storage,
          'Pin State Persisted: $componentId for $role',
          metadata: {'pinned': pinned},
        );
      },
      onError: (Object e, StackTrace stack) {
        telemetry.failGate(
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
    await guard<void>(
      () async {
        await preferenceStore.setString('$_layoutPrefix$role', jsonEncode(config));
        telemetry.passGate(
          ExecutionGateCategory.storage,
          'Workspace Layout Saved: $role',
          metadata: {'configKeys': config.keys.toList()},
        );
      },
      onError: (Object e, StackTrace stack) {
        telemetry.failGate(
          ExecutionGateCategory.storage,
          'Critical: Failed to save layout configuration: $role',
          error: e,
          stackTrace: stack,
        );
      },
    );
  }

  Result<Map<String, dynamic>?> getLayoutConfig(String role) {
    return guardSync<Map<String, dynamic>?>(
      () {
        final raw = preferenceStore.getString('$_layoutPrefix$role');
        if (raw == null) return null;
        return jsonDecode(raw) as Map<String, dynamic>;
      },
      onError: (Object e, StackTrace stack) {
        telemetry.failGate(
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
    await guard<void>(
      () async {
        await preferenceStore.remove('$_favoritesPrefix$role');
        await preferenceStore.remove('$_layoutPrefix$role');
        telemetry.passGate(
          ExecutionGateCategory.storage,
          'Preferences cleared for role: $role',
        );
      },
      onError: (Object e, StackTrace st) {
        telemetry.failGate(
          ExecutionGateCategory.storage,
          'Failed to purge role preferences: $role',
          error: e,
          stackTrace: st,
        );
      },
    );
  }
}
