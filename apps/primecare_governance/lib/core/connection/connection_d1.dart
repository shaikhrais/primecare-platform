import 'package:drift/drift.dart';

LazyDatabase openConnection(String dbName) => LazyDatabase(() async {
  throw UnsupportedError('Governance remote database transport is not configured.');
});
