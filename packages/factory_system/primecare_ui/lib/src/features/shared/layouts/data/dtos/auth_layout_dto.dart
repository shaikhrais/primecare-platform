// Layer: 02_MODELS_FOUNDATION
class AuthLayoutDto {
  final String id;
  final Map<String, dynamic> raw;

  AuthLayoutDto({required this.id, required this.raw});

  factory AuthLayoutDto.fromJson(Map<String, dynamic> json) {
    return AuthLayoutDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
