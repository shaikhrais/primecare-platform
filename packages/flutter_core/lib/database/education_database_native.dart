// Native implementation for Drift database (non-web platforms)
import 'package:drift/ffi.dart' as ffi;
import 'education_database.dart';

Future<EducationDatabase> openNativeImpl() async {
  // In‑memory SQLite for native platforms.
  final executor = ffi.NativeDatabase.memory();
  return EducationDatabase(executor);
}
