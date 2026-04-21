// Layer: 02_MODELS_FOUNDATION
class CommunityOutreachDashboardViewModelDto {
  final String id;
  final Map<String, dynamic> raw;

  CommunityOutreachDashboardViewModelDto({required this.id, required this.raw});

  factory CommunityOutreachDashboardViewModelDto.fromJson(Map<String, dynamic> json) {
    return CommunityOutreachDashboardViewModelDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

