// Layer: 02_MODELS_FOUNDATION
class I18nContextDto {
  final String id;
  final Map<String, dynamic> raw;

  I18nContextDto({required this.id, required this.raw});

  factory I18nContextDto.fromJson(Map<String, dynamic> json) {
    return I18nContextDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

