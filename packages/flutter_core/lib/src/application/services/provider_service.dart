import 'package:flutter_core/flutter_core.dart' hide ProviderProfile;
import 'base_business_service.dart';
import '../../domain/models/provider_profile.dart';

class ProviderService extends BaseBusinessService {
  ProviderService(super.client, super.telemetry);

  /// Fetches the unified provider profile natively mapped to the logged-in Identity.
  Future<Result<ProviderProfile>> getSelfProfile() async {
    return guard<ProviderProfile>(
      () async {
        final endpoint = ApiConfig.endpoints['providerProfile']!;
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
        final baseEndpoint = ApiConfig.endpoints['providerCheckin']!;
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

final providerServiceProvider = Provider<ProviderService>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final telemetry = ref.watch<ExecutionGateService>(executionGateProvider);
  return ProviderService(apiClient, telemetry);
});
