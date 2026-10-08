// Governance - Category: controller | Purpose: Layer: 01_INFRASTRUCTURE
// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/flutter_core.dart';

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
  final int? trustScore;
  final bool isApproved;
  final String? avatarUrl;

  ProviderProfile({
    required this.id,
    required this.fullName,
    required this.role,
    this.bio = '',
    this.serviceAreas = '',
    this.trustScore,
    this.isApproved = false,
    this.avatarUrl,
  });

  factory ProviderProfile.fromJson(Map<String, dynamic> json) {
    const fields = {
      'id',
      'full_name',
      'bio',
      'languages',
      'service_areas',
      'provider_type',
      'is_approved',
      'skills',
    };
    if (json.length != fields.length ||
        !fields.every(json.containsKey) ||
        ![
          'id',
          'full_name',
          'languages',
          'service_areas',
          'provider_type',
          'skills',
        ].every((field) => json[field] is String) ||
        (json['id'] as String).isEmpty ||
        (json['bio'] != null && json['bio'] is! String) ||
        json['is_approved'] is! bool) {
      throw const FormatException('Invalid provider profile contract');
    }
    return ProviderProfile(
      id: json['id'] as String,
      fullName: json['full_name'] as String,
      role: _parseRole(json['provider_type'] as String),
      bio: (json['bio'] as String?) ?? '',
      serviceAreas: json['service_areas'] as String,
      isApproved: json['is_approved'] as bool,
    );
  }

  factory ProviderProfile.fromResponse(Object? response) {
    if (response is! Map<String, dynamic> ||
        response.length != 1 ||
        response['profile'] is! Map<String, dynamic>) {
      throw const FormatException('Invalid provider profile envelope');
    }
    return ProviderProfile.fromJson(
      response['profile'] as Map<String, dynamic>,
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
        final endpoint = ApiConfig.endpoints['providerProfile']!;
        final response = await _apiClient.get(endpoint);

        if (response.statusCode == 200) {
          final profile = ProviderProfile.fromResponse(response.data);
          _telemetry.passGate(
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
        _telemetry.failGate(
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
