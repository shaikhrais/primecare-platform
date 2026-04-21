// Layer: 02_MODELS_FOUNDATION
class CommunityOutreachDashboardDtoAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  CommunityOutreachDashboardDtoAdapterDto({required this.id, required this.raw});

  factory CommunityOutreachDashboardDtoAdapterDto.fromJson(Map<String, dynamic> json) {
    return CommunityOutreachDashboardDtoAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
