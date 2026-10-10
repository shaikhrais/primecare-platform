import 'sql_executor.dart';

abstract class BaseBillingSqlRepository<D extends SqlExecutor<R>, R>
    extends BaseSqlRepository<D, R> {
  BaseBillingSqlRepository(super.database);

  Future<R> listInvoices() => database.query('SELECT * FROM invoices');
}
