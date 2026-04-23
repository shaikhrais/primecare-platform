// Layer: 02_MODELS_FOUNDATION
class FirebaseSignInTabDto {
  final String id;
  final Map<String, dynamic> raw;

  FirebaseSignInTabDto({required this.id, required this.raw});

  factory FirebaseSignInTabDto.fromJson(Map<String, dynamic> json) {
    return FirebaseSignInTabDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

