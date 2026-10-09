import 'package:database_client/database_client.dart';

class SchedulingRepository extends BasePlatformRepository {
  SchedulingRepository(super.database);

  Future<DatabaseResult> listSchedules() {
        final query = "        SELECT \n          s.id, \n          s.start_time, \n          s.end_time, \n          c.first_name as client_name, \n          p.first_name as provider_name \n        FROM schedules s\n        JOIN clients c ON s.client_id = c.id\n        JOIN providers p ON s.provider_id = p.id\n      ";
    return database.query(query);
  }
}
