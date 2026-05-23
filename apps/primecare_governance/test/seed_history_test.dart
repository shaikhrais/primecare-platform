// Governance - Category: test | Purpose: Core implementation file for the Seed History Test platform logic.
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_governance/core/database/governance_database.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

void main() {
  test('Seed Governance History', () async {
    PrimeLogger.info('Seeding Governance History...');

    final db = GovernanceDatabase(NativeDatabase.memory());

    final now = DateTime.now();
    final data = [
      {'score': 65.0, 'days': 30},
      {'score': 68.0, 'days': 25},
      {'score': 72.0, 'days': 20},
      {'score': 70.0, 'days': 15},
      {'score': 78.0, 'days': 10},
      {'score': 82.0, 'days': 5},
      {'score': 85.0, 'days': 2},
      {'score': 88.0, 'days': 0},
    ];

    for (final entry in data) {
      final timestamp = now.subtract(Duration(days: entry['days'] as int));
      await db.saveSnapshot(
        GovernanceSnapshotsCompanion(
          healthScore: Value(entry['score'] as double),
          criticalIssues: Value(
            (100 - (entry['score'] as double)).toInt() ~/ 5,
          ),
          highIssues: Value(5),
          mediumIssues: Value(10),
          lowIssues: Value(20),
          totalScreens: Value(251),
          productionReadyScreens: Value(
            ((entry['score'] as double) / 100 * 251).toInt(),
          ),
          timestamp: Value(timestamp),
        ),
      );
    }

    PrimeLogger.info('SUCCESS: Seeded 8 historical snapshots.');
    await db.close();
  });
}
