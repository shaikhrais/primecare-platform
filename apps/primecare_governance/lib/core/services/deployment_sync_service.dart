// Governance - Category: service | Purpose: Handles database seeding, offline sync, and synchronization of deep screen scan details into the local Drift SQLite database.
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../database/database_provider.dart';
import '../database/governance_database.dart';

final deploymentSyncServiceProvider = Provider<DeploymentSyncService>((ref) {
  final db = ref.read(governanceDatabaseProvider);
  return DeploymentSyncService(db);
});

class DeploymentSyncService {
  final GovernanceDatabase _db;
  DeploymentSyncService(this._db);

  /// Synchronizes the deep screen scan JSON asset into the local Drift SQLite database
  Future<void> syncOfflineDatabase() async {
    try {
      print('🤖 SQLite: Initializing local governance offline synchronization...');
      final String jsonContent = await rootBundle.loadString('assets/screen_details_scan.json');
      final Map<String, dynamic> data = jsonDecode(jsonContent);

      final List<dynamic> deploymentsJson = data['deployments'] ?? [];
      
      for (final dep in deploymentsJson) {
        final String appName = dep['appName'] ?? '';
        final String buildUrl = dep['buildUrl'] ?? '';
        final String status = dep['status'] ?? 'success';
        final String platform = dep['platform'] ?? 'web';
        final bool verified = dep['verified'] ?? true;
        final String verificationLog = dep['verificationLog'] ?? '';
        
        // Generate deterministic UUID-like ID based on appName and platform for conflict updates
        final String deploymentId = '${appName}_$platform';

        print('🤖 SQLite Syncing Deployment: $deploymentId');
        await _db.upsertDeployment(
          PlatformDeploymentsCompanion(
            id: Value(deploymentId),
            appName: Value(appName),
            platform: Value(platform),
            status: Value(status),
            verified: Value(verified),
            buildUrl: Value(buildUrl),
            verificationLog: Value(verificationLog),
            createdAt: Value(DateTime.now()),
            updatedAt: Value(DateTime.now()),
          ),
        );

        // Delete existing screen details for this deployment to keep it pristine and fresh
        await _db.deleteScreenDetailsForDeployment(deploymentId);

        final List<dynamic> screensJson = dep['screens'] ?? [];
        for (final scr in screensJson) {
          final String screenName = scr['screenName'] ?? '';
          final String language = scr['language'] ?? 'dart';
          final List<dynamic> labels = scr['labels'] ?? [];
          final List<dynamic> textElements = scr['textElements'] ?? [];
          final List<dynamic> components = scr['components'] ?? [];
          final Map<String, dynamic> rawMetrics = scr['rawMetrics'] ?? {};

          final String screenId = '${deploymentId}_$screenName';

          await _db.upsertScreenDetail(
            PlatformScreenDetailsCompanion(
              id: Value(screenId),
              deploymentId: Value(deploymentId),
              screenName: Value(screenName),
              language: Value(language),
              labels: Value(jsonEncode(labels)),
              textElements: Value(jsonEncode(textElements)),
              components: Value(jsonEncode(components)),
              rawMetrics: Value(jsonEncode(rawMetrics)),
              createdAt: Value(DateTime.now()),
              updatedAt: Value(DateTime.now()),
            ),
          );
        }
      }
      print('✅ SQLite: Successfully loaded and synced ${deploymentsJson.length} deployments and all detailed screen elements locally!');
    } catch (e, stack) {
      print('❌ SQLite Sync Failed: $e');
      print(stack);
    }
  }

  /// Exposes standard read queries
  Future<List<PlatformDeployment>> getDeployments() => _db.getAllDeployments();

  Future<List<PlatformScreenDetail>> getScreenDetails(String deploymentId) =>
      _db.getScreenDetailsForDeployment(deploymentId);
}

/// Stream/Future provider for reactive lists in UI
final localDeploymentsProvider = FutureProvider<List<PlatformDeployment>>((ref) async {
  final service = ref.watch(deploymentSyncServiceProvider);
  // Auto-sync first
  await service.syncOfflineDatabase();
  return service.getDeployments();
});

final localScreenDetailsProvider = FutureProviderFamily<List<PlatformScreenDetail>, String>((ref, deploymentId) async {
  final service = ref.watch(deploymentSyncServiceProvider);
  return service.getScreenDetails(deploymentId);
});
