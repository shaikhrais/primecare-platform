import 'sql_executor.dart';

abstract class BaseClientSqlRepository<D extends SqlExecutor<R>, R>
    extends BaseSqlRepository<D, R> {
  BaseClientSqlRepository(super.database);

  Future<R> listClients() => database.query('SELECT * FROM clients');

  Future<R> createClient(Map<String, dynamic> payload) => database.query(
    'INSERT INTO clients (first_name, last_name, email) VALUES (@firstName, @lastName, @email)',
    substitutionValues: {
      'firstName': payload['first_name'],
      'lastName': payload['last_name'],
      'email': payload['email'],
    },
  );
}
