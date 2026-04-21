// Layer: 02_MODELS_FOUNDATION
class FamilyDashboardMapperAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  FamilyDashboardMapperAdapterDto({required this.id, required this.raw});

  factory FamilyDashboardMapperAdapterDto.fromJson(Map<String, dynamic> json) {
    return FamilyDashboardMapperAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
