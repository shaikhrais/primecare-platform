// Layer: 02_MODELS_FOUNDATION
class LightDarkModeToggleDto {
  final String id;
  final Map<String, dynamic> raw;

  LightDarkModeToggleDto({required this.id, required this.raw});

  factory LightDarkModeToggleDto.fromJson(Map<String, dynamic> json) {
    return LightDarkModeToggleDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

