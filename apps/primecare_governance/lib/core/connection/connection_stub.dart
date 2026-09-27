// Governance - Category: service | Purpose: Core implementation file for the Connection Stub platform logic.
import 'package:drift/drift.dart';

LazyDatabase openConnection(String dbName) {
  throw UnsupportedError(
    'No suitable database implementation was found on this platform.',
  );
}
