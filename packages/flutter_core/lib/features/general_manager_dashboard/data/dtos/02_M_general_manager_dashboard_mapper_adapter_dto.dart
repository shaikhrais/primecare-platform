// Layer: 02_MODELS_FOUNDATION
class GeneralManagerDashboardMapperAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  GeneralManagerDashboardMapperAdapterDto({required this.id, required this.raw});

  factory GeneralManagerDashboardMapperAdapterDto.fromJson(Map<String, dynamic> json) {
    return GeneralManagerDashboardMapperAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
