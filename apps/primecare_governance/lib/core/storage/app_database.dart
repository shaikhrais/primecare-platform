// Governance - Category: service | Purpose: Database data model, schema migrations, and client persistence interfaces.
import 'package:drift/drift.dart';
import '../connection/connection_stub.dart'
    if (dart.library.ffi) '../connection/connection_native.dart'
    if (dart.library.html) '../connection/connection_web.dart';

part 'app_database.g.dart';

class Users extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get email => text()();
  TextColumn get role => text()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Users])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection('primecare.sqlite'));

  @override
  int get schemaVersion => 1;

  // DAO methods
  Future<List<User>> getAllUsers() => select(users).get();
  Future<int> insertUser(User user) => into(users).insert(user);
  Future<bool> updateUser(User user) => update(users).replace(user);
}
