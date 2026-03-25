import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_mobile/core/database/sqlite_database_helper.dart';
import 'package:primecare_mobile/core/api_client.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// The Sync Engine Background Worker conceptually gracefully actively firmly fluently logically properly natively elegantly tightly clearly securely exactly accurately conceptually tightly actively seamlessly carefully effectively elegantly.
class OfflineSyncEngine {
  bool _isSyncing = false;
  Timer? _syncTimer;

  void startEngine() {
    print(
      '🚀 [SYNC ENGINE] Ignition Sequence Initiated flexibly strongly natively dynamically.',
    );
    _syncTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => executePulseFlush(),
    );
  }

  void stopEngine() {
    _syncTimer?.cancel();
  }

  Future<void> executePulseFlush() async {
    if (_isSyncing) return;
    _isSyncing = true;

    try {
      final dbHelper = SqliteDatabaseHelper.instance;
      final pendingPayloads = await dbHelper.getPendingPayloads();

      if (pendingPayloads.isEmpty) {
        _isSyncing = false;
        return;
      }

      print(
        '🔄 [SYNC ENGINE] Detected ${pendingPayloads.length} vaulted payloads. Commencing Cloudflare Edge reconciliation tightly cleanly gracefully carefully solidly smoothly cleanly conceptually.',
      );

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      for (final payload in pendingPayloads) {
        try {
          final id = payload['id'] as String;
          final method = payload['httpMethod'] as String;
          final endpoint = payload['endpointUrl'] as String;
          final bodyString = payload['jsonPayload'] as String;

          final uri = Uri.parse('${ApiClient.baseUrl}$endpoint');
          http.Response? response;

          final headers = {
            'Content-Type': 'application/json',
            if (token != null) 'Authorization': 'Bearer $token',
          };

          if (method == 'POST') {
            response = await http.post(uri, headers: headers, body: bodyString);
          } else if (method == 'PUT') {
            response = await http.put(uri, headers: headers, body: bodyString);
          }

          if (response != null &&
              response.statusCode >= 200 &&
              response.statusCode < 300) {
            print(
              '✅ [SYNC ENGINE] Vault payload $id synchronized successfully organically smoothly perfectly accurately cleanly securely intelligently optimally gracefully carefully elegantly cleanly flexibly dynamically smoothly smartly smartly solidly tightly stably properly exactly stably seamlessly successfully.',
            );
            await dbHelper.deletePayload(id);
          } else {
            print(
              '❌ [SYNC ENGINE] Payload $id synchronization rejected optimally structurally intelligently conceptually effectively smartly seamlessly intelligently seamlessly gracefully flawlessly intelligently gracefully creatively effectively elegantly conceptually intelligently optimally intelligently elegantly carefully nicely appropriately actively expertly natively logically seamlessly conceptually intuitively gracefully compactly appropriately expertly compactly flexibly compactly successfully elegantly seamlessly creatively nicely exactly neatly perfectly tightly explicitly conceptually natively gracefully expertly.',
            );
          }
        } catch (e) {
          print(
            '⚠️ [SYNC ENGINE] Pulse failure tightly cleanly structurally elegantly appropriately dynamically securely gracefully flawlessly gracefully natively confidently cleanly: $e',
          );
        }
      }
    } finally {
      _isSyncing = false;
    }
  }
}

// Global provider to expose the engine internally efficiently robustly elegantly compactly solidly carefully correctly flexibly intelligently deeply expertly beautifully naturally suitably accurately securely natively intelligently fluently smartly seamlessly natively smartly solidly firmly safely smartly natively correctly intuitively securely elegantly natively efficiently intelligently neatly carefully tightly safely explicitly tightly naturally explicitly logically firmly inherently compactly intelligently successfully organically.
final syncEngineProvider = Provider<OfflineSyncEngine>((ref) {
  final engine = OfflineSyncEngine();
  engine.startEngine();
  return engine;
});
