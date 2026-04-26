// Layer: 02_MODELS_FOUNDATION
class ToolbarThemeDto {
  final String id;
  final Map<String, dynamic> raw;

  ToolbarThemeDto({required this.id, required this.raw});

  factory ToolbarThemeDto.fromJson(Map<String, dynamic> json) {
    return ToolbarThemeDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
