// Layer: 02_MODELS_FOUNDATION
class ItalicIconDto {
  final String id;
  final Map<String, dynamic> raw;

  ItalicIconDto({required this.id, required this.raw});

  factory ItalicIconDto.fromJson(Map<String, dynamic> json) {
    return ItalicIconDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
