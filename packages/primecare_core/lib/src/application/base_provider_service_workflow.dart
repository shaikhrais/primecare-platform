import 'package:primecare_models/primecare_models.dart';
import '../network/base_api_transport.dart';
import '../network/base_transport_repository.dart';
import 'base_execution_gate_service.dart';
import 'base_business_workflow.dart';

abstract class BaseProviderServiceWorkflow<
  R extends BaseTransportRepository<BaseApiTransport>,
  T extends BaseExecutionGateService
>
    extends BaseBusinessWorkflow<R, T> {
  BaseProviderServiceWorkflow(
    super.repository,
    super.telemetry,
    super.endpoints,
  );

  /// Fetches the unified provider profile natively mapped to the logged-in Identity.
  Future<Result<ProviderProfile>> getSelfProfile() async {
    return guard<ProviderProfile>(
      () async {
        final endpoint = endpoints['providerProfile']!;
        final response = await repository.get(endpoint);

        if (response.statusCode == 200) {
          final profile = ProviderProfile.fromResponse(response.data);
          telemetry.passGate(
            ExecutionGateCategory.domainApi,
            'Provider self-profile fetched successfully',
            metadata: {'endpoint': 'providerProfile'},
          );
          return profile;
        }
        throw StateError(
          'Provider profile request failed (${response.statusCode})',
        );
      },
      onError: (Object e, StackTrace st) {
        telemetry.failGate(
          ExecutionGateCategory.domainApi,
          'Failed to fetch provider self-profile',
          error: e,
          stackTrace: st,
          metadata: {'endpoint': 'providerProfile'},
        );
        Error.throwWithStackTrace(e, st);
      },
    );
  }

  /// Logs a check-in event using standard Unified identifiers.
  Future<Result<void>> logCheckIn(
    String visitId,
    double lat,
    double lng,
  ) async {
    return guard<void>(
      () async {
        final baseEndpoint = endpoints['providerCheckin']!;
        final endpoint = baseEndpoint.replaceAll(':visitId', visitId);
        await repository.post(
          endpoint,
          body: {
            'lat': lat,
            'lng': lng,
            'timestamp': DateTime.now().toIso8601String(),
          },
        );
        telemetry.passGate(
          ExecutionGateCategory.domainApi,
          'Provider check-in logged successfully',
          metadata: {'visitId': visitId},
        );
      },
      onError: (Object e, StackTrace st) {
        telemetry.failGate(
          ExecutionGateCategory.domainApi,
          'Failed to log provider check-in',
          error: e,
          stackTrace: st,
          metadata: {'visitId': visitId},
        );
        // void return — fallback is a no-op, error is logged
      },
    );
  }
}
