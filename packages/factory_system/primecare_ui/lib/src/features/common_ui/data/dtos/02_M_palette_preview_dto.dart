// Layer: 02_MODELS_FOUNDATION
class PalettePreviewDto {
  final String id;
  final Map<String, dynamic> raw;

  PalettePreviewDto({required this.id, required this.raw});

  factory PalettePreviewDto.fromJson(Map<String, dynamic> json) {
    return PalettePreviewDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

