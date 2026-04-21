// Layer: 02_MODELS_FOUNDATION
class ClinicDashboardAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  ClinicDashboardAdapterDto({required this.id, required this.raw});

  factory ClinicDashboardAdapterDto.fromJson(Map<String, dynamic> json) {
    return ClinicDashboardAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
