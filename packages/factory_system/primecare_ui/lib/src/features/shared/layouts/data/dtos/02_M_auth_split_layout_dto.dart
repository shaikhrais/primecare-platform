// Layer: 02_MODELS_FOUNDATION
class AuthSplitLayoutDto {
  final String id;
  final Map<String, dynamic> raw;

  AuthSplitLayoutDto({required this.id, required this.raw});

  factory AuthSplitLayoutDto.fromJson(Map<String, dynamic> json) {
    return AuthSplitLayoutDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
