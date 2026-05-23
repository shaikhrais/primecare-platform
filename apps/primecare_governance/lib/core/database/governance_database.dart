// Governance - Category: service | Purpose: Database data model, schema migrations, and client persistence interfaces.
import 'package:drift/drift.dart';

part 'governance_database.g.dart';

class GovernanceSnapshots extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();
  RealColumn get healthScore => real()();
  IntColumn get criticalIssues => integer()();
  IntColumn get highIssues => integer()();
  IntColumn get mediumIssues => integer()();
  IntColumn get lowIssues => integer()();
  IntColumn get totalScreens => integer()();
  IntColumn get productionReadyScreens => integer()();
}

class Proposals extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get requestedBy => text()();
  TextColumn get department => text()();
  TextColumn get office => text()();
  TextColumn get role => text()();
  TextColumn get priority => text()();
  TextColumn get businessGoal => text()();
  TextColumn get problemStatement => text()();
  TextColumn get expectedOutcome => text()();
  TextColumn get screenId => text()();
  TextColumn get routePath => text()();
  TextColumn get allowedRoles => text()(); // JSON String
  TextColumn get requiredApis => text()(); // JSON String
  TextColumn get requiredComponents => text()(); // JSON String
  TextColumn get requiredForms => text()(); // JSON String
  TextColumn get designSource => text()();
  TextColumn get designUrl => text()();
  TextColumn get mockDataNotes => text()();
  BoolColumn get needsPhiData => boolean()();
  BoolColumn get needsConsent => boolean()();
  BoolColumn get needsSignature => boolean()();
  BoolColumn get needsAuditLog => boolean()();
  TextColumn get acceptanceCriteria => text()(); // JSON String
  TextColumn get testScenarios => text()(); // JSON String
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get status => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [GovernanceSnapshots, Proposals])
class GovernanceDatabase extends _$GovernanceDatabase {
  GovernanceDatabase(super.executor);

  @override
  int get schemaVersion => 2;

  // Snapshot Operations
  Future<int> saveSnapshot(GovernanceSnapshotsCompanion entry) =>
      into(governanceSnapshots).insert(entry);

  Future<List<GovernanceSnapshot>> getRecentSnapshots({int limit = 30}) =>
      (select(governanceSnapshots)
            ..orderBy([
              (t) => OrderingTerm(
                expression: t.timestamp,
                mode: OrderingMode.desc,
              ),
            ])
            ..limit(limit))
          .get();

  // Proposal Operations
  Future<int> upsertProposal(ProposalsCompanion entry) =>
      into(proposals).insertOnConflictUpdate(entry);

  Future<List<Proposal>> getAllProposals() => select(proposals).get();

  Future<void> deleteProposal(String id) =>
      (delete(proposals)..where((t) => t.id.equals(id))).go();

  Future<void> clearHistory() => delete(governanceSnapshots).go();
}
