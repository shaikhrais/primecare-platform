import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:primecare_governance/core/database/governance_database.dart';
import 'dart:io';

void main() async {
  print('--- Governance Database Seeding ---');
  
  final dbFile = File('governance.sqlite');
  if (dbFile.existsSync()) {
    print('Removing existing database...');
    dbFile.deleteSync();
  }

  final database = GovernanceDatabase(NativeDatabase(dbFile));

  print('Generating 30 days of historical health snapshots...');
  
  final now = DateTime.now();
  for (int i = 30; i >= 0; i--) {
    final date = now.subtract(Duration(days: i));
    // Simulate gradual improvement
    final dayFactor = (30 - i) / 30.0;
    final healthScore = 82.0 + (13.0 * dayFactor) + (Platform.operatingSystem == 'windows' ? 0.5 : 0);
    
    await database.saveSnapshot(GovernanceSnapshotsCompanion.insert(
      timestamp: Value(date),
      healthScore: healthScore,
      criticalIssues: 12 - (12 * dayFactor).toInt(),
      highIssues: 25 - (20 * dayFactor).toInt(),
      mediumIssues: 40 - (15 * dayFactor).toInt(),
      lowIssues: 60 - (10 * dayFactor).toInt(),
      totalScreens: 251,
      productionReadyScreens: (200 + (51 * dayFactor)).toInt(),
    ));
  }

  print('Seeding complete. 31 snapshots inserted.');
  await database.close();
}
