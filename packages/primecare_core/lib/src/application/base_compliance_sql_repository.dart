import 'dart:convert';
import 'sql_executor.dart';

abstract class BaseComplianceSqlRepository<D extends SqlExecutor<R>, R>
    extends BaseSqlRepository<D, R> {
  BaseComplianceSqlRepository(super.database);

  Future<R> listAudits() => database.query(
    'SELECT * FROM compliance_audits ORDER BY created_at DESC',
  );

  Future<R> createFinding(Map<String, dynamic> payload) => database.query(
    'INSERT INTO compliance_findings (category, severity, message, metadata) VALUES (@category, @severity, @message, @metadata)',
    substitutionValues: {
      'category': payload['category'],
      'severity': payload['severity'],
      'message': payload['message'],
      'metadata': jsonEncode(payload['metadata'] ?? {}),
    },
  );
}
