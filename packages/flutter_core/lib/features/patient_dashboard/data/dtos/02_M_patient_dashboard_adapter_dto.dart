// Layer: 02_MODELS_FOUNDATION
class PatientDashboardAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  PatientDashboardAdapterDto({required this.id, required this.raw});

  factory PatientDashboardAdapterDto.fromJson(Map<String, dynamic> json) {
    return PatientDashboardAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
