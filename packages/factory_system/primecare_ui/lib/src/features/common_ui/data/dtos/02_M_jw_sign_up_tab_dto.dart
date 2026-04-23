// Layer: 02_MODELS_FOUNDATION
class JwSignUpTabDto {
  final String id;
  final Map<String, dynamic> raw;

  JwSignUpTabDto({required this.id, required this.raw});

  factory JwSignUpTabDto.fromJson(Map<String, dynamic> json) {
    return JwSignUpTabDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

