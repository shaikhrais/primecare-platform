// Layer: 02_MODELS_FOUNDATION
class TextAlignButtonDto {
  final String id;
  final Map<String, dynamic> raw;

  TextAlignButtonDto({required this.id, required this.raw});

  factory TextAlignButtonDto.fromJson(Map<String, dynamic> json) {
    return TextAlignButtonDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
