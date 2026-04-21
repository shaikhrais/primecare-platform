// Layer: 02_MODELS_FOUNDATION
class CommunityOutreachDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  CommunityOutreachDashboardDtoDto({required this.id, required this.raw});

  factory CommunityOutreachDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return CommunityOutreachDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

