// Layer: 02_MODELS_FOUNDATION
class PatientDashboardViewModelAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  PatientDashboardViewModelAdapterDto({required this.id, required this.raw});

  factory PatientDashboardViewModelAdapterDto.fromJson(Map<String, dynamic> json) {
    return PatientDashboardViewModelAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
