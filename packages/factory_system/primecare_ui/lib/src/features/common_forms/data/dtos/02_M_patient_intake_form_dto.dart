// Layer: 02_MODELS_FOUNDATION
class PatientIntakeFormDto {
  final String id;
  final Map<String, dynamic> raw;

  PatientIntakeFormDto({required this.id, required this.raw});

  factory PatientIntakeFormDto.fromJson(Map<String, dynamic> json) {
    return PatientIntakeFormDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
