// Layer: 02_MODELS_FOUNDATION
class CommunityOutreachDashboardAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  CommunityOutreachDashboardAdapterDto({required this.id, required this.raw});

  factory CommunityOutreachDashboardAdapterDto.fromJson(Map<String, dynamic> json) {
    return CommunityOutreachDashboardAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
