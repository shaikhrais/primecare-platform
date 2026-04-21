// Layer: 02_MODELS_FOUNDATION
class ClinicDashboardMapperDto {
  final String id;
  final Map<String, dynamic> raw;

  ClinicDashboardMapperDto({required this.id, required this.raw});

  factory ClinicDashboardMapperDto.fromJson(Map<String, dynamic> json) {
    return ClinicDashboardMapperDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

