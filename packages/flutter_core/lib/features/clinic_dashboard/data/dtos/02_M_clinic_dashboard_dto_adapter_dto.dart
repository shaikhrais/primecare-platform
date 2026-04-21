// Layer: 02_MODELS_FOUNDATION
class ClinicDashboardDtoAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  ClinicDashboardDtoAdapterDto({required this.id, required this.raw});

  factory ClinicDashboardDtoAdapterDto.fromJson(Map<String, dynamic> json) {
    return ClinicDashboardDtoAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
