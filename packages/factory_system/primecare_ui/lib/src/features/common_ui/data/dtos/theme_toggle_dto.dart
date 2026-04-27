// Layer: 02_MODELS_FOUNDATION
class ThemeToggleDto {
  final String id;
  final Map<String, dynamic> raw;

  ThemeToggleDto({required this.id, required this.raw});

  factory ThemeToggleDto.fromJson(Map<String, dynamic> json) {
    return ThemeToggleDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
