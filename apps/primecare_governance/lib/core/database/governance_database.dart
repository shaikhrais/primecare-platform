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

class PlatformDeployments extends Table {
  TextColumn get id => text()();
  TextColumn get appName => text()();
  TextColumn get platform => text()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  TextColumn get version => text().nullable()();
  TextColumn get commitHash => text().nullable()();
  TextColumn get buildUrl => text().nullable()();
  TextColumn get details => text().nullable()();
  BoolColumn get verified => boolean().withDefault(const Constant(false))();
  TextColumn get verificationLog => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class PlatformScreenDetails extends Table {
  TextColumn get id => text()();
  TextColumn get deploymentId => text()();
  TextColumn get screenName => text()();
  TextColumn get language => text().withDefault(const Constant('dart'))();
  TextColumn get labels => text().nullable()(); // JSON string
  TextColumn get textElements => text().nullable()(); // JSON string
  TextColumn get components => text().nullable()(); // JSON string
  TextColumn get rawMetrics => text().nullable()(); // JSON string
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [GovernanceSnapshots, Proposals, PlatformDeployments, PlatformScreenDetails])
class GovernanceDatabase extends _$GovernanceDatabase {
  GovernanceDatabase(super.executor);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from < 3) {
            await m.create(platformDeployments);
            await m.create(platformScreenDetails);
          }
        },
      );

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

  // Platform Deployment Operations
  Future<int> upsertDeployment(PlatformDeploymentsCompanion entry) =>
      into(platformDeployments).insertOnConflictUpdate(entry);

  Future<List<PlatformDeployment>> getAllDeployments() => select(platformDeployments).get();

  Future<void> deleteDeployment(String id) =>
      (delete(platformDeployments)..where((t) => t.id.equals(id))).go();

  // Platform Screen Detail Operations
  Future<int> upsertScreenDetail(PlatformScreenDetailsCompanion entry) =>
      into(platformScreenDetails).insertOnConflictUpdate(entry);

  Future<List<PlatformScreenDetail>> getScreenDetailsForDeployment(String deploymentId) =>
      (select(platformScreenDetails)..where((t) => t.deploymentId.equals(deploymentId))).get();

  Future<void> deleteScreenDetailsForDeployment(String deploymentId) =>
      (delete(platformScreenDetails)..where((t) => t.deploymentId.equals(deploymentId))).go();
}
