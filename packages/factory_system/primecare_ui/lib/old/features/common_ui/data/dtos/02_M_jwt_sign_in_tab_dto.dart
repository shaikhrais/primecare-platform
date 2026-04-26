// Layer: 02_MODELS_FOUNDATION
class JwtSignInTabDto {
  final String id;
  final Map<String, dynamic> raw;

  JwtSignInTabDto({required this.id, required this.raw});

  factory JwtSignInTabDto.fromJson(Map<String, dynamic> json) {
    return JwtSignInTabDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
