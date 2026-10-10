import 'package:primecare_models/primecare_models.dart';
import '../network/base_api_transport.dart';
import '../network/base_transport_repository.dart';
import 'base_execution_gate_service.dart';
import 'base_business_workflow.dart';

abstract class BaseVerificationServiceWorkflow<
  R extends BaseTransportRepository<BaseApiTransport>,
  T extends BaseExecutionGateService
>
    extends BaseBusinessWorkflow<R, T> {
  BaseVerificationServiceWorkflow(
    super.repository,
    super.telemetry,
    super.endpoints,
  );

  /// Fetches architectural topology and C4 component status.
  Future<Result<Map<String, dynamic>>> getArchitecturePurposeReport() async {
    return guard<Map<String, dynamic>>(
      () async {
        final endpoint = endpoints['verificationPurposeReport']!;
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
        final endpoint = endpoints['verificationDatabaseReport']!;
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
