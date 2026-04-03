import 'package:dio/dio.dart';

enum ProviderRole { psw, rn, rmt, unknown }

ProviderRole _parseRole(String? type) {
  switch (type?.toUpperCase()) {
    case 'PSW': return ProviderRole.psw;
    case 'RN': return ProviderRole.rn;
    case 'RMT': return ProviderRole.rmt;
    default: return ProviderRole.unknown;
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
  final Dio _dio;

  ProviderService(this._dio);

  /// Fetches the unified provider profile natively mapped to the logged-in Identity.
  Future<ProviderProfile> getSelfProfile() async {
    try {
      // Hits the newly structured /v1/providers/ API gateway scope
      final response = await _dio.get('/v1/providers/profile/me');
      
      if (response.statusCode == 200) {
        return ProviderProfile.fromJson(response.data as Map<String, dynamic>);
      }
      throw Exception('Failed to load active provider profile: ${response.statusCode}');
    } on DioException catch (e) {
      throw Exception('Network error during provider telemetry: ${e.message}');
    }
  }

  /// Logs a check-in event using standard Unified identifiers.
  Future<void> logCheckIn(String visitId, double lat, double lng) async {
    try {
      await _dio.post('/v1/visits/$visitId/checkin', data: {
        'lat': lat,
        'lng': lng,
        'timestamp': DateTime.now().toIso8601String(),
      });
    } on DioException catch (e) {
      throw Exception('Failed to transmit standardized geo telemetry: ${e.message}');
    }
  }
}
