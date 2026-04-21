// Layer: 02_MODELS_FOUNDATION
class ThemesPanelDto {
  final String id;
  final Map<String, dynamic> raw;

  ThemesPanelDto({required this.id, required this.raw});

  factory ThemesPanelDto.fromJson(Map<String, dynamic> json) {
    return ThemesPanelDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

