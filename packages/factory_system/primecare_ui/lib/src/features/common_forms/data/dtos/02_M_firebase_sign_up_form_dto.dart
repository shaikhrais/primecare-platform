// Layer: 02_MODELS_FOUNDATION
class FirebaseSignUpFormDto {
  final String id;
  final Map<String, dynamic> raw;

  FirebaseSignUpFormDto({required this.id, required this.raw});

  factory FirebaseSignUpFormDto.fromJson(Map<String, dynamic> json) {
    return FirebaseSignUpFormDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
