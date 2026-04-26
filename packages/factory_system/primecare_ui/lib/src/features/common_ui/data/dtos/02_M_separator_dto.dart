// Layer: 02_MODELS_FOUNDATION
class SeparatorDto {
  final String id;
  final Map<String, dynamic> raw;

  SeparatorDto({required this.id, required this.raw});

  factory SeparatorDto.fromJson(Map<String, dynamic> json) {
    return SeparatorDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
