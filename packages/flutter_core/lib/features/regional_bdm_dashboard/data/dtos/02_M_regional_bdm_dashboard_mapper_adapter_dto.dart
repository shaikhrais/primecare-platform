// Layer: 02_MODELS_FOUNDATION
class RegionalBdmDashboardMapperAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  RegionalBdmDashboardMapperAdapterDto({required this.id, required this.raw});

  factory RegionalBdmDashboardMapperAdapterDto.fromJson(Map<String, dynamic> json) {
    return RegionalBdmDashboardMapperAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
