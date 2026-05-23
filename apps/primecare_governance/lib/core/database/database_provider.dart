// Governance - Category: controller | Purpose: Database data model, schema migrations, and client persistence interfaces.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'governance_database.dart';
import '../connection/connection_stub.dart'
    if (dart.library.ffi) '../connection/connection_native.dart'
    if (dart.library.html) '../connection/connection_web.dart';

final governanceDatabaseProvider = Provider<GovernanceDatabase>((ref) {
  final db = GovernanceDatabase(openConnection('governance.sqlite'));
  ref.onDispose(() => db.close());
  return db;
});
