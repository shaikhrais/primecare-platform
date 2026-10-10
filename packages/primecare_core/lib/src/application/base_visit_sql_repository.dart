import 'sql_executor.dart';

abstract class BaseVisitSqlRepository<D extends SqlExecutor<R>, R>
    extends BaseSqlRepository<D, R> {
  BaseVisitSqlRepository(super.database);

  Future<R> listVisits() =>
      database.query('SELECT * FROM visits ORDER BY visit_date DESC');

  Future<R> createVisit(Map<String, dynamic> payload) => database.query(
    'INSERT INTO visits (client_id, provider_id, visit_date, status) VALUES (@clientId, @providerId, NOW(), @status)',
    substitutionValues: {
      'clientId': payload['client_id'],
      'providerId': payload['provider_id'],
      'status': 'started',
    },
  );
}
