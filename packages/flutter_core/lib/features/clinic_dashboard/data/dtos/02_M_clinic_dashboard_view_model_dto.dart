// Layer: 02_MODELS_FOUNDATION
class ClinicDashboardViewModelDto {
  final String id;
  final Map<String, dynamic> raw;

  ClinicDashboardViewModelDto({required this.id, required this.raw});

  factory ClinicDashboardViewModelDto.fromJson(Map<String, dynamic> json) {
    return ClinicDashboardViewModelDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

