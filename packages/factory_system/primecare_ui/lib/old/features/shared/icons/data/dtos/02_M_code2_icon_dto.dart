// Layer: 02_MODELS_FOUNDATION
class Code2IconDto {
  final String id;
  final Map<String, dynamic> raw;

  Code2IconDto({required this.id, required this.raw});

  factory Code2IconDto.fromJson(Map<String, dynamic> json) {
    return Code2IconDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
