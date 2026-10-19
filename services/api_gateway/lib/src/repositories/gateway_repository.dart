import 'package:database_client/database_client.dart';

class GatewayRepository extends BasePlatformRepository {
  GatewayRepository(super.database);

  Future<DatabaseResult> checkHealth() => database.query('SELECT 1');
}
