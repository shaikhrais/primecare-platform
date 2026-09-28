// Governance - Category: service | Purpose: Database data model, schema migrations, and client persistence interfaces.
import 'package:drift/drift.dart';
import '../connection/connection_stub.dart' // fallback
    if (dart.library.html) '../connection/connection_d1.dart'
    if (dart.library.io) '../connection/connection_native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'app_database.g.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get externalId => text().unique()();
  TextColumn get name => text()();
  TextColumn get email => text()();
  TextColumn get role => text()();
  DateTimeColumn get lastSync => dateTime().withDefault(currentDateAndTime)();
}

class AuditLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get action => text()();
  TextColumn get details => text()();
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}

class FeatureIntakes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get featureName => text()();
  TextColumn get appId => text()();
  TextColumn get module => text()();
  TextColumn get priority => text()();
  TextColumn get description => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(tables: [Users, AuditLogs, FeatureIntakes])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection('db.sqlite'));

  @override
  int get schemaVersion => 1;
}

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});
