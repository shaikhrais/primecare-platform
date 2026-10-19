import 'package:database_client/database_client.dart';

class BillingRepository extends BasePlatformRepository {
  BillingRepository(super.database);

  Future<DatabaseResult> listInvoices() => database.query('SELECT * FROM invoices');
}
