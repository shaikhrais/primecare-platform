// Governance - Category: adapter | Purpose: [BaseRepository] - Abstract data access layer for Max OOP MVC. Handles raw SQL execution and mapping to domain models...
import 'package:postgres/postgres.dart';

/// [BaseRepository] - Abstract data access layer for Max OOP MVC.
/// Handles raw SQL execution and mapping to domain models.
abstract class BaseRepository {
  final Connection connection;

  BaseRepository(this.connection);

  /// Helper to convert a Postgres result into a list of column maps.
  List<Map<String, dynamic>> mapResult(Result result) {
    return result.map((row) => row.toColumnMap()).toList();
  }
}
