// Governance - Category: service | Purpose: infrastructure verification reports.
import 'package:primecare_models/src/models/result.dart';
import 'package:primecare_execution_gate/src/resilience/execution_gate_service.dart';
import 'package:primecare_guarded_service/primecare_guarded_service.dart';

mixin VerificationServiceImplementation on BaseGuardedService {
  String verificationEndpoint(String key);
  Future<({int? statusCode, dynamic data})> readVerificationReport(String endpoint);

  /// Fetches architectural topology and C4 component status.
  Future<Result<Map<String, dynamic>>> getArchitecturePurposeReport() async {
    return guard<Map<String, dynamic>>(
      () async {
        final endpoint = verificationEndpoint('verificationPurposeReport');
        final response = await readVerificationReport(endpoint);

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
        final endpoint = verificationEndpoint('verificationDatabaseReport');
        final response = await readVerificationReport(endpoint);

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
