// Layer: 02_MODELS_FOUNDATION
class HrHiringDashboardMapperAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  HrHiringDashboardMapperAdapterDto({required this.id, required this.raw});

  factory HrHiringDashboardMapperAdapterDto.fromJson(Map<String, dynamic> json) {
    return HrHiringDashboardMapperAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
