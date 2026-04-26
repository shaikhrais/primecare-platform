// Layer: 02_MODELS_FOUNDATION
class LogClinicalIncidentFormDto {
  final String id;
  final Map<String, dynamic> raw;

  LogClinicalIncidentFormDto({required this.id, required this.raw});

  factory LogClinicalIncidentFormDto.fromJson(Map<String, dynamic> json) {
    return LogClinicalIncidentFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
