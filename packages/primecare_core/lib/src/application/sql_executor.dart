/// Driver-independent query port. Implementations own credentials and connections.
abstract interface class SqlExecutor<R> {
  Future<R> query(String sql, {Map<String, dynamic>? substitutionValues});
}

abstract class BaseSqlRepository<D extends SqlExecutor<R>, R> {
  final D database;
  BaseSqlRepository(this.database);
}
