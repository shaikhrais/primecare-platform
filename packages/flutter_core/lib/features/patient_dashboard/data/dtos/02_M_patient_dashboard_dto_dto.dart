// Layer: 02_MODELS_FOUNDATION
class PatientDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  PatientDashboardDtoDto({required this.id, required this.raw});

  factory PatientDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return PatientDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

