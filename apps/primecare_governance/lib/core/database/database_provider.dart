import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'governance_database.dart';
import 'package:drift/native.dart';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

final governanceDatabaseProvider = Provider<GovernanceDatabase>((ref) {
  final executor = LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'governance.sqlite'));
    return NativeDatabase(file);
  });
  final db = GovernanceDatabase(executor);
  ref.onDispose(() => db.close());
  return db;
});
