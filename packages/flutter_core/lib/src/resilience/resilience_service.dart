// Layer: 01_INFRASTRUCTURE
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A service dedicated to ensuring platform resilience through state snapshotting 
/// and Last Known Good (LKG) recovery.
class ResilienceService {
  final Map<String, dynamic> _memoryCache = {};

  /// Persists a high-fidelity snapshot of a data model for future recovery.
  Future<void> saveSnapshot(String key, Map<String, dynamic> data) async {
    // In a production environment, this would use SharedPreferences or a local SQLite/Isar database.
    // For the current factory implementation, we maintain a memory-resident LKG cache.
    _memoryCache[key] = data;
  }

  /// Retrieves the latest Last Known Good (LKG) snapshot for a given key.
  Future<Map<String, dynamic>?> getSnapshot(String key) async {
    final data = _memoryCache[key];
    if (data == null) return null;
    return Map<String, dynamic>.from(data as Map);
  }

  /// Clears the resilience cache.
  void flush() {
    _memoryCache.clear();
  }
}

/// Global provider for the ResilienceService.
final resilienceServiceProvider = Provider<ResilienceService>((ref) {
  return ResilienceService();
});
