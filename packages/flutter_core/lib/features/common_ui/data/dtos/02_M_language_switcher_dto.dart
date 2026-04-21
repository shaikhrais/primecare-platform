// Layer: 02_MODELS_FOUNDATION
class LanguageSwitcherDto {
  final String id;
  final Map<String, dynamic> raw;

  LanguageSwitcherDto({required this.id, required this.raw});

  factory LanguageSwitcherDto.fromJson(Map<String, dynamic> json) {
    return LanguageSwitcherDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

