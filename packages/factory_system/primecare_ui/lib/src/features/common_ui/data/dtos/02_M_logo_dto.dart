// Layer: 02_MODELS_FOUNDATION
class LogoDto {
  final String id;
  final Map<String, dynamic> raw;

  LogoDto({required this.id, required this.raw});

  factory LogoDto.fromJson(Map<String, dynamic> json) {
    return LogoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

