// Layer: 02_MODELS_FOUNDATION
class CommunityOutreachDashboardMapperDto {
  final String id;
  final Map<String, dynamic> raw;

  CommunityOutreachDashboardMapperDto({required this.id, required this.raw});

  factory CommunityOutreachDashboardMapperDto.fromJson(Map<String, dynamic> json) {
    return CommunityOutreachDashboardMapperDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

