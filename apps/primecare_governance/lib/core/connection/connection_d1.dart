import 'package:drift/drift.dart';
import 'package:drift/remote.dart';

LazyDatabase openConnection(String dbName) {
  const endpoint = String.fromEnvironment('CF_D1_ENDPOINT');
  const apiKey = String.fromEnvironment('CF_D1_API_KEY');
  final executor = RemoteDatabase(
    endpoint,
    headers: {'Authorization': 'Bearer $apiKey'},
  );
  return LazyDatabase(() async => executor);
}
