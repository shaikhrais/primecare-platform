// Layer: 02_MODELS_FOUNDATION
class PatientDashboardDtoAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  PatientDashboardDtoAdapterDto({required this.id, required this.raw});

  factory PatientDashboardDtoAdapterDto.fromJson(Map<String, dynamic> json) {
    return PatientDashboardDtoAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
