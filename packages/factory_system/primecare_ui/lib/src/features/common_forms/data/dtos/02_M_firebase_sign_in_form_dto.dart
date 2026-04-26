// Layer: 02_MODELS_FOUNDATION
class FirebaseSignInFormDto {
  final String id;
  final Map<String, dynamic> raw;

  FirebaseSignInFormDto({required this.id, required this.raw});

  factory FirebaseSignInFormDto.fromJson(Map<String, dynamic> json) {
    return FirebaseSignInFormDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
