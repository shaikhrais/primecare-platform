// Layer: 02_MODELS_FOUNDATION
class ThemePreviewDto {
  final String id;
  final Map<String, dynamic> raw;

  ThemePreviewDto({required this.id, required this.raw});

  factory ThemePreviewDto.fromJson(Map<String, dynamic> json) {
    return ThemePreviewDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
