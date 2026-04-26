// Layer: 02_MODELS_FOUNDATION
class UnderlineIconDto {
  final String id;
  final Map<String, dynamic> raw;

  UnderlineIconDto({required this.id, required this.raw});

  factory UnderlineIconDto.fromJson(Map<String, dynamic> json) {
    return UnderlineIconDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
