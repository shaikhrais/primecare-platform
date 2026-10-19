import 'package:database_client/database_client.dart';

class ProviderRepository extends BasePlatformRepository {
  ProviderRepository(super.database);

  Future<DatabaseResult> listProviders() => database.query('SELECT * FROM providers');

  Future<DatabaseResult> findProvider(String id) => database.query(
          'SELECT * FROM providers WHERE id = @id',
          substitutionValues: {'id': id},
        );
}
