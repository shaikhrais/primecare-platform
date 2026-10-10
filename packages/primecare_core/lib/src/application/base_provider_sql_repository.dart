import 'sql_executor.dart';

abstract class BaseProviderSqlRepository<D extends SqlExecutor<R>, R>
    extends BaseSqlRepository<D, R> {
  BaseProviderSqlRepository(super.database);

  Future<R> listProviders() => database.query('SELECT * FROM providers');

  Future<R> findProvider(String id) => database.query(
    'SELECT * FROM providers WHERE id = @id',
    substitutionValues: {'id': id},
  );
}
