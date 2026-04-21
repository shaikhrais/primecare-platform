// Layer: 02_MODELS_FOUNDATION
class ClinicDashboardViewModelAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  ClinicDashboardViewModelAdapterDto({required this.id, required this.raw});

  factory ClinicDashboardViewModelAdapterDto.fromJson(Map<String, dynamic> json) {
    return ClinicDashboardViewModelAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
