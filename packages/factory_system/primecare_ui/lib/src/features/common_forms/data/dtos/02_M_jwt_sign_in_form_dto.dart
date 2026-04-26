// Layer: 02_MODELS_FOUNDATION
class JwtSignInFormDto {
  final String id;
  final Map<String, dynamic> raw;

  JwtSignInFormDto({required this.id, required this.raw});

  factory JwtSignInFormDto.fromJson(Map<String, dynamic> json) {
    return JwtSignInFormDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
