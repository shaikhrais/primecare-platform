// Layer: 02_MODELS_FOUNDATION
class ClinicDashboardMapperAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  ClinicDashboardMapperAdapterDto({required this.id, required this.raw});

  factory ClinicDashboardMapperAdapterDto.fromJson(Map<String, dynamic> json) {
    return ClinicDashboardMapperAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
