// Layer: 02_MODELS_FOUNDATION
class PatientDashboardMapperAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  PatientDashboardMapperAdapterDto({required this.id, required this.raw});

  factory PatientDashboardMapperAdapterDto.fromJson(Map<String, dynamic> json) {
    return PatientDashboardMapperAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
