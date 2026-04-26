// Layer: 02_MODELS_FOUNDATION
class HighlightPopoverDto {
  final String id;
  final Map<String, dynamic> raw;

  HighlightPopoverDto({required this.id, required this.raw});

  factory HighlightPopoverDto.fromJson(Map<String, dynamic> json) {
    return HighlightPopoverDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
