// Governance - Category: service | Purpose: Layer: 01_INFRASTRUCTURE Hardened Verification Service for PrimeCare Infrastructure audits. Handles architectural pur...
// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/flutter_core.dart';

/// Hardened Verification Service for PrimeCare Infrastructure audits.
/// Handles architectural purpose reports and database integrity metrics.
class VerificationService {
  final ApiClient _apiClient;
  final ExecutionGateService _telemetry;

  VerificationService(this._apiClient, this._telemetry);

  /// Fetches architectural topology and C4 component status.
  Future<Result<Map<String, dynamic>>> getArchitecturePurposeReport() async {
    return Result.guardFuture<Map<String, dynamic>>(
      () async {
        final endpoint = ApiConfig.endpoints['verificationPurposeReport']!;
        final response = await _apiClient.get(endpoint);

        if (response.statusCode == 200) {
          _telemetry.passGate(
            ExecutionGateCategory.metricsLayer,
            'Architecture purpose report hydrated successfully',
          );
          return response.data as Map<String, dynamic>;
        }

        _telemetry.failGate(
          ExecutionGateCategory.metricsLayer,
          'Verification Service Error: ${response.statusCode}',
          metadata: {'status': response.statusCode},
        );
        return {};
      },
      onError: (e, st) {
        _telemetry.failGate(
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
    return Result.guardFuture<Map<String, dynamic>>(
      () async {
        final endpoint = ApiConfig.endpoints['verificationDatabaseReport']!;
        final response = await _apiClient.get(endpoint);

        if (response.statusCode == 200) {
          _telemetry.passGate(
            ExecutionGateCategory.metricsLayer,
            'Database verification report hydrated successfully',
          );
          return response.data as Map<String, dynamic>;
        }

        _telemetry.failGate(
          ExecutionGateCategory.metricsLayer,
          'Database Verification Error: ${response.statusCode}',
          metadata: {'status': response.statusCode},
        );
        return {};
      },
      onError: (e, st) {
        _telemetry.failGate(
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
