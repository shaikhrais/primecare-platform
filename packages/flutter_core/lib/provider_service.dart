import 'config/api_config.dart';
import 'network/api_client.dart';
import 'network/api_error.dart';

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
      id: json['provider_id'] ?? json['id'] ?? '',
      fullName: json['full_name'] ?? 'Unknown Provider',
      role: _parseRole(json['provider_type']),
      bio: json['bio'] ?? '',
      serviceAreas: json['service_areas'] ?? '',
      trustScore: json['trust_score'] ?? 100,
      isApproved: json['is_approved'] ?? false,
      avatarUrl: json['avatar_url'],
    );
  }
}

/// A unified service bridging the frontend to the backend Domain Modular Monolith structure.
/// This replaces disparate silos like RnService and PswService.
class ProviderService {
  final ApiClient _apiClient;

  ProviderService(this._apiClient);

  /// Fetches the unified provider profile natively mapped to the logged-in Identity.
  Future<ProviderProfile> getSelfProfile() async {
    try {
      // Hits the newly structured API gateway scope
      final endpoint = ApiConfig.endpoints['providerDashboard']!;
      final response = await _apiClient.get(endpoint);

      if (response.statusCode == 200) {
        return ProviderProfile.fromJson(response.data as Map<String, dynamic>);
      }
      throw Exception(
        'Failed to load active provider profile: ${response.statusCode}',
      );
    } catch (e) {
      throw Exception(ApiErrorAdapter.mapApiError(e));
    }
  }

  /// Logs a check-in event using standard Unified identifiers.
  Future<void> logCheckIn(String visitId, double lat, double lng) async {
    try {
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
    } catch (e) {
      throw Exception(ApiErrorAdapter.mapApiError(e));
    }
  }
}
