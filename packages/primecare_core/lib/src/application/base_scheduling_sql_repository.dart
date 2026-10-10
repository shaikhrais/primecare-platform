// ignore_for_file: prefer_single_quotes
import 'sql_executor.dart';

abstract class BaseSchedulingSqlRepository<D extends SqlExecutor<R>, R>
    extends BaseSqlRepository<D, R> {
  BaseSchedulingSqlRepository(super.database);

  Future<R> listSchedules() {
    final query =
        "        SELECT \n          s.id, \n          s.start_time, \n          s.end_time, \n          c.first_name as client_name, \n          p.first_name as provider_name \n        FROM schedules s\n        JOIN clients c ON s.client_id = c.id\n        JOIN providers p ON s.provider_id = p.id\n      ";
    return database.query(query);
  }
}
