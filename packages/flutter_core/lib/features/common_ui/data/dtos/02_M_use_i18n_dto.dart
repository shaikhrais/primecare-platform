// Layer: 02_MODELS_FOUNDATION
class UseI18nDto {
  final String id;
  final Map<String, dynamic> raw;

  UseI18nDto({required this.id, required this.raw});

  factory UseI18nDto.fromJson(Map<String, dynamic> json) {
    return UseI18nDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

