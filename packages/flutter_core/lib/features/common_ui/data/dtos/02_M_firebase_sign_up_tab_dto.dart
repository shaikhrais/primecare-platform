// Layer: 02_MODELS_FOUNDATION
class FirebaseSignUpTabDto {
  final String id;
  final Map<String, dynamic> raw;

  FirebaseSignUpTabDto({required this.id, required this.raw});

  factory FirebaseSignUpTabDto.fromJson(Map<String, dynamic> json) {
    return FirebaseSignUpTabDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

