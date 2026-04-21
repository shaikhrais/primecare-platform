// Layer: 02_MODELS_FOUNDATION
class LogInfectionControlFormDto {
  final String id;
  final Map<String, dynamic> raw;

  LogInfectionControlFormDto({required this.id, required this.raw});

  factory LogInfectionControlFormDto.fromJson(Map<String, dynamic> json) {
    return LogInfectionControlFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

