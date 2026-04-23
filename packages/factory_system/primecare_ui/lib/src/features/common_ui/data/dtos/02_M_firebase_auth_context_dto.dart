// Layer: 02_MODELS_FOUNDATION
class FirebaseAuthContextDto {
  final String id;
  final Map<String, dynamic> raw;

  FirebaseAuthContextDto({required this.id, required this.raw});

  factory FirebaseAuthContextDto.fromJson(Map<String, dynamic> json) {
    return FirebaseAuthContextDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

