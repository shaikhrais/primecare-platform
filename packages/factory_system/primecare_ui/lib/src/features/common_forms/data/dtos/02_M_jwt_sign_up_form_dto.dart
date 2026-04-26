// Layer: 02_MODELS_FOUNDATION
class JwtSignUpFormDto {
  final String id;
  final Map<String, dynamic> raw;

  JwtSignUpFormDto({required this.id, required this.raw});

  factory JwtSignUpFormDto.fromJson(Map<String, dynamic> json) {
    return JwtSignUpFormDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
