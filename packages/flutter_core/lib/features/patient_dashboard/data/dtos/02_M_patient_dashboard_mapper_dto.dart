// Layer: 02_MODELS_FOUNDATION
class PatientDashboardMapperDto {
  final String id;
  final Map<String, dynamic> raw;

  PatientDashboardMapperDto({required this.id, required this.raw});

  factory PatientDashboardMapperDto.fromJson(Map<String, dynamic> json) {
    return PatientDashboardMapperDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

