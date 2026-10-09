import 'dart:convert';
import 'package:database_client/database_client.dart';

class ComplianceRepository extends BasePlatformRepository {
  ComplianceRepository(super.database);

  Future<DatabaseResult> listAudits() => database.query(
          'SELECT * FROM compliance_audits ORDER BY created_at DESC',
        );

  Future<DatabaseResult> createFinding(Map<String, dynamic> payload) => database.query(
          'INSERT INTO compliance_findings (category, severity, message, metadata) VALUES (@category, @severity, @message, @metadata)',
          substitutionValues: {
            'category': payload['category'],
            'severity': payload['severity'],
            'message': payload['message'],
            'metadata': jsonEncode(payload['metadata'] ?? {}),
          },
        );
}
