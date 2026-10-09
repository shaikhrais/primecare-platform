import '../database_client.dart';

/// Repository parent for services using the shared database lifecycle.
abstract class BasePlatformRepository {
  final PlatformDatabase database;
  BasePlatformRepository(this.database);
}
