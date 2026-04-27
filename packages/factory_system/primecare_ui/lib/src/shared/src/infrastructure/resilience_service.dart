// Layer: 01_INFRASTRUCTURE
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'telemetry_service.dart';

/// Service responsible for local snapshot storage and offline data restoration.
/// Part of the PrimeCare V4 'Unbreakable' resilience suite.
class ResilienceService {
  final SharedPreferences? _prefs;
  final Ref _ref;

  ResilienceService(this._prefs, this._ref);

  /// Saves a JSON snapshot for a given cache key.
  Future<void> saveSnapshot(String key, Map<String, dynamic> data) async {
    if (_prefs == null) return;

    final jsonString = json.encode({
      'data': data,
      'timestamp': DateTime.now().toIso8601String(),
    });

    await _prefs.setString('snapshot_$key', jsonString);

    _ref
        .read(executionGateProvider)
        .passGate(
          ExecutionGateCategory.storage,
          'Snapshot saved for key: $key',
          metadata: {'key': key},
        );
  }

  /// Retrieves a previously saved snapshot or null if unavailable.
  Map<String, dynamic>? getSnapshot(String key) {
    if (_prefs == null) return null;

    final jsonString = _prefs.getString('snapshot_$key');
    if (jsonString == null) return null;

    try {
      final decoded = json.decode(jsonString) as Map<String, dynamic>;
      _ref
          .read(executionGateProvider)
          .passGate(
            ExecutionGateCategory.storage,
            'Snapshot restored for key: $key',
            metadata: {'key': key, 'age': decoded['timestamp']},
          );
      return decoded['data'] as Map<String, dynamic>;
    } catch (e) {
      _ref
          .read(executionGateProvider)
          .failGate(
            ExecutionGateCategory.storage,
            'Failed to decode snapshot for key: $key',
            error: e,
          );
      return null;
    }
  }

  /// Clears a specific snapshot.
  Future<void> clearSnapshot(String key) async {
    if (_prefs == null) return;
    await _prefs.remove('snapshot_$key');
  }
}

/// Provider for the ResilienceService.
/// Note: Requires sharedPreferencesProvider to be initialized.
final resilienceServiceProvider = Provider<ResilienceService>((ref) {
  // This is a placeholder for the actual shared preferences instance
  // which is typically injected at app startup.
  return ResilienceService(null, ref);
});
