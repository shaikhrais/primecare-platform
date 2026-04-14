import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../preference_service.dart';
import '../../telemetry_service.dart';

/// The Last Known Good (LKG) Persistence Engine.
/// Provides deterministic fallback snapshots for when network resources are unavailable.
class ResilienceService {
  final Ref _ref;
  
  ResilienceService(this._ref);

  static const String _lkgPrefix = 'lkg_snapshot_';

  /// Saves a snapshot of a viewModel or data structure.
  Future<void> saveSnapshot(String key, Map<String, dynamic> data) async {
    try {
      final prefs = _ref.read(sharedPreferencesProvider);
      if (prefs == null) return;

      await prefs.setString('$_lkgPrefix$key', jsonEncode(data));
      
      _ref.read(executionGateProvider).passGate(
        ExecutionGateCategory.resource,
        'Resilience: LKG Snapshot Persisted: $key',
        metadata: {'timestamp': DateTime.now().toIso8601String()},
      );
    } catch (e, stack) {
      _ref.read(executionGateProvider).failGate(
        ExecutionGateCategory.resource,
        'Resilience: Failed to persist LKG snapshot: $key',
        error: e,
        stackTrace: stack,
      );
    }
  }

  /// Retrieves the last known good snapshot.
  Map<String, dynamic>? getSnapshot(String key) {
    try {
      final prefs = _ref.read(sharedPreferencesProvider);
      if (prefs == null) return null;

      final raw = prefs.getString('$_lkgPrefix$key');
      if (raw == null) return null;

      _ref.read(executionGateProvider).passGate(
        ExecutionGateCategory.resource,
        'Resilience: LKG Snapshot Restored: $key',
      );
      
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (e, stack) {
      _ref.read(executionGateProvider).failGate(
        ExecutionGateCategory.resource,
        'Resilience: Memory Corruption in LKG snapshot: $key',
        error: e,
        stackTrace: stack,
      );
      return null;
    }
  }
}

/// Provider for the global ResilienceService.
final resilienceServiceProvider = Provider<ResilienceService>((ref) {
  return ResilienceService(ref);
});
