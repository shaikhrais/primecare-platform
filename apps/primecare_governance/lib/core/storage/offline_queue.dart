import 'dart:async';

enum OfflineActionType { create, update, delete }

class OfflineAction {
  final String id;
  final String endpoint;
  final OfflineActionType type;
  final Map<String, dynamic> data;
  final DateTime timestamp;

  OfflineAction({
    required this.id,
    required this.endpoint,
    required this.type,
    required this.data,
    required this.timestamp,
  });
}

class OfflineSyncManager {
  static final List<OfflineAction> _queue = [];

  static void addToQueue(OfflineAction action) {
    _queue.add(action);
    // Persist queue to Drift database here
  }

  static Future<void> sync(dynamic apiService) async {
    if (_queue.isEmpty) return;

    final List<OfflineAction> failed = [];

    for (final action in _queue) {
      try {
        // execute action via apiService
        // Example: if (action.type == OfflineActionType.create) await apiService.post(action.endpoint, action.data);
      } catch (e) {
        failed.add(action);
      }
    }

    _queue.clear();
    _queue.addAll(failed);
    // Update persisted queue
  }
}
