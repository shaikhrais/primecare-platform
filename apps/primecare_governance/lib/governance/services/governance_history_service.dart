// Governance - Category: service | Purpose: Captures a snapshot of the current governance report and persists it.
import 'package:drift/drift.dart';
import '../models/governance_report.dart';
import '../../core/database/governance_database.dart';

class GovernanceHistoryService {
  final GovernanceDatabase _db;

  GovernanceHistoryService(this._db);

  /// Captures a snapshot of the current governance report and persists it.
  Future<void> captureSnapshot(GovernanceReport report) async {
    await _db.saveSnapshot(
      GovernanceSnapshotsCompanion(
        healthScore: Value(report.overallHealthScore),
        criticalIssues: Value(report.criticalIssues),
        highIssues: Value(report.highIssues),
        mediumIssues: Value(report.mediumIssues),
        lowIssues: Value(report.lowIssues),
        totalScreens: Value(report.totalScreens),
        productionReadyScreens: Value(report.productionReadyScreens),
      ),
    );
  }

  /// Retrieves the history of health scores for trend visualization.
  Future<List<Map<String, dynamic>>> getHealthTrend() async {
    final snapshots = await _db.getRecentSnapshots();
    return snapshots.reversed
        .map((s) => {'date': s.timestamp, 'score': s.healthScore})
        .toList();
  }

  /// Retrieves a detailed issue distribution trend.
  Future<List<Map<String, dynamic>>> getIssueTrend() async {
    final snapshots = await _db.getRecentSnapshots();
    return snapshots.reversed
        .map(
          (s) => {
            'date': s.timestamp,
            'critical': s.criticalIssues,
            'high': s.highIssues,
            'medium': s.mediumIssues,
            'low': s.lowIssues,
          },
        )
        .toList();
  }
}
