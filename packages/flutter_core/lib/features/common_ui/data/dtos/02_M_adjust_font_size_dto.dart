// Layer: 02_MODELS_FOUNDATION
class AdjustFontSizeDto {
  final String id;
  final Map<String, dynamic> raw;

  AdjustFontSizeDto({required this.id, required this.raw});

  factory AdjustFontSizeDto.fromJson(Map<String, dynamic> json) {
    return AdjustFontSizeDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

