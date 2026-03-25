import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../api_client.dart';
import '../database/sqlite_database_helper.dart';

class OfflineSyncManager {
  static final OfflineSyncManager _instance = OfflineSyncManager._internal();
  factory OfflineSyncManager() => _instance;

  OfflineSyncManager._internal();

  bool _isSyncing = false;

  void initializeSyncListener() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        print("NETWORK RESTORED: Triggering Offline Array Flush");
        attemptQueueFlush();
      }
    });
  }

  Future<void> attemptQueueFlush() async {
    if (_isSyncing) return;
    _isSyncing = true;

    try {
      final queue = await SqliteDatabaseHelper.instance
          .readAllPendingPayloads();

      if (queue.isEmpty) {
        _isSyncing = false;
        return;
      }

      print(
        "Beginning flush of \${queue.length} buffered algorithms to the Cloudflare Edge.",
      );

      for (var row in queue) {
        final id = row['id'] as String;
        final method = row['httpMethod'] as String;
        final url = row['endpointUrl'] as String;
        final jsonPayload = row['jsonPayload'] as String;

        try {
          final bodyMap = jsonDecode(jsonPayload);

          if (method == 'POST') {
            await apiClient.post(url, bodyMap);
          } else if (method == 'PUT') {
            await apiClient.put(url, bodyMap);
          }

          // Explicitly delete successful transactions from the persistent local store.
          await SqliteDatabaseHelper.instance.deletePayload(id);
          print("Successfully flushed Payload \$id to PRISMA.");
        } catch (e) {
          print("Failed to sync Payload \$id. Incrementing retry logic.");
          await SqliteDatabaseHelper.instance.incrementRetryCount(id);
        }
      }
    } finally {
      _isSyncing = false;
    }
  }
}
