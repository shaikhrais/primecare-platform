// Layer: 02_MODELS_FOUNDATION
class HighlighterIconDto {
  final String id;
  final Map<String, dynamic> raw;

  HighlighterIconDto({required this.id, required this.raw});

  factory HighlighterIconDto.fromJson(Map<String, dynamic> json) {
    return HighlighterIconDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
