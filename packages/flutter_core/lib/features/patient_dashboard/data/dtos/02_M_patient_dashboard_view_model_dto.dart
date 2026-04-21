// Layer: 02_MODELS_FOUNDATION
class PatientDashboardViewModelDto {
  final String id;
  final Map<String, dynamic> raw;

  PatientDashboardViewModelDto({required this.id, required this.raw});

  factory PatientDashboardViewModelDto.fromJson(Map<String, dynamic> json) {
    return PatientDashboardViewModelDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

