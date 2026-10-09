import 'base_business_service.dart';
// Governance - Category: service | Purpose: Layer: 01_INFRASTRUCTURE Hardened Verification Service for PrimeCare Infrastructure audits. Handles architectural pur...
// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/flutter_core.dart';

/// Hardened Verification Service for PrimeCare Infrastructure audits.
/// Handles architectural purpose reports and database integrity metrics.
class VerificationService extends BaseBusinessService {
  VerificationService(super.client, super.telemetry);

  /// Fetches architectural topology and C4 component status.
  Future<Result<Map<String, dynamic>>> getArchitecturePurposeReport() async {
    return guard<Map<String, dynamic>>(
      () async {
        final endpoint = ApiConfig.endpoints['verificationPurposeReport']!;
        final response = await repository.get(endpoint);

        if (response.statusCode == 200) {
          telemetry.passGate(
            ExecutionGateCategory.metricsLayer,
            'Architecture purpose report hydrated successfully',
          );
          return response.data as Map<String, dynamic>;
        }

        telemetry.failGate(
          ExecutionGateCategory.metricsLayer,
          'Verification Service Error: ${response.statusCode}',
          metadata: {'status': response.statusCode},
        );
        return {};
      },
      onError: (e, st) {
        telemetry.failGate(
          ExecutionGateCategory.metricsLayer,
          'Hard failure in Verification Service (Architecture)',
          error: e,
          stackTrace: st,
        );
        return {};
      },
    );
  }

  /// Fetches database health and verification logs.
  Future<Result<Map<String, dynamic>>> getDatabaseReport() async {
    return guard<Map<String, dynamic>>(
      () async {
        final endpoint = ApiConfig.endpoints['verificationDatabaseReport']!;
        final response = await repository.get(endpoint);

        if (response.statusCode == 200) {
          telemetry.passGate(
            ExecutionGateCategory.metricsLayer,
            'Database verification report hydrated successfully',
          );
          return response.data as Map<String, dynamic>;
        }

        telemetry.failGate(
          ExecutionGateCategory.metricsLayer,
          'Database Verification Error: ${response.statusCode}',
          metadata: {'status': response.statusCode},
        );
        return {};
      },
      onError: (e, st) {
        telemetry.failGate(
          ExecutionGateCategory.metricsLayer,
          'Hard failure in Verification Service (Database)',
          error: e,
          stackTrace: st,
        );
        return {};
      },
    );
  }
}
