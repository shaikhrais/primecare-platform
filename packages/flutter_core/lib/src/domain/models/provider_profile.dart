import 'base_entity.dart';
// Governance - Category: controller | Purpose: Layer: 01_INFRASTRUCTURE
// Layer: 01_INFRASTRUCTURE

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

class ProviderProfile extends BaseEntity<String> {
  final String fullName;
  final ProviderRole role;
  final String bio;
  final String serviceAreas;
  final int? trustScore;
  final bool isApproved;
  final String? avatarUrl;

  ProviderProfile({
    required super.id,
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
