import 'package:database_client/database_client.dart';

class ClientRepository extends BasePlatformRepository {
  ClientRepository(super.database);

  Future<DatabaseResult> listClients() => database.query('SELECT * FROM clients');

  Future<DatabaseResult> createClient(Map<String, dynamic> payload) => database.query(
          'INSERT INTO clients (first_name, last_name, email) VALUES (@firstName, @lastName, @email)',
          substitutionValues: {
            'firstName': payload['first_name'],
            'lastName': payload['last_name'],
            'email': payload['email'],
          },
        );
}
