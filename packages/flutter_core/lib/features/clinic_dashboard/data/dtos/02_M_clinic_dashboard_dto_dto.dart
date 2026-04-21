// Layer: 02_MODELS_FOUNDATION
class ClinicDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  ClinicDashboardDtoDto({required this.id, required this.raw});

  factory ClinicDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return ClinicDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

