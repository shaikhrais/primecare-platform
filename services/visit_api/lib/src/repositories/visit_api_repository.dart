import 'package:database_client/database_client.dart';

class VisitRepository extends BasePlatformRepository {
  VisitRepository(super.database);

  Future<DatabaseResult> listVisits() => database.query(
          'SELECT * FROM visits ORDER BY visit_date DESC',
        );

  Future<DatabaseResult> createVisit(Map<String, dynamic> payload) => database.query(
          'INSERT INTO visits (client_id, provider_id, visit_date, status) VALUES (@clientId, @providerId, NOW(), @status)',
          substitutionValues: {
            'clientId': payload['client_id'],
            'providerId': payload['provider_id'],
            'status': 'started',
          },
        );
}
