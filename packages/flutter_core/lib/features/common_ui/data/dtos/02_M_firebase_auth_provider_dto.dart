// Layer: 02_MODELS_FOUNDATION
class FirebaseAuthProviderDto {
  final String id;
  final Map<String, dynamic> raw;

  FirebaseAuthProviderDto({required this.id, required this.raw});

  factory FirebaseAuthProviderDto.fromJson(Map<String, dynamic> json) {
    return FirebaseAuthProviderDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

