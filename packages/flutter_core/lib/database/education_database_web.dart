// Web implementation stub for Drift database (web platforms)
import 'package:drift/drift.dart';
import 'education_database.dart';

Future<EducationDatabase> openNativeImpl() async {
  // On the web, we use JSON assets instead of SQLite, so this is unused.
  throw UnsupportedError('Native SQLite database is not supported on the web.');
}
