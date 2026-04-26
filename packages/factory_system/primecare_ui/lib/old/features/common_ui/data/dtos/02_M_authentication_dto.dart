// Layer: 02_MODELS_FOUNDATION
class AuthenticationDto {
  final String id;
  final Map<String, dynamic> raw;

  AuthenticationDto({required this.id, required this.raw});

  factory AuthenticationDto.fromJson(Map<String, dynamic> json) {
    return AuthenticationDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
