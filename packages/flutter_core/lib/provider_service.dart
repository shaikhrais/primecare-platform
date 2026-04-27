// Layer: 01_INFRASTRUCTURE
import 'package:primecare_adapters/primecare_adapters.dart';

enum ProviderRole { psw, rn, rmt, unknown }

ProviderRole _parseRole(String? type) {
  switch (type?.toUpperCase()) {
    case 'PSW':
      return ProviderRole.psw;
    case 'RN':
      return ProviderRole.rn;
    case 'RMT':
      return ProviderRole.rmt;
    default:
      return ProviderRole.unknown;
  }
}

class ProviderProfile {
  final String id;
  final String fullName;
  final ProviderRole role;
  final String bio;
  final String serviceAreas;
  final int trustScore;
  final bool isApproved;
  final String? avatarUrl;

  ProviderProfile({
    required this.id,
    required this.fullName,
    required this.role,
    this.bio = '',
    this.serviceAreas = '',
    this.trustScore = 100,
    this.isApproved = false,
    this.avatarUrl,
  });

  factory ProviderProfile.fromJson(Map<String, dynamic> json) {
    return ProviderProfile(
      id: (json['provider_id'] as String?) ?? (json['id'] as String?) ?? '',
      fullName: (json['full_name'] as String?) ?? 'Unknown Provider',
      role: _parseRole(json['provider_type'] as String?),
      bio: (json['bio'] as String?) ?? '',
      serviceAreas: (json['service_areas'] as String?) ?? '',
      trustScore: (json['trust_score'] as num?)?.toInt() ?? 100,
      isApproved: (json['is_approved'] as bool?) ?? false,
      avatarUrl: (json['avatar_url'] as String?),
    );
  }
}

/// A unified service bridging the frontend to the backend Domain Modular Monolith structure.
/// This replaces disparate silos like RnService and PswService.
class ProviderService {
  final ApiClient _apiClient;
  final ExecutionGateService _telemetry;

  ProviderService(this._apiClient, this._telemetry);

  /// Fetches the unified provider profile natively mapped to the logged-in Identity.
  Future<Result<ProviderProfile>> getSelfProfile() async {
    return Result.guardFuture<ProviderProfile>(
      () async {
        final endpoint = ApiConfig.endpoints['providerDashboard']!;
        final response = await _apiClient.get(endpoint);

        if (response.statusCode == 200) {
          _telemetry.passGate(
            ExecutionGateCategory.domainApi,
            'Provider self-profile fetched successfully',
            metadata: {'endpoint': 'providerDashboard'},
          );
          return ProviderProfile.fromJson(
            response.data as Map<String, dynamic>,
          );
        }
        return ProviderProfile(
          id: 'fallback',
          fullName: 'Provider (Degraded)',
          role: ProviderRole.unknown,
        );
      },
      onError: (Object e, StackTrace st) {
        _telemetry.failGate(
          ExecutionGateCategory.domainApi,
          'Failed to fetch provider self-profile',
          error: e,
          stackTrace: st,
          metadata: {'endpoint': 'providerDashboard'},
        );
        // Return a safe fallback profile
        return ProviderProfile(
          id: 'fallback',
          fullName: 'Provider (Offline)',
          role: ProviderRole.unknown,
        );
      },
    );
  }

  /// Logs a check-in event using standard Unified identifiers.
  Future<Result<void>> logCheckIn(
    String visitId,
    double lat,
    double lng,
  ) async {
    return Result.guardFuture<void>(
      () async {
        final baseEndpoint = ApiConfig.endpoints['providerCheckin']!;
        final endpoint = baseEndpoint.replaceAll(':visitId', visitId);
        await _apiClient.post(
          endpoint,
          body: {
            'lat': lat,
            'lng': lng,
            'timestamp': DateTime.now().toIso8601String(),
          },
        );
        _telemetry.passGate(
          ExecutionGateCategory.domainApi,
          'Provider check-in logged successfully',
          metadata: {'visitId': visitId},
        );
      },
      onError: (Object e, StackTrace st) {
        _telemetry.failGate(
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
