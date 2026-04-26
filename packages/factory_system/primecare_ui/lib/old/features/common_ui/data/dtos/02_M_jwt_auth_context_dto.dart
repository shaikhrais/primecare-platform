// Layer: 02_MODELS_FOUNDATION
class JwtAuthContextDto {
  final String id;
  final Map<String, dynamic> raw;

  JwtAuthContextDto({required this.id, required this.raw});

  factory JwtAuthContextDto.fromJson(Map<String, dynamic> json) {
    return JwtAuthContextDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
